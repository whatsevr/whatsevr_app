import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:whatsevr_app/config/api/methods/users.dart';
import 'package:whatsevr_app/config/api/response_model/profile_details.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';

import '../../../../config/api/response_model/user_flicks.dart';
import '../../../../config/api/response_model/user_video_posts.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(const AccountState()) {
    on<AccountInitialEvent>(_onInitial);
  }

  FutureOr<void> _onInitial(
    AccountInitialEvent event,
    Emitter<AccountState> emit,
  ) async {
    try {
      String? userUid = await AuthUserDb.getLastLoggedUserUid();
      if (userUid == null) return;
      ProfileDetailsResponse? profileDetailsResponse =
          await UsersApi.getProfileDetails(userUid: userUid);
      emit(
        state.copyWith(
          profileDetailsResponse: profileDetailsResponse,
        ),
      );
      UserVideoPostsResponse? userVideoPostsResponse =
          await UsersApi.getVideoPosts(userUid: userUid);
      UserFlicksResponse? userFlicksResponse =
          await UsersApi.getFLicks(userUid: userUid);
      emit(
        state.copyWith(
          userVideoPosts: userVideoPostsResponse?.videoPosts ?? [],
          userFlicks: userFlicksResponse?.flicks ?? [],
        ),
      );
    } catch (e) {
      SmartDialog.showToast('$e');
    }
  }
}
