import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import 'package:whatsevr_app/config/api/methods/community.dart';
import 'package:whatsevr_app/config/api/methods/posts.dart';
import 'package:whatsevr_app/config/api/response_model/community/community_details.dart';
import 'package:whatsevr_app/src/features/account/views/page.dart';
import 'package:whatsevr_app/src/features/community/views/page.dart';

import 'package:whatsevr_app/config/api/methods/users.dart';
import 'package:whatsevr_app/config/api/response_model/profile_details.dart';
import 'package:whatsevr_app/config/api/response_model/user_flicks.dart';
import 'package:whatsevr_app/config/api/response_model/user_memories.dart';
import 'package:whatsevr_app/config/api/response_model/user_offers.dart';
import 'package:whatsevr_app/config/api/response_model/user_video_posts.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';

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
      emit(
        state.copyWith(
          isEditMode: event.communityPageArgument?.isEditMode ?? false,
          communityUid: event.communityPageArgument?.communityUid,
        ),
      );

      add(LoadCommunityData());
    } catch (e) {
      SmartDialog.showToast('$e');
    }
  }

  FutureOr<void> _onLoadCommunityData(
    LoadCommunityData event,
    Emitter<CommunityState> emit,
  ) async {
    try {
      final CommunityProfileDataResponse? profileDetailsResponse =
          await CommunityApi.getCommunityDetails(
        communityUid: state.communityUid!,
      );
      emit(
        state.copyWith(
          communityDetailsResponse: profileDetailsResponse,
        ),
      );
      final UserVideoPostsResponse? userVideoPostsResponse =
          await PostApi.getVideoPosts(communityUid: state.communityUid!);

      final UserMemoriesResponse? userMemoriesResponse =
          await PostApi.getMemories(communityUid: state.communityUid!);

      emit(
        state.copyWith(
          communityVideoPosts: userVideoPostsResponse?.videoPosts ?? [],
          communityMemories: userMemoriesResponse?.memories ?? [],
        ),
      );
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }
}
