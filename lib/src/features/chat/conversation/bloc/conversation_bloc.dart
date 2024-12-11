import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase/supabase.dart' hide User;
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import 'package:whatsevr_app/config/api/external/models/pagination_data.dart';
import 'package:whatsevr_app/config/api/methods/chats.dart';
import 'package:whatsevr_app/config/api/response_model/chats/chat_messages.dart';
import 'package:whatsevr_app/config/services/supabase.dart';
import 'package:whatsevr_app/src/features/chat/conversation/views/page.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  final String _currentUserUid;

  RealtimeChannel? _chatMessageInsertAndUpdateChannel;
  RealtimeChannel? _chatMessageDeleteChannel;

  String? _currentChatId;

  ConversationBloc(this._currentUserUid) : super(const ConversationState()) {
    on<InitialEvent>(_onInitialEvent);
    on<LoadMessages>(_onLoadMessages);
    on<SubscribeToMessageInserAndUpdateEvent>(
      _onSubscribeToMessageInserAndUpdate,
    );
    on<RemoteMessagesInsertOrUpdateEvent>(_onRemoteMessageChanges);
    on<RemoteMessageDeletedEvent>(_onRemoteMessageDeleted);
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

    emit(
      state.copyWith(
        isCommunity: event.pageArguments?.isCommunity,
        communityUid: event.pageArguments?.communityUid,
        privateChatUid: event.pageArguments?.privateChatUid,
        title: event.pageArguments?.title,
        profilePicture: event.pageArguments?.profilePicture,
      ),
    );

    add(LoadMessages());
    add(SubscribeToMessageInserAndUpdateEvent());
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
      emit(
        state.copyWith(
          messages: response?.messages,
        ),
      );
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
      emit(
        state.copyWith(
          messages: [
            optimisticMessage,
            ...state.messages,
          ],
        ),
      );

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
        message: event.content,
        privateChatUid: state.isCommunity ? null : state.privateChatUid,
        communityUid: state.isCommunity ? state.communityUid : null,
      );
    } catch (e, s) {
      // Remove optimistic message on error
      emit(
        state.copyWith(
          messages: [
            ...state.messages.where((m) => !m.uid!.startsWith('temp_')),
          ],
        ),
      );
      highLevelCatch(e, s);
    }
  }

  Future<void> _onDeleteMessage(
    DeleteMessage event,
    Emitter<ConversationState> emit,
  ) async {
    final List<Message> currentMessages = state.messages;
    try {
      emit(
        state.copyWith(
          messages:
              currentMessages.where((m) => m.uid != event.messageUid).toList(),
        ),
      );

      await ChatsApi.deleteChatMessage(
        messageUid: event.messageUid!,
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
  Future<void> close() {
    _chatMessageInsertAndUpdateChannel?.unsubscribe();

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

  FutureOr<void> _onSubscribeToMessageInserAndUpdate(
    SubscribeToMessageInserAndUpdateEvent event,
    Emitter<ConversationState> emit,
  ) async {
    try {
      _chatMessageInsertAndUpdateChannel?.unsubscribe();
      if (state.isCommunity) {
        _chatMessageInsertAndUpdateChannel = RemoteDb.supabaseClient1
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
                final Message newMessage = Message.fromMap(payload.newRecord);
                add(
                  RemoteMessagesInsertOrUpdateEvent(
                    newMessage: newMessage,
                  ),
                );
              },
            )
            .subscribe();
      } else {
        _chatMessageInsertAndUpdateChannel = RemoteDb.supabaseClient1
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
              callback: (PostgresChangePayload payload) {
                final Message newMessage = Message.fromMap(payload.newRecord);

                add(
                  RemoteMessagesInsertOrUpdateEvent(
                    newMessage: newMessage,
                  ),
                );
              },
            )
            .subscribe();
      }
      _chatMessageDeleteChannel?.unsubscribe();
      _chatMessageDeleteChannel = RemoteDb.supabaseClient1
          .channel(
            'chat_messages_delete:private_chat_uid=${state.privateChatUid}',
          )
          .onPostgresChanges(
            event: PostgresChangeEvent.delete,
            schema: 'public',
            table: 'chat_messages',
            callback: (PostgresChangePayload payload) {
              print('Chat message delete detected');
              final String? deletedMessageUid =
                  payload.oldRecord['uid'] as String?;
              if (deletedMessageUid != null) {
                add(
                  RemoteMessageDeletedEvent(
                    deletedMessageUid: deletedMessageUid,
                  ),
                );
              }
            },
          )
          .subscribe();
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _onRemoteMessageChanges(
    RemoteMessagesInsertOrUpdateEvent event,
    Emitter<ConversationState> emit,
  ) async {
    try {
      final newOrUpdatedMessage = event.newMessage;
      if (newOrUpdatedMessage == null) return;

      // Remove any temporary messages
      final filteredMessages =
          state.messages.where((m) => !m.uid!.startsWith('temp_')).toList();

      // Check if message exists to determine if it's an update
      final existingIndex =
          filteredMessages.indexWhere((m) => m.uid == newOrUpdatedMessage.uid);

      if (existingIndex != -1) {
        // Update scenario
        filteredMessages[existingIndex] = newOrUpdatedMessage;
      } else {
        // New message scenario - add to beginning since newest first
        filteredMessages.insert(0, newOrUpdatedMessage);
      }

      // Sort messages by creation date (newest first)
      filteredMessages.sort(
        (a, b) => (b.createdAt ?? DateTime.now())
            .compareTo(a.createdAt ?? DateTime.now()),
      );

      emit(state.copyWith(messages: filteredMessages));
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _onRemoteMessageDeleted(
    RemoteMessageDeletedEvent event,
    Emitter<ConversationState> emit,
  ) async {
    try {
      final deletedMessageUid = event.deletedMessageUid;
      if (deletedMessageUid == null) return;

      final filteredMessages =
          state.messages.where((m) => m.uid != deletedMessageUid).toList();

      emit(state.copyWith(messages: filteredMessages));
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }
}
