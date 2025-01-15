import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import 'package:whatsevr_app/config/api/external/models/pagination_data.dart';
import 'package:whatsevr_app/config/api/methods/private_recommendations.dart';
import 'package:whatsevr_app/config/api/response_model/private_recommendation/memories.dart';
import 'package:whatsevr_app/config/api/response_model/private_recommendation/mix_community_content.dart';
import 'package:whatsevr_app/config/api/response_model/private_recommendation/mix_content.dart';
import 'package:whatsevr_app/config/api/response_model/private_recommendation/offers.dart';
import 'package:whatsevr_app/config/api/response_model/private_recommendation/photo_posts.dart';
import 'package:whatsevr_app/config/api/response_model/private_recommendation/videos.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';
import 'package:whatsevr_app/config/api/methods/tracked_activities.dart';
import 'package:whatsevr_app/config/api/response_model/tracked_activities/user_tracked_activities.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc()
      : super(
          const HomeState(),
        ) {
    on<HomeInitialEvent>(_onInitial);
    on<LoadVideosEvent>(_loadVideos);
    on<LoadMoreVideosEvent>(_onLoadMoreVideos);
    on<LoadMemoriesEvent>(_loadMemories);
    on<LoadMoreMemoriesEvent>(_onLoadMoreMemories);
    on<LoadOffersEvent>(_loadOffers);
    on<LoadMoreOffersEvent>(_onLoadMoreOffers);
    on<LoadPhotoPostsEvent>(_loadPhotoPosts);
    on<LoadMorePhotoPostsEvent>(_onLoadMorePhotoPosts);
    on<LoadMixContentEvent>(_loadMixContent);
    on<LoadMoreMixContentEvent>(_onLoadMoreMixContent);
    on<LoadTrackedActivitiesEvent>(_loadTrackedActivities);
    on<LoadMoreTrackedActivitiesEvent>(_onLoadMoreTrackedActivities);
    on<LoadMixCommunityContentEvent>(_loadMixCommunityContent);
    on<LoadMoreMixCommunityContentEvent>(_onLoadMoreMixCommunityContent);
  }

  Future<void> _onInitial(
    HomeInitialEvent event,
    Emitter<HomeState> emit,
  ) async {
    add(LoadVideosEvent());
    add(LoadMemoriesEvent());
    add(LoadOffersEvent());
    add(LoadPhotoPostsEvent());
    add(LoadMixContentEvent());
    add(LoadMixCommunityContentEvent());
  }

  FutureOr<void> _loadVideos(
    LoadVideosEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final PrivateRecommendationVideosResponse? recommendationVideos =
          await PrivateRecommendationApi.getVideoPosts(
        page: 1,
        userUid: AuthUserDb.getLastLoggedUserUid()!,
      );
      emit(
        state.copyWith(
          recommendationVideos: recommendationVideos?.recommendedVideos,
          videoPaginationData: state.videoPaginationData.copyWith(
            isLoading: false,
            currentPage: 1,
            isLastPage: recommendationVideos?.lastPage,
          ),
        ),
      );
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _onLoadMoreVideos(
    LoadMoreVideosEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state.videoPaginationData.isLoading == true ||
        state.videoPaginationData.noMoreData == true) {
      return;
    }
    try {
      emit(
        state.copyWith(
          videoPaginationData:
              state.videoPaginationData.copyWith(isLoading: true),
        ),
      );
      final PrivateRecommendationVideosResponse? recommendationVideos =
          await PrivateRecommendationApi.getVideoPosts(
        page: event.page!,
        userUid: AuthUserDb.getLastLoggedUserUid()!,
      );

      emit(
        state.copyWith(
          recommendationVideos: state.recommendationVideos +
              (recommendationVideos?.recommendedVideos ?? []),
          videoPaginationData: state.videoPaginationData.copyWith(
            currentPage: event.page,
            isLoading: false,
            isLastPage: recommendationVideos?.lastPage,
          ),
        ),
      );
    } catch (e, s) {
      emit(
        state.copyWith(
          videoPaginationData: state.videoPaginationData.copyWith(
            isLoading: false,
          ),
        ),
      );
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _loadMemories(
    LoadMemoriesEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final PrivateRecommendationMemoriesResponse? recommendationMemories =
          await PrivateRecommendationApi.getMemories(
        page: 1,
        userUid: AuthUserDb.getLastLoggedUserUid()!,
      );
      emit(
        state.copyWith(
          recommendationMemories: recommendationMemories?.recommendedMemories,
          memoryPaginationData: state.memoryPaginationData.copyWith(
            isLoading: false,
            currentPage: 1,
            isLastPage: recommendationMemories?.lastPage,
          ),
        ),
      );
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _onLoadMoreMemories(
    LoadMoreMemoriesEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state.memoryPaginationData.isLoading == true ||
        state.memoryPaginationData.noMoreData == true) {
      return;
    }
    try {
      emit(
        state.copyWith(
          memoryPaginationData:
              state.memoryPaginationData.copyWith(isLoading: true),
        ),
      );
      final PrivateRecommendationMemoriesResponse? recommendationMemories =
          await PrivateRecommendationApi.getMemories(
        page: event.page!,
        userUid: AuthUserDb.getLastLoggedUserUid()!,
      );

      emit(
        state.copyWith(
          recommendationMemories: state.recommendationMemories +
              (recommendationMemories?.recommendedMemories ?? []),
          memoryPaginationData: state.memoryPaginationData.copyWith(
            currentPage: event.page,
            isLoading: false,
            isLastPage: recommendationMemories?.lastPage,
          ),
        ),
      );
    } catch (e, s) {
      emit(
        state.copyWith(
          memoryPaginationData: state.memoryPaginationData.copyWith(
            isLoading: false,
          ),
        ),
      );
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _loadOffers(
    LoadOffersEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final PrivateRecommendationOffersResponse? recommendationOffers =
          await PrivateRecommendationApi.getOffers(
        page: 1,
        userUid: AuthUserDb.getLastLoggedUserUid()!,
      );
      emit(
        state.copyWith(
          recommendationOffers: recommendationOffers?.recommendedOffers,
          offersPaginationData: state.offersPaginationData.copyWith(
            isLoading: false,
            currentPage: 1,
            isLastPage: recommendationOffers?.lastPage,
          ),
        ),
      );
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _onLoadMoreOffers(
    LoadMoreOffersEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state.offersPaginationData.isLoading == true ||
        state.offersPaginationData.noMoreData == true) {
      return;
    }
    try {
      emit(
        state.copyWith(
          offersPaginationData:
              state.offersPaginationData.copyWith(isLoading: true),
        ),
      );
      final PrivateRecommendationOffersResponse? recommendationOffers =
          await PrivateRecommendationApi.getOffers(
        page: event.page!,
        userUid: AuthUserDb.getLastLoggedUserUid()!,
      );

      emit(
        state.copyWith(
          recommendationOffers: state.recommendationOffers +
              (recommendationOffers?.recommendedOffers ?? []),
          offersPaginationData: state.offersPaginationData.copyWith(
            currentPage: event.page,
            isLoading: false,
            isLastPage: recommendationOffers?.lastPage,
          ),
        ),
      );
    } catch (e, s) {
      emit(
        state.copyWith(
          offersPaginationData: state.offersPaginationData.copyWith(
            isLoading: false,
          ),
        ),
      );
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _loadPhotoPosts(
    LoadPhotoPostsEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final PrivateRecommendationPhotoPostsResponse? recommendationPhotoPosts =
          await PrivateRecommendationApi.getPhotoPosts(
        page: 1,
        userUid: AuthUserDb.getLastLoggedUserUid()!,
      );
      emit(
        state.copyWith(
          recommendationPhotoPosts:
              recommendationPhotoPosts?.recommendedPhotoPosts,
          photoPostPaginationData: state.photoPostPaginationData.copyWith(
            isLoading: false,
            currentPage: 1,
            isLastPage: recommendationPhotoPosts?.lastPage,
          ),
        ),
      );
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _onLoadMorePhotoPosts(
    LoadMorePhotoPostsEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state.photoPostPaginationData.isLoading == true ||
        state.photoPostPaginationData.noMoreData == true) {
      return;
    }
    try {
      emit(
        state.copyWith(
          photoPostPaginationData:
              state.photoPostPaginationData.copyWith(isLoading: true),
        ),
      );
      final PrivateRecommendationPhotoPostsResponse? recommendationPhotoPosts =
          await PrivateRecommendationApi.getPhotoPosts(
        page: event.page!,
        userUid: AuthUserDb.getLastLoggedUserUid()!,
      );

      emit(
        state.copyWith(
          recommendationPhotoPosts: state.recommendationPhotoPosts +
              (recommendationPhotoPosts?.recommendedPhotoPosts ?? []),
          photoPostPaginationData: state.photoPostPaginationData.copyWith(
            currentPage: event.page,
            isLoading: false,
            isLastPage: recommendationPhotoPosts?.lastPage,
          ),
        ),
      );
    } catch (e, s) {
      emit(
        state.copyWith(
          photoPostPaginationData: state.photoPostPaginationData.copyWith(
            isLoading: false,
          ),
        ),
      );
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _loadMixContent(
    LoadMixContentEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final PrivateRecommendationMixContentResponse? mixContentResponse =
          await PrivateRecommendationApi.getMixContent(
        page: 1,
        userUid: AuthUserDb.getLastLoggedUserUid()!,
      );
      emit(
        state.copyWith(
          mixContent: mixContentResponse?.mixContent,
          mixContentPaginationData: state.mixContentPaginationData.copyWith(
            isLoading: false,
            currentPage: 1,
            isLastPage: mixContentResponse?.lastPage,
          ),
        ),
      );
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _onLoadMoreMixContent(
    LoadMoreMixContentEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state.mixContentPaginationData.isLoading == true ||
        state.mixContentPaginationData.noMoreData == true) {
      return;
    }
    try {
      emit(
        state.copyWith(
          mixContentPaginationData:
              state.mixContentPaginationData.copyWith(isLoading: true),
        ),
      );
      final PrivateRecommendationMixContentResponse? mixContentResponse =
          await PrivateRecommendationApi.getMixContent(
        page: event.page!,
        userUid: AuthUserDb.getLastLoggedUserUid()!,
      );

      emit(
        state.copyWith(
          mixContent: state.mixContent + (mixContentResponse?.mixContent ?? []),
          mixContentPaginationData: state.mixContentPaginationData.copyWith(
            currentPage: event.page,
            isLoading: false,
            isLastPage: mixContentResponse?.lastPage,
          ),
        ),
      );
    } catch (e, s) {
      emit(
        state.copyWith(
          mixContentPaginationData: state.mixContentPaginationData.copyWith(
            isLoading: false,
          ),
        ),
      );
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _loadTrackedActivities(
    LoadTrackedActivitiesEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final UserTrackedActivitiesResponse? trackedActivities =
          await TrackedActivityApi.getUserActivities(
        userUid: AuthUserDb.getLastLoggedUserUid()!,
        page: 1,
      );
      emit(
        state.copyWith(
          trackedActivities: trackedActivities?.activities,
          trackedActivitiesPaginationData:
              state.trackedActivitiesPaginationData.copyWith(
            isLoading: false,
            currentPage: 1,
            isLastPage: trackedActivities?.lastPage,
          ),
        ),
      );
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _onLoadMoreTrackedActivities(
    LoadMoreTrackedActivitiesEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state.trackedActivitiesPaginationData.isLoading == true ||
        state.trackedActivitiesPaginationData.noMoreData == true) {
      return;
    }
    try {
      emit(
        state.copyWith(
          trackedActivitiesPaginationData:
              state.trackedActivitiesPaginationData.copyWith(isLoading: true),
        ),
      );
      final UserTrackedActivitiesResponse? trackedActivities =
          await TrackedActivityApi.getUserActivities(
        userUid: AuthUserDb.getLastLoggedUserUid()!,
        page: event.page!,
      );

      emit(
        state.copyWith(
          trackedActivities:
              state.trackedActivities + (trackedActivities?.activities ?? []),
          trackedActivitiesPaginationData:
              state.trackedActivitiesPaginationData.copyWith(
            currentPage: event.page,
            isLoading: false,
            isLastPage: trackedActivities?.lastPage,
          ),
        ),
      );
    } catch (e, s) {
      emit(
        state.copyWith(
          trackedActivitiesPaginationData:
              state.trackedActivitiesPaginationData.copyWith(
            isLoading: false,
          ),
        ),
      );
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _loadMixCommunityContent(
    LoadMixCommunityContentEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final PrivateRecommendationMixCommunityContentResponse?
          mixCommunityContentResponse =
          await PrivateRecommendationApi.getMixCommunityContent(
        page: 1,
        userUid: AuthUserDb.getLastLoggedUserUid()!,
      );
      emit(
        state.copyWith(
          mixCommunityContent: mixCommunityContentResponse?.communityMixContent,
          mixCommunityContentPaginationData:
              state.mixCommunityContentPaginationData.copyWith(
            isLoading: false,
            currentPage: 1,
            isLastPage: mixCommunityContentResponse?.lastPage,
          ),
        ),
      );
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _onLoadMoreMixCommunityContent(
    LoadMoreMixCommunityContentEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state.mixCommunityContentPaginationData.isLoading == true ||
        state.mixCommunityContentPaginationData.noMoreData == true) {
      return;
    }
    try {
      emit(
        state.copyWith(
          mixCommunityContentPaginationData:
              state.mixCommunityContentPaginationData.copyWith(isLoading: true),
        ),
      );
      final PrivateRecommendationMixCommunityContentResponse?
          mixCommunityContentResponse =
          await PrivateRecommendationApi.getMixCommunityContent(
        page: event.page!,
        userUid: AuthUserDb.getLastLoggedUserUid()!,
      );

      emit(
        state.copyWith(
          mixCommunityContent: state.mixCommunityContent +
              (mixCommunityContentResponse?.communityMixContent ?? []),
          mixCommunityContentPaginationData:
              state.mixCommunityContentPaginationData.copyWith(
            currentPage: event.page,
            isLoading: false,
            isLastPage: mixCommunityContentResponse?.lastPage,
          ),
        ),
      );
    } catch (e, s) {
      emit(
        state.copyWith(
          mixCommunityContentPaginationData:
              state.mixCommunityContentPaginationData.copyWith(
            isLoading: false,
          ),
        ),
      );
      highLevelCatch(e, s);
    }
  }
}
