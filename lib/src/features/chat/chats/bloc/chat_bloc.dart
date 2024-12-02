import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:supabase/supabase.dart' hide User;
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import 'package:whatsevr_app/config/api/response_model/chats/user_community_chats.dart';
import 'package:whatsevr_app/config/api/response_model/chats/user_private_chats.dart';
import 'package:whatsevr_app/config/services/supabase.dart';

import 'package:whatsevr_app/config/api/methods/chats.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends HydratedBloc<ChatEvent, ChatState> {
  final String _currentUserUid;
  RealtimeChannel? _chatSubscription1;
  RealtimeChannel? _chatSubscription2;
  RealtimeChannel? _communitySubscription1;

  ChatBloc(this._currentUserUid) : super(const ChatState()) {
    on<InitialEvent>(_onInitialEvent);
    on<LoadPrivateChats>(_onLoadPrivateChats);
    on<LoadCommunities>(_onLoadCommunities);
    on<SubscribeToChatChanges>(_onSubscribeToChatChanges);
  }
  Future<void> _onInitialEvent(
    InitialEvent event,
    Emitter<ChatState> emit,
  ) async {
    print('Initializing ChatBloc');
    add(LoadPrivateChats());
    add(LoadCommunities());
    add(SubscribeToChatChanges());
  }

  Future<void> _onLoadPrivateChats(
      LoadPrivateChats event, Emitter<ChatState> emit,) async {
    try {
      final UserPrivateChatsResponse? response =
          await ChatsApi.getUserPrivateChats(
        userUid: _currentUserUid,
      );

      emit(state.copyWith(privateChats: response?.chats));
    } catch (e, s) {
      highLevelCatch(e, s);
    }
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
    _chatSubscription1?.unsubscribe();
    _chatSubscription2?.unsubscribe();
    _communitySubscription1?.unsubscribe();

    return super.close();
  }

  bool isOwner(String adminUserUid) {
    return adminUserUid == _currentUserUid;
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

  FutureOr<void> _onLoadCommunities(
      LoadCommunities event, Emitter<ChatState> emit,) async {
    try {
      final response = await ChatsApi.getUserCommunityChats(
        userUid: _currentUserUid,
      );

      emit(state.copyWith(communities: response?.communities));
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _onSubscribeToChatChanges(
      SubscribeToChatChanges event, Emitter<ChatState> emit,) async {
    await _chatSubscription1?.unsubscribe();
    await _chatSubscription2?.unsubscribe();
    await _communitySubscription1?.unsubscribe();
    _chatSubscription1 = RemoteDb.supabaseClient1
        .channel('public:private_chats:user1_uid=$_currentUserUid')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          filter: PostgresChangeFilter(
              type: PostgresChangeFilterType.eq,
              column: 'user1_uid',
              value: _currentUserUid,),
          schema: 'public',
          table: 'private_chats',
          callback: (PostgresChangePayload payload) {
            print('ChatBloc: Received private chat change');
            add(LoadPrivateChats());
          },
        )
        .subscribe();
    _chatSubscription2 = RemoteDb.supabaseClient1
        .channel('public:private_chats:user2_uid=$_currentUserUid')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          filter: PostgresChangeFilter(
              type: PostgresChangeFilterType.eq,
              column: 'user2_uid',
              value: _currentUserUid,),
          schema: 'public',
          table: 'private_chats',
          callback: (PostgresChangePayload payload) {
            print('ChatBloc: Received private chat change');
            add(LoadPrivateChats());
          },
        )
        .subscribe();
    _communitySubscription1 = RemoteDb.supabaseClient1
        .channel('public:communities:user_uid=$_currentUserUid')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'communities',
          callback: (PostgresChangePayload payload) {
            print('ChatBloc: Received community change');
            add(LoadCommunities());
          },
        )
        .subscribe();
  }
}
