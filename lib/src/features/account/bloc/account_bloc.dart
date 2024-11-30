import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import 'package:whatsevr_app/config/api/methods/posts.dart';
import 'package:whatsevr_app/src/features/account/views/page.dart';

import 'package:whatsevr_app/config/api/methods/users.dart';
import 'package:whatsevr_app/config/api/response_model/profile_details.dart';
import 'package:whatsevr_app/config/api/response_model/user_flicks.dart';
import 'package:whatsevr_app/config/api/response_model/user_memories.dart';
import 'package:whatsevr_app/config/api/response_model/user_offers.dart';
import 'package:whatsevr_app/config/api/response_model/user_video_posts.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(const AccountState()) {
    on<AccountInitialEvent>(_onInitial);
    on<LoadAccountData>(_onLoadAccountData);
  }

  FutureOr<void> _onInitial(
    AccountInitialEvent event,
    Emitter<AccountState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          isEditMode: event.accountPageArgument?.isEditMode ?? false,
          userUid: event.accountPageArgument?.userUid ??
              AuthUserDb.getLastLoggedUserUid(),
        ),
      );

      add(LoadAccountData());
    } catch (e) {
      SmartDialog.showToast('$e');
    }
  }

  FutureOr<void> _onLoadAccountData(
    LoadAccountData event,
    Emitter<AccountState> emit,
  ) async {
    try {
      final ProfileDetailsResponse? profileDetailsResponse =
          await UsersApi.getProfileDetails(userUid: state.userUid!);
      emit(
        state.copyWith(
          profileDetailsResponse: profileDetailsResponse,
        ),
      );
      final UserVideoPostsResponse? userVideoPostsResponse =
          await PostApi.getVideoPosts(userUid: state.userUid!);
      final UserFlicksResponse? userFlicksResponse =
          await PostApi.getFlicks(userUid: state.userUid!);
      final UserMemoriesResponse? userMemoriesResponse =
          await PostApi.getMemories(userUid: state.userUid!);
      final UserOffersResponse? userOffersResponse =
          await PostApi.getOfferPosts(userUid: state.userUid!);

      emit(
        state.copyWith(
          userVideoPosts: userVideoPostsResponse?.videoPosts ?? [],
          userFlicks: userFlicksResponse?.flicks ?? [],
          userMemories: userMemoriesResponse?.memories ?? [],
          userOffers: userOffersResponse?.offerPosts ?? [],
        ),
      );
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }
}
