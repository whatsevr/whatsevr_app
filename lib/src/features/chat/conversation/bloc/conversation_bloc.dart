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
import 'package:whatsevr_app/config/api/methods/chats.dart';
import 'package:whatsevr_app/config/api/response_model/chats/chat_messages.dart';
import 'package:whatsevr_app/config/bloc_helpers/bloc_event_debounce.dart';
import 'package:whatsevr_app/config/services/supabase.dart';
import 'package:whatsevr_app/src/features/chat/conversation/views/page.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc
    extends Bloc<ConversationEvent, ConversationState> {
  final String _currentUserUid;

  RealtimeChannel? _chatMessageChannel;

  String? _currentChatId;

  ConversationBloc(this._currentUserUid) : super(const ConversationState()) {
    on<InitialEvent>(_onInitialEvent);
    on<LoadMessages>(_onLoadMessages, transformer: blocEventDebounce());
    on<MessageChangesEvent>(_onMessageChanges);
    on<LoadLatestMessages>(_onLoadLatestMessages);
    on<SendMessage>(_onSendMessage);
    on<DeleteMessage>(_onDeleteMessage);
    on<EditMessage>(_onEditMessage);
  }

  Future<void> _onInitialEvent(
    InitialEvent event,
    Emitter<ConversationState> emit,
  ) async {
    _currentChatId = event.pageArguments?.isCommunity == true
        ? event.pageArguments?.communityUid
        : event.pageArguments?.privateChatUid;

    emit(state.copyWith(
      isCommunity: event.pageArguments?.isCommunity,
      communityUid: event.pageArguments?.communityUid,
      privateChatUid: event.pageArguments?.privateChatUid,
      title: event.pageArguments?.title,
      profilePicture: event.pageArguments?.profilePicture,
    ));

    add(LoadMessages());
    add(MessageChangesEvent());
  }

  Future<void> _onLoadMessages(
    LoadMessages event,
    Emitter<ConversationState> emit,
  ) async {
    try {
      final ChatMessagesResponse? response = await ChatsApi.getChatMessages(
        communityUid: state.isCommunity ? state.communityUid : null,
        privateChatUid: state.isCommunity ? null : state.privateChatUid,
      );
      emit(state.copyWith(
        messages: response?.messages,
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
      if (event.content.isEmpty) return;
      final optimisticMessage = Message(
        uid: 'temp_${DateTime.now().millisecondsSinceEpoch}',
        senderUid: _currentUserUid,
        message: event.content,
        createdAt: DateTime.now(),
        communityUid: state.isCommunity ? state.communityUid : null,
        privateChatUid: state.isCommunity ? null : state.privateChatUid,
        replyToMessageUid: event.replyToMessageUid,
      );

      // Insert at the beginning of the list since newest messages should be first
      emit(state.copyWith(
        messages: [
          optimisticMessage,
          ...state.messages,
        ],
      ));

      final messageData = {
        'sender_uid': _currentUserUid,
        'message': event.content,
        if (event.replyToMessageUid != null)
          'reply_to_message_uid': event.replyToMessageUid,
        if (state.isCommunity) 'community_uid': state.communityUid,
        if (!state.isCommunity) 'private_chat_uid': state.privateChatUid,
      };

      await ChatsApi.sendChatMessage(
        senderUid: _currentUserUid,
        message:  event.content,
        privateChatUid: state.isCommunity ? null : state.privateChatUid,
        communityUid: state.isCommunity ? state.communityUid : null,
      );
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
    final List<Message> currentMessages = state.messages;
    try {
      emit(state.copyWith(
        messages:
            currentMessages.where((m) => m.uid != event.messageUid).toList(),
      ));

      await ChatsApi.deleteChatMessage(
        messageUid: event.messageUid,
        senderUid: _currentUserUid,
      );
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

      await ChatsApi.editChatMessage(
        messageUid: event.messageId,
        senderUid: _currentUserUid,
        newMessage: event.newContent,
      );
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  @override
  ConversationState fromJson(Map<String, dynamic> json) {
    try {
      if (_currentChatId == null) return const ConversationState();
      return ConversationState.fromJson(json, _currentChatId!);
    } catch (_) {
      return const ConversationState();
    }
  }

  @override
  Map<String, dynamic>? toJson(ConversationState state) {
    if (state.communityUid == null && state.privateChatUid == null) return null;
    return state.toJson();
  }

  @override
  Future<void> close() {
    _chatMessageChannel?.unsubscribe();

    return super.close();
  }

  Sender? getTheOtherUser(Sender? user1, Sender? user2) {
    if (user1 == null || user2 == null) {
      return null;
    }
    if (user1.uid == _currentUserUid) {
      return user2;
    } else {
      return user1;
    }
  }

  FutureOr<void> _onMessageChanges(
      MessageChangesEvent event, Emitter<ConversationState> emit) async {
    try {
      _chatMessageChannel?.unsubscribe();
      if (state.isCommunity) {
        _chatMessageChannel = RemoteDb.supabaseClient1
            .channel('chat_messages:community_uid=${state.communityUid}')
            .onPostgresChanges(
              event: PostgresChangeEvent.all,
              filter: PostgresChangeFilter(
                type: PostgresChangeFilterType.eq,
                column: 'community_uid',
                value: state.communityUid,
              ),
              schema: 'public',
              table: 'chat_messages',
              callback: (payload) {
                print('Chat message change detected');
                add(LoadLatestMessages());
              },
            )
            .subscribe();
      } else {
        _chatMessageChannel = RemoteDb.supabaseClient1
            .channel('chat_messages:private_chat_uid=${state.privateChatUid}')
            .onPostgresChanges(
              event: PostgresChangeEvent.all,
              filter: PostgresChangeFilter(
                type: PostgresChangeFilterType.eq,
                column: 'private_chat_uid',
                value: state.privateChatUid,
              ),
              schema: 'public',
              table: 'chat_messages',
              callback: (payload) {
                add(LoadLatestMessages());
              },
            )
            .subscribe();
      }
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _onLoadLatestMessages(
      LoadLatestMessages event, Emitter<ConversationState> emit) async {
    try {
      final Message? lastMessage =
          state.messages.isNotEmpty ? state.messages.first : null;

      final ChatMessagesResponse? response = await ChatsApi.getChatMessages(
        communityUid: state.isCommunity ? state.communityUid : null,
        privateChatUid: state.isCommunity ? null : state.privateChatUid,
        createdAfter: lastMessage?.createdAt,
      );
      final List<Message> newMessages = response?.messages ?? [];
      emit(state.copyWith(
        messages: [
          ...newMessages,
          ...state.messages,
        ],
      ));
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }
}
