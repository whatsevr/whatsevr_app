import 'dart:async';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase/supabase.dart' hide User;
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:retry/retry.dart';
import 'package:rxdart/rxdart.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import 'package:whatsevr_app/src/features/chat/models/private_chat.dart';
import 'package:whatsevr_app/src/features/chat/models/message.dart';
import 'package:whatsevr_app/src/features/chat/models/user.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final SupabaseClient _supabase = SupabaseClient(
    'https://dxvbdpxfzdpgiscphujy.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImR4dmJkcHhmemRwZ2lzY3BodWp5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTA3ODQ3NzksImV4cCI6MjAyNjM2MDc3OX0.9I-obmOReMg-jCrgzpGHTNVqtHSp8VCh1mYyaTjFG-A',
  );
  final String _currentUserUid;
  StreamSubscription? _chatSubscription1;
  StreamSubscription? _chatSubscription2;
  StreamSubscription? _messageSubscription;



  ChatBloc(this._currentUserUid) : super(const ChatState()) {
    on<InitialEvent>(_onInitialEvent);
    on<LoadChats>(_onLoadChats);


  }
  Future<void> _onInitialEvent(
    InitialEvent event,
    Emitter<ChatState> emit,
  ) async {
    print('Initializing ChatBloc');

    await _chatSubscription1?.cancel();

    await _chatSubscription2?.cancel();
    _chatSubscription1 = _supabase
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
    _chatSubscription2 = _supabase
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
      final response = await _supabase
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
