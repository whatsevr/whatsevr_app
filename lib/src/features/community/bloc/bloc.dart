import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import 'package:whatsevr_app/src/features/account/views/page.dart';
import 'package:whatsevr_app/src/features/community/views/page.dart';

import '../../../../config/api/methods/users.dart';
import '../../../../config/api/response_model/profile_details.dart';
import '../../../../config/api/response_model/user_flicks.dart';
import '../../../../config/api/response_model/user_memories.dart';
import '../../../../config/api/response_model/user_offers.dart';
import '../../../../config/api/response_model/user_video_posts.dart';
import '../../../../config/services/auth_db.dart';

part 'event.dart';
part 'state.dart';

class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  CommunityBloc() : super(const CommunityState()) {
    on<InitialEvent>(_onInitial);
    on<LoadCommunityData>(_onLoadCommunityData);
  }

  FutureOr<void> _onInitial(
    InitialEvent event,
    Emitter<CommunityState> emit,
  ) async {
    try {
      emit(state.copyWith(
        isEditMode: event.accountPageArgument?.isEditMode ?? false,
        // userUid: event.accountPageArgument?.communityUid ??
        userUid: AuthUserDb.getLastLoggedUserUid(),
      ));

      add(LoadCommunityData());
    } catch (e) {
      SmartDialog.showToast('$e');
    }
  }

  FutureOr<void> _onLoadCommunityData(
      LoadCommunityData event, Emitter<CommunityState> emit) async {
    try {
      final ProfileDetailsResponse? profileDetailsResponse =
          await UsersApi.getProfileDetails(userUid: state.userUid!);
      emit(
        state.copyWith(
          profileDetailsResponse: profileDetailsResponse,
        ),
      );
      final UserVideoPostsResponse? userVideoPostsResponse =
          await UsersApi.getVideoPosts(userUid: state.userUid!);
      final UserFlicksResponse? userFlicksResponse =
          await UsersApi.getFLicks(userUid: state.userUid!);
      final UserMemoriesResponse? userMemoriesResponse =
          await UsersApi.getMemories(userUid: state.userUid!);
      final UserOffersResponse? userOffersResponse =
          await UsersApi.getOfferPosts(userUid: state.userUid!);

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
