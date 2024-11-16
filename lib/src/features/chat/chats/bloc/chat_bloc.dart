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
import 'package:whatsevr_app/src/features/chat/models/communities.dart';
import 'package:whatsevr_app/src/features/chat/models/private_chat.dart';
import 'package:whatsevr_app/src/features/chat/models/chat_message.dart';
import 'package:whatsevr_app/src/features/chat/models/whatsevr_user.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
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
      final List<String> userOwnedCommunities = [];
      final List<String> userJoinedCommunities = [];
      //get all the communities the user owns
      final response1 = await RemoteDb.supabaseClient1
          .from('communities')
          .select('uid')
          .eq('admin_user_uid', _currentUserUid);
      userOwnedCommunities.addAll(response1.map((row) => row['uid'] as String));
      //get all the communities the user has joined
      final response2 = await RemoteDb.supabaseClient1
          .from('community_members')
          .select('community_uid')
          .eq('user_uid', _currentUserUid);
      userJoinedCommunities
          .addAll(response2.map((row) => row['community_uid'] as String));
      //above two lists will be used to query the communities
      final response = await RemoteDb.supabaseClient1
          .from('communities')
          .select()
          .inFilter('uid', [
        ...userOwnedCommunities,
        ...userJoinedCommunities
      ]).order('created_at', ascending: false);
      final List<Community> communities =
          response.map((row) => Community.fromMap(row)).toList();
      emit(
        state.copyWith(
          communities: communities,
        ),
      );
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }
}
