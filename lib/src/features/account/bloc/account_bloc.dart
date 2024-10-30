import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../../../config/api/methods/users.dart';
import '../../../../config/api/response_model/profile_details.dart';
import '../../../../config/api/response_model/user_flicks.dart';
import '../../../../config/api/response_model/user_memories.dart';
import '../../../../config/api/response_model/user_offers.dart';
import '../../../../config/api/response_model/user_video_posts.dart';
import '../../../../config/services/auth_db.dart';

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
      final userUid = AuthUserDb.getLastLoggedUserUid();
      if (userUid == null) return;
      final profileDetailsResponse =
          await UsersApi.getProfileDetails(userUid: userUid);
      emit(
        state.copyWith(
          profileDetailsResponse: profileDetailsResponse,
        ),
      );
      final userVideoPostsResponse =
          await UsersApi.getVideoPosts(userUid: userUid);
      final userFlicksResponse =
          await UsersApi.getFLicks(userUid: userUid);
      final userMemoriesResponse =
          await UsersApi.getMemories(userUid: userUid);
      final userOffersResponse =
          await UsersApi.getOfferPosts(userUid: userUid);

      emit(
        state.copyWith(
          userVideoPosts: userVideoPostsResponse?.videoPosts ?? [],
          userFlicks: userFlicksResponse?.flicks ?? [],
          userMemories: userMemoriesResponse?.memories ?? [],
          userOffers: userOffersResponse?.offerPosts ?? [],
        ),
      );
    } catch (e) {
      SmartDialog.showToast('$e');
    }
  }
}
