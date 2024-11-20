import 'dart:async';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase/supabase.dart' hide User;
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:retry/retry.dart';
import 'package:rxdart/rxdart.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import 'package:whatsevr_app/config/api/external/models/pagination_data.dart';
import 'package:whatsevr_app/config/bloc_helpers/bloc_event_debounce.dart';
import 'package:whatsevr_app/config/services/supabase.dart';
import 'package:whatsevr_app/src/features/chat/conversation/views/page.dart';
import 'package:whatsevr_app/src/features/chat/models/private_chat.dart';
import 'package:whatsevr_app/src/features/chat/models/chat_message.dart';
import 'package:whatsevr_app/src/features/chat/models/whatsevr_user.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc
    extends HydratedBloc<ConversationEvent, ConversationState> {
  final String _currentUserUid;

  StreamSubscription? _messageSubscription;

  ConversationBloc(this._currentUserUid) : super(const ConversationState()) {
    on<InitialEvent>(_onInitialEvent);
    on<LoadMoreMessages>(_onLoadMoreMessages, transformer: blocEventDebounce());
    on<SendMessage>(_onSendMessage);
    on<DeleteMessage>(_onDeleteMessage);
    on<EditMessage>(_onEditMessage);
  }

  void _setupMessageSubscription() {
    _messageSubscription?.cancel();
    if (state.isCommunity) {
      _messageSubscription = RemoteDb.supabaseClient1
          .from('chat_messages')
          .stream(primaryKey: ['uid'])
          .eq('community_uid', state.communityUid!)
          .order('created_at',
              ascending: false) // Changed to false for reverse chronological
          .listen(
            (data) {
              final messages = data.map((m) => ChatMessage.fromMap(m)).toList();
              emit(state.copyWith(messages: messages));
            },
            onError: (error) => print('Error in message stream: $error'),
          );
    } else {
      _messageSubscription = RemoteDb.supabaseClient1
          .from('chat_messages')
          .stream(primaryKey: ['uid'])
          .eq('private_chat_uid', state.privateChatUid!)
          .order('created_at',
              ascending: false) // Changed to false for reverse chronological
          .listen(
            (data) {
              final messages = data.map((m) => ChatMessage.fromMap(m)).toList();
              emit(state.copyWith(messages: messages));
            },
            onError: (error) => print('Error in message stream: $error'),
          );
    }
  }

  Future<void> _onInitialEvent(
    InitialEvent event,
    Emitter<ConversationState> emit,
  ) async {
    emit(state.copyWith(
      isCommunity: event.pageArguments?.isCommunity,
      communityUid: event.pageArguments?.communityUid,
      privateChatUid: event.pageArguments?.privateChatUid,
      title: event.pageArguments?.title,
      profilePicture: event.pageArguments?.profilePicture,
    ));

    // Setup initial subscriptions
    _setupMessageSubscription();

    // Load available users if community
    if (event.pageArguments?.isCommunity == true) {
      final membersResponse = await RemoteDb.supabaseClient1
          .from('community_members')
          .select('user:user_uid(*)')
          .eq('community_uid', event.pageArguments!.communityUid!);

      final List<WhatsevrUser> members =
          membersResponse.map((m) => WhatsevrUser.fromMap(m['user'])).toList();

      emit(state.copyWith(chatMembers: members));
    }
  }

  Future<void> _onLoadMoreMessages(
    LoadMoreMessages event,
    Emitter<ConversationState> emit,
  ) async {
    try {
      // Mark loading

      final query = RemoteDb.supabaseClient1.from('chat_messages').select();

      if (state.isCommunity) {
        query.eq('community_uid', state.communityUid!);
      } else {
        query.eq('private_chat_uid', state.privateChatUid!);
      }

      if (state.messages.isNotEmpty) {
        query.lt(
            'created_at', state.messages.last.createdAt!.toIso8601String());
      }

      final response = await query;
      final messages = response.map((m) => ChatMessage.fromMap(m)).toList();

      emit(state.copyWith(
        messages: [...state.messages, ...messages],
      ));
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  Future<void> _onSendMessage(
    SendMessage event,
    Emitter<ConversationState> emit,
  ) async {
    try {
      if( event.content.isEmpty) return;
      final optimisticMessage = ChatMessage(
        uid: 'temp_${DateTime.now().millisecondsSinceEpoch}',
        senderUid: _currentUserUid,
        message: event.content,
        createdAt: DateTime.now(),
        communityUid: state.isCommunity ? state.communityUid : null,
        privateChatUid: state.isCommunity ? null : state.privateChatUid,
        replyToMessageUid:  event.replyToMessageUid,
      );

      // Insert at the beginning of the list since newest messages should be first
      emit(state.copyWith(
        messages: [...state.messages, optimisticMessage],
      ));
      return;
      final messageData = {
        'sender_uid': _currentUserUid,
        'message': event.content,
        if(event.replyToMessageUid != null) 'reply_to_message_uid': event.replyToMessageUid,
        if(state.isCommunity) 'community_uid': state.communityUid,
        if( !state.isCommunity) 'private_chat_uid': state.privateChatUid,
        
      };

      await RemoteDb.supabaseClient1
          .from('chat_messages')
          .insert(messageData)
          .select()
          .single();
    } catch (e, s) {
      // Remove optimistic message on error
      emit(state.copyWith(
        messages: [
          ...state.messages.where((m) => !m.uid!.startsWith('temp_')),
        ],
      ));
      highLevelCatch(e, s);
    }
  }

  Future<void> _onDeleteMessage(
    DeleteMessage event,
    Emitter<ConversationState> emit,
  ) async {
    final List<ChatMessage> currentMessages = state.messages;
    try {
      emit(state.copyWith(
        messages:
            currentMessages.where((m) => m.uid != event.messageUid).toList(),
      ));

      await RemoteDb.supabaseClient1
          .from('chat_messages')
          .delete()
          .eq('uid', event.messageUid)
          .eq('sender_uid', _currentUserUid);
    } catch (e, s) {
      emit(state.copyWith(messages: currentMessages));
      highLevelCatch(e, s);
    }
  }

  Future<void> _onEditMessage(
    EditMessage event,
    Emitter<ConversationState> emit,
  ) async {
    try {
      final messageIndex =
          state.messages.indexWhere((m) => m.uid == event.messageId);
      if (messageIndex == -1) return;

      final updatedMessages = [...state.messages];
      updatedMessages[messageIndex] = updatedMessages[messageIndex].copyWith(
        message: event.newContent,
      );

      emit(state.copyWith(messages: updatedMessages));

      await RemoteDb.supabaseClient1
          .from('chat_messages')
          .update({
            'message': event.newContent,
            'is_edited': true,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('uid', event.messageId)
          .eq('sender_uid', _currentUserUid);
    } catch (error) {
      print('Error editing message: $error');
    }
  }

  @override
  ConversationState fromJson(Map<String, dynamic> json) {
    try {
      return ConversationState.fromJson(json);
    } catch (_) {
      return const ConversationState();
    }
  }

  @override
  Map<String, dynamic> toJson(ConversationState state) {
    return state.toJson();
  }

  @override
  Future<void> close() {
    _messageSubscription?.cancel();

    return super.close();
  }

  User? getTheOtherUser(User? user1, User? user2) {
    if (user1 == null || user2 == null) {
      return null;
    }
    if (user1.uid == _currentUserUid) {
      return user2;
    } else {
      return user1;
    }
  }
}
