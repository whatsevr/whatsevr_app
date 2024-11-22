import 'dart:async';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase/supabase.dart' hide User;
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:retry/retry.dart';
import 'package:rxdart/rxdart.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import 'package:whatsevr_app/config/api/response_model/chats/user_community_chats.dart';
import 'package:whatsevr_app/config/api/response_model/chats/user_private_chats.dart';
import 'package:whatsevr_app/config/services/supabase.dart';

import 'package:whatsevr_app/config/api/methods/chats.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends HydratedBloc<ChatEvent, ChatState> {
  final String _currentUserUid;
  StreamSubscription? _chatSubscription1;
  StreamSubscription? _chatSubscription2;
  StreamSubscription? _communitySubscription1;

  ChatBloc(this._currentUserUid) : super(const ChatState()) {
    on<InitialEvent>(_onInitialEvent);
    on<LoadPrivateChats>(_onLoadPrivateChats);
    on<LoadCommunities>(_onLoadCommunities);
  }
  Future<void> _onInitialEvent(
    InitialEvent event,
    Emitter<ChatState> emit,
  ) async {
    print('Initializing ChatBloc');

    await _chatSubscription1?.cancel();

    await _chatSubscription2?.cancel();
    await _communitySubscription1?.cancel();
    _chatSubscription1 = RemoteDb.supabaseClient1
        .from('private_chats')
        .stream(primaryKey: ['uid']) // Ensure primary key is 'uid'
        .eq('user1_uid', _currentUserUid)
        .order('last_message_at', ascending: false)
        .listen(
          (chats) {
            add(LoadPrivateChats());
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
            add(LoadPrivateChats());
          },
          onError: (error) {
            highLevelCatch(error, StackTrace.current);
          },
        );

    _communitySubscription1 = RemoteDb.supabaseClient1
        .from('communities')
        .stream(primaryKey: ['uid']) // Ensure primary key is 'uid'

        .listen(
      (communities) {
        add(LoadCommunities());
      },
      onError: (error) {
        highLevelCatch(error, StackTrace.current);
      },
    );
  }

  Future<void> _onLoadPrivateChats(
      LoadPrivateChats event, Emitter<ChatState> emit) async {
    try {
      final UserPrivateChatsResponse? response =
          await ChatsApi.getUserPrivateChats(
        userUid: _currentUserUid,
      );

      if (response?.chats != null) {
        final List<Chat> updatedPrivateChats = [
          ...state.privateChats,
          ...response!.chats!,
        ];

        emit(state.copyWith(privateChats: updatedPrivateChats));
      }
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
    _chatSubscription1?.cancel();
    _chatSubscription2?.cancel();
    _communitySubscription1?.cancel();

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
      LoadCommunities event, Emitter<ChatState> emit) async {
    try {
      final response = await ChatsApi.getUserCommunityChats(
        userUid: _currentUserUid,
        communityUid: '', // Empty string to get all communities
      );

      if (response?.communities != null) {
        final List<Community> communities = response!.communities!
            .map((community) => Community.fromMap(community.toMap()))
            .toList();

        emit(state.copyWith(communities: communities));
      }
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }
}
