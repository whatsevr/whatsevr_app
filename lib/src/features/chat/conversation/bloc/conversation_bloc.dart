import 'dart:async';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase/supabase.dart' hide User;
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:retry/retry.dart';
import 'package:rxdart/rxdart.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import 'package:whatsevr_app/config/services/supabase.dart';
import 'package:whatsevr_app/src/features/chat/conversation/views/page.dart';
import 'package:whatsevr_app/src/features/chat/models/private_chat.dart';
import 'package:whatsevr_app/src/features/chat/models/chat_message.dart';
import 'package:whatsevr_app/src/features/chat/models/whatsevr_user.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  final String _currentUserUid;
  StreamSubscription? _chatSubscription1;

  StreamSubscription? _messageSubscription;
  StreamSubscription? _typingSubscription;

  ConversationBloc(this._currentUserUid) : super(const ConversationState()) {
    on<InitialEvent>(_onInitialEvent);

    on<LoadMessages>(_onLoadMessages);
    on<SendMessage>(_onSendMessage);

  
    on<DeleteMessage>(_onDeleteMessage);
    on<EditMessage>(_onEditMessage);

    on<UpdateMessages>(_onUpdateMessages);

  
  }

  Future<void> _onInitialEvent(
    InitialEvent event,
    Emitter<ConversationState> emit,
  ) async {
    print('Initializing ChatBloc');
    emit(state.copyWith(
      isCommunity: event.pageArguments?.isCommunity,
      communityUid: event.pageArguments?.communityUid,
      privateChatUid: event.pageArguments?.privateChatUid,
      title: event.pageArguments?.title,
      profilePicture: event.pageArguments?.profilePicture,
    ));
    await _chatSubscription1?.cancel();

    _chatSubscription1 = RemoteDb.supabaseClient1
        .from('private_chats')
        .stream(primaryKey: ['uid']) // Ensure primary key is 'uid'
        .eq('user1_uid', _currentUserUid)
        .order('last_message_at', ascending: false)
        .listen(
          (chats) {
            add(LoadMessages());
          },
          onError: (error) {
            highLevelCatch(error, StackTrace.current);
          },
        );
  }

  Future<void> _onLoadMessages(
    LoadMessages event,
    Emitter<ConversationState> emit,
  ) async {
    try {
      PostgrestTransformBuilder<PostgrestList> query;
      if (state.isCommunity) {
        query = RemoteDb.supabaseClient1
            .from('chat_messages')
            .select()
            .eq('community_uid', state.communityUid!)
            .order('created_at', ascending: false)
            .limit(50);
      } else {
        query = RemoteDb.supabaseClient1
            .from('chat_messages')
            .select()
            .eq('private_chat_uid', state.privateChatUid!)
            .order('created_at', ascending: false)
            .limit(50);
      }
      final response = await query; 

      final chatMessages = response.map((m) => ChatMessage.fromMap(m)).toList();

      
    } catch (error,s) {
    
      highLevelCatch (error, s);
    }
  }

  Future<void> _onSendMessage(
    SendMessage event,
    Emitter<ConversationState> emit,
  ) async {
    try {
     
      // Create optimistic message
      final optimisticMessage = ChatMessage(
        uid: 'temp_${DateTime.now().millisecondsSinceEpoch}',
        chatType: event.chatType, // Use event.chatType
        senderUid: _currentUserUid,
        message: event.content,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),

        // Add this line
      );

      // Add optimistic message to state
      final updatedMessages = [optimisticMessage, ...state.messages];
      emit(state.copyWith(messages: updatedMessages));

      // Actually send the message with retry mechanism
      final response = await retry(
        () => RemoteDb.supabaseClient1
            .from('') // Ensure table name is 'chat_messages'
            .insert({})
            .select()
            .single()
            .timeout(Duration(seconds: 5)),
        retryIf: (e) => e is TimeoutException || e is SocketException,
      );

      // Remove optimistic message and add real message
      final realMessage = ChatMessage.fromMap(response);
      final newMessages = [
        ...state.messages.where((m) => m.uid != optimisticMessage.uid),
        realMessage,
      ];

      // Update chat's last_message
      await RemoteDb.supabaseClient1
          .from('')
          .update({'': response}).eq('', event.chatId);

      emit(
        state.copyWith(
          
          messages: newMessages,
        ),
      );
    } catch (error) {
      // Remove optimistic message on error

      emit(
        state.copyWith(
        
        ),
      );
    }
  }




  Future<void> _onDeleteMessage(
    DeleteMessage event,
    Emitter<ConversationState> emit,
  ) async {
    try {
      // Store current messages for potential rollback
      final currentMessages = state.messages;

      // Update state with message removed
      emit(
        state.copyWith(
          messages:
              state.messages.where((m) => m.uid != event.messageId).toList(),
        ),
      );

      // Actually delete the message
      await RemoteDb.supabaseClient1
          .from('') // Ensure table name is 'chat_messages'
          .delete()
          .eq('uid', event.messageId) // Ensure 'uid' is used
          .eq(
            '',
            _currentUserUid,
          ); // Ensure user owns message
    } catch (error) {
      // Restore messages on error
    }
  }

  Future<void> _onEditMessage(
    EditMessage event,
    Emitter<ConversationState> emit,
  ) async {
    try {
      // Store current messages for potential rollback
      final currentMessages = [...state.messages];
      final messageIndex =
          currentMessages.indexWhere((m) => m.uid == event.messageId);

      if (messageIndex == -1) {
        throw Exception('Message not found');
      }

      // Create updated message list
      final updatedMessages = [...currentMessages];
      updatedMessages[messageIndex] = updatedMessages[messageIndex].copyWith(
        message: event.newContent,
        isEdited: true,
        updatedAt: DateTime.now(),
      );

      // Update state
      emit(
        state.copyWith(
          messages: updatedMessages,
        ),
      );

      // Actually update the message
      await RemoteDb.supabaseClient1
          .from('')
          .update({
            '': event.newContent,
            '': true,
            '': DateTime.now().toIso8601String(),
          })
          .eq('', event.messageId)
          .eq(
            '',
            _currentUserUid,
          ); // Ensure user owns message
    } catch (error) {
      // Restore messages on error
    }
  }

  void _onUpdateMessages(
      UpdateMessages event, Emitter<ConversationState> emit) {
    if (event.isLoadMore) {
      emit(
        state.copyWith(
          messages: [...state.messages, ...event.messages],
        
          isLoadingMore: false,
        ),
      );
    } else {
      emit(
        state.copyWith(
          messages: event.messages,
          
        ),
      );
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
    _chatSubscription1?.cancel();
    _messageSubscription?.cancel();
    _typingSubscription?.cancel();
   
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




