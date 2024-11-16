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
import 'package:whatsevr_app/src/features/chat/models/message.dart';
import 'package:whatsevr_app/src/features/chat/models/user.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  
  final String _currentUserUid;
  StreamSubscription? _chatSubscription1;
  StreamSubscription? _chatSubscription2;
  StreamSubscription? _messageSubscription;
  StreamSubscription? _typingSubscription;
  final _typingStatusController = PublishSubject<SetTypingStatus>();

  ChatBloc(this._currentUserUid) : super(const ChatState()) {
    on<InitialEvent>(_onInitialEvent);
    on<LoadChats>(_onLoadChats);
    on<LoadMessages>(_onLoadMessages);
    on<SendMessage>(_onSendMessage);
    on<CreateDirectChat>(_onCreateDirectChat);
    on<CreateGroupChat>(_onCreateGroupChat);
    on<SelectChat>(_onSelectChat);
    on<SetTypingStatus>(_onSetTypingStatus);
    on<DeleteMessage>(_onDeleteMessage);
    on<EditMessage>(_onEditMessage);
    on<LoadAvailableUsers>(_onLoadAvailableUsers);
    on<UpdateChats>(_onUpdateChats);
    on<UpdateMessages>(_onUpdateMessages);
    on<UpdateTypingUsers>(_onUpdateTypingUsers);

    _typingStatusController
        .debounceTime(Duration(milliseconds: 500))
        .listen((event) => _updateTypingStatus(event));
  }
  Future<void> _onInitialEvent(
    InitialEvent event,
    Emitter<ChatState> emit,
  ) async {
    print('Initializing ChatBloc');

    await _chatSubscription1?.cancel();

    await _chatSubscription2?.cancel();
    _chatSubscription1 = RemoteDb.supabaseClient1
        .from('private_chats')
        .stream(primaryKey: ['uid']) // Ensure primary key is 'uid'
        .eq('user1_uid', _currentUserUid)
        .order('last_message_at', ascending: false)
        .listen(
          (chats) {
            add(LoadChats());
          },
          onError: (error) {
            highLevelCatch(error, StackTrace.current);
          },
        );
    _chatSubscription2 = RemoteDb.supabaseClient1
        .from('private_chats')
        .stream(primaryKey: ['uid']) // Ensure primary key is 'uid'
        .eq('user2_uid', _currentUserUid)
        .order('last_message_at', ascending: false)
        .listen(
          (chats) {
           add(LoadChats());
          },
          onError: (error) {
            highLevelCatch(error, StackTrace.current);
          },
        );
  }

  Future<void> _onLoadChats(LoadChats event, Emitter<ChatState> emit) async {
    try {
      //get all chats
      final response = await RemoteDb.supabaseClient1
          .from('private_chats')
          .select(
            '*, user1:users!private_chats_user1_uid_fkey(*), user2:users!private_chats_user2_uid_fkey(*)',
          )
          .or('user1_uid.eq.$_currentUserUid,user2_uid.eq.$_currentUserUid')
          .order('last_message_at', ascending: false);

      final List<PrivateChat> privateChats =
          response.map((row) => PrivateChat.fromMap(row)).toList();

      emit(
        state.copyWith(
          privateChats: privateChats,
        ),
      );
      // Cancel any existing subscription
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  Future<void> _onLoadMessages(
    LoadMessages event,
    Emitter<ChatState> emit,
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
    Emitter<ChatState> emit,
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

  Future<void> _onCreateDirectChat(
    CreateDirectChat event,
    Emitter<ChatState> emit,
  ) async {
    try {
      // Check if chat already exists
      final existingChat = await RemoteDb.supabaseClient1
          .from('chats')
          .select('*, chat_participants(*)')
          .eq('is_group', false)
          .contains(
        'chat_participants',
        [_currentUserUid, event.otherUserId],
      ).maybeSingle();

      if (existingChat != null) {
        final chat = PrivateChat.fromMap(existingChat);
        emit(
          state.copyWith(
            selectedChat: chat,
          ),
        );
        return;
      }

      // Create new chat
      final response = await RemoteDb.supabaseClient1
          .from('chats')
          .insert({
            'created_by': _currentUserUid,
            'is_group': false,
          })
          .select()
          .single();

      // Add participants
      await RemoteDb.supabaseClient1.from('chat_participants').insert([
        {
          'chat_id': response['id'],
          'user_id': _currentUserUid,
          'is_admin': true,
        },
        {
          'chat_id': response['id'],
          'user_id': event.otherUserId,
          'is_admin': false,
        },
      ]);

      final chat = PrivateChat.fromMap(response);
      emit(
        state.copyWith(
          selectedChat: chat,
        ),
      );
    } catch (error) {}
  }

  Future<void> _onCreateGroupChat(
    CreateGroupChat event,
    Emitter<ChatState> emit,
  ) async {
    try {
      // Create new group chat
      final response = await RemoteDb.supabaseClient1
          .from('chats')
          .insert({
            'created_by': _currentUserUid,
            'chat_name': event.name,
            'is_group': true,
          })
          .select()
          .single();

      // Add participants
      final participants = event.participantIds
          .map(
            (userId) => {
              'chat_id': response['uid'], // Ensure 'uid' is used
              'user_id': userId,
              'is_admin': userId == _currentUserUid, // Use  _currentUserUid,
            },
          )
          .toList();

      await RemoteDb.supabaseClient1.from('chat_participants').insert(participants);

      final chat = PrivateChat.fromMap(response);
      emit(
        state.copyWith(
          selectedChat: chat,
        ),
      );
    } catch (error) {}
  }

  Future<void> _onLoadAvailableUsers(
    LoadAvailableUsers event,
    Emitter<ChatState> emit,
  ) async {
    try {
      final response = await RemoteDb.supabaseClient1.from('users').select().neq(
            'id',
            _currentUserUid,
          );

      final users = response.map((row) => WhatsevrUser.fromMap(row)).toList();

      emit(state.copyWith(availableUsers: users));
    } catch (error) {}
  }

  void _onSelectChat(SelectChat event, Emitter<ChatState> emit) {
    emit(state.copyWith(selectedChat: event.chat));
    add(LoadMessages(event.chat.uid!));
  }

  Future<void> _onSetTypingStatus(
    SetTypingStatus event,
    Emitter<ChatState> emit,
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
    Emitter<ChatState> emit,
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
    Emitter<ChatState> emit,
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

  void _onUpdateChats(UpdateChats event, Emitter<ChatState> emit) {
    emit(
      state.copyWith(
        privateChats: event.chats,
      ),
    );
  }

  void _onUpdateMessages(UpdateMessages event, Emitter<ChatState> emit) {
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

  void _onUpdateTypingUsers(UpdateTypingUsers event, Emitter<ChatState> emit) {
    final updatedTypingUsers =
        Map<String, List<WhatsevrUser>>.from(state.typingUsers);
    updatedTypingUsers[event.chatId] = event.users;

    emit(state.copyWith(typingUsers: updatedTypingUsers));
  }

  @override
  ChatState fromJson(Map<String, dynamic> json) {
    try {
      return ChatState.fromJson(json);
    } catch (_) {
      return const ChatState();
    }
  }

  @override
  Map<String, dynamic> toJson(ChatState state) {
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
