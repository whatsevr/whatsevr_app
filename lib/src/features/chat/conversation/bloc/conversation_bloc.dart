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
  final _typingStatusController = PublishSubject<SetTypingStatus>();

  ConversationBloc(this._currentUserUid) : super(const ConversationState()) {
    on<InitialEvent>(_onInitialEvent);
  
    on<LoadMessages>(_onLoadMessages);
    on<SendMessage>(_onSendMessage);
 
    on<SetTypingStatus>(_onSetTypingStatus);
    on<DeleteMessage>(_onDeleteMessage);
    on<EditMessage>(_onEditMessage);

 
    on<UpdateMessages>(_onUpdateMessages);


    _typingStatusController
        .debounceTime(Duration(milliseconds: 500))
        .listen((event) => _updateTypingStatus(event));
  }
  Future<void> _onInitialEvent(
    InitialEvent event,
    Emitter<ConversationState> emit,
  ) async {
    print('Initializing ChatBloc');

    await _chatSubscription1?.cancel();

  
    _chatSubscription1 = RemoteDb.supabaseClient1
        .from('private_chats')
        .stream(primaryKey: ['uid']) // Ensure primary key is 'uid'
        .eq('user1_uid', _currentUserUid)
        .order('last_message_at', ascending: false)
        .listen(
          (chats) {
         
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
      if (!event.loadMore) {
        emit(
          state.copyWith(
            messageStatus: MessageStatus.loading,
            messages: [],
          ),
        );
      }

      // Cancel existing subscription
      await _messageSubscription?.cancel();

      _messageSubscription = RemoteDb.supabaseClient1
          .from('chat_messages') // Ensure table name is 'chat_messages'
          .stream(primaryKey: ['uid']) // Ensure primary key is 'uid'
          .eq('chat_id', event.chatId)
          .order('created_at', ascending: false)
          .limit(50)
          .map((rows) {
            return rows.map((row) => ChatMessage.fromMap(row)).toList();
          })
          .listen(
            (messages) => add(UpdateMessages(messages, event.loadMore)),
            onError: (error) {
              highLevelCatch(error, StackTrace.current);
            },
          );
    } catch (error) {
      emit(
        state.copyWith(
          messageStatus: MessageStatus.error,
        ),
      );
    }
  }

  Future<void> _onSendMessage(
    SendMessage event,
    Emitter<ConversationState> emit,
  ) async {
    try {
      emit(state.copyWith(messageStatus: MessageStatus.sending));

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
            .from('chat_messages') // Ensure table name is 'chat_messages'
            .insert({
              'chat_type': event.chatType, // Use event.chatType
              'sender_uid': _currentUserUid,
              'message': event.content,
              'created_at': DateTime.now().toIso8601String(),
              'updated_at': DateTime.now().toIso8601String(),
            })
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
          .from('chats')
          .update({'last_message': response}).eq('uid', event.chatId);

      emit(
        state.copyWith(
          messageStatus: MessageStatus.sent,
          messages: newMessages,
        ),
      );
    } catch (error) {
      // Remove optimistic message on error

      emit(
        state.copyWith(
          messageStatus: MessageStatus.error,
        ),
      );
    }
  }


  Future<void> _onSetTypingStatus(
    SetTypingStatus event,
    Emitter<ConversationState> emit,
  ) async {
    _typingStatusController.add(event);
  }

  Future<void> _updateTypingStatus(SetTypingStatus event) async {
    try {
      await RemoteDb.supabaseClient1.from('typing_status').upsert({
        'chat_id': event.chatId,
        'user_id': _currentUserUid,
        'is_typing': event.isTyping,
      });
    } catch (error) {
      // Silently fail typing status updates
      print('Error updating typing status: $error');
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
          .from('chat_messages') // Ensure table name is 'chat_messages'
          .delete()
          .eq('uid', event.messageId) // Ensure 'uid' is used
          .eq(
            'sender_uid',
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
          .from('chat_messages')
          .update({
            'content': event.newContent,
            'is_edited': true,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', event.messageId)
          .eq(
            'sender_uid',
            _currentUserUid,
          ); // Ensure user owns message
    } catch (error) {
      // Restore messages on error
    }
  }



  void _onUpdateMessages(UpdateMessages event, Emitter<ConversationState> emit) {
    if (event.isLoadMore) {
      emit(
        state.copyWith(
          messages: [...state.messages, ...event.messages],
          messageStatus: MessageStatus.sent,
          isLoadingMore: false,
        ),
      );
    } else {
      emit(
        state.copyWith(
          messages: event.messages,
          messageStatus: MessageStatus.sent,
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
    _typingStatusController.close();
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
