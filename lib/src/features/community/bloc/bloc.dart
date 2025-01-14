import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import 'package:whatsevr_app/config/api/methods/community.dart';
import 'package:whatsevr_app/config/api/methods/posts.dart';
import 'package:whatsevr_app/config/api/methods/tag_registry.dart';
import 'package:whatsevr_app/config/api/response_model/community/community_details.dart';
import 'package:whatsevr_app/src/features/community/views/page.dart';

import 'package:whatsevr_app/config/api/response_model/post/memories.dart';
import 'package:whatsevr_app/config/api/response_model/post/offers.dart';
import 'package:whatsevr_app/config/api/response_model/post/video_posts.dart';
import 'package:whatsevr_app/config/api/response_model/post/mix_content.dart';
import 'package:whatsevr_app/config/api/response_model/tag_registry/community_tagged_content.dart';

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

      final UserAndCommunityVideoPostsResponse? videoPosts =
          await PostApi.getVideoPosts(communityUid: state.communityUid!);
      final UserAndCommunityMemoriesResponse? memories =
          await PostApi.getMemories(communityUid: state.communityUid!);
      final UserAndCommunityOffersResponse? offers =
          await PostApi.getOfferPosts(communityUid: state.communityUid!);
      final UserAndCommunityMixContentResponse? mixContent =
          await PostApi.getMixContent(communityUid: state.communityUid!);
      final CommunityTaggedContentResponse? communityTaggedContent =
          await TagRegistryApi.getCommunityTaggedContent(
        communityUid: state.communityUid!,
        page: 1,
      );

      emit(
        state.copyWith(
          communityVideoPosts: videoPosts?.wtvs ?? [],
          communityMemories: memories?.memories ?? [],
          communityOffers: offers?.offerPosts ?? [],
          communityMixContent: mixContent?.mixContent ?? [],
          communityTaggedContent: communityTaggedContent?.taggedContent ?? [],
        ),
      );
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }
}
