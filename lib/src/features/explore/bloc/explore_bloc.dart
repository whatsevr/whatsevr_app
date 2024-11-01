import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../config/api/external/models/business_validation_exception.dart';
import '../../../../config/api/external/models/pagination_data.dart';
import '../../../../config/api/methods/public_recommendations.dart';
import '../../../../config/api/response_model/recommendation_memories.dart';
import '../../../../config/api/response_model/recommendation_offers.dart';
import '../../../../config/api/response_model/recommendation_photo_posts.dart';
import '../../../../config/api/response_model/recommendation_videos.dart';

part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ExploreBloc()
      : super(
          const ExploreState(
            recommendationVideos: [],
            recommendationMemories: [],
            recommendationOffers: [],
            recommendationPhotoPosts: [],
            videoPaginationData: PaginationData(),
            memoryPaginationData: PaginationData(),
            offersPaginationData: PaginationData(),
            photoPostPaginationData: PaginationData(),
          ),
        ) {
    on<ExploreInitialEvent>(_onInitial);
    on<LoadVideosEvent>(_loadVideos);
    on<LoadMoreVideosEvent>(_onLoadMoreVideos);
    on<LoadMemoriesEvent>(_loadMemories);
    on<LoadMoreMemoriesEvent>(_onLoadMoreMemories);
    on<LoadOffersEvent>(_loadOffers);
    on<LoadMoreOffersEvent>(_onLoadMoreOffers);
    on<LoadPhotoPostsEvent>(_loadPhotoPosts);
    on<LoadMorePhotoPostsEvent>(_onLoadMorePhotoPosts);
  }

  Future<void> _onInitial(
    ExploreInitialEvent event,
    Emitter<ExploreState> emit,
  ) async {
    add(LoadVideosEvent());
    add(LoadMemoriesEvent());
    add(LoadOffersEvent());
    add(LoadPhotoPostsEvent());
  }

  FutureOr<void> _loadVideos(
    LoadVideosEvent event,
    Emitter<ExploreState> emit,
  ) async {
    try {
      final RecommendationVideosResponse? recommendationVideos =
          await RecommendationApi.publicVideoPosts(
        page: 1,
      );
      emit(
        state.copyWith(
          recommendationVideos: recommendationVideos?.recommendedVideos,
          videoPaginationData: state.videoPaginationData?.copyWith(
            isLoading: false,
            currentPage: 1,
            noMoreData: recommendationVideos?.lastPage,
          ),
        ),
      );
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _onLoadMoreVideos(
    LoadMoreVideosEvent event,
    Emitter<ExploreState> emit,
  ) async {
    if (state.videoPaginationData?.isLoading == true ||
        state.videoPaginationData?.noMoreData == true) return;
    try {
      emit(
        state.copyWith(
          videoPaginationData:
              state.videoPaginationData?.copyWith(isLoading: true),
        ),
      );
      final RecommendationVideosResponse? recommendationVideos =
          await RecommendationApi.publicVideoPosts(
        page: event.page!,
      );

      emit(
        state.copyWith(
          recommendationVideos: state.recommendationVideos! +
              (recommendationVideos?.recommendedVideos ?? []),
          videoPaginationData: state.videoPaginationData?.copyWith(
            currentPage: event.page,
            isLoading: false,
            noMoreData: recommendationVideos?.lastPage,
          ),
        ),
      );
    } catch (e, s) {
      emit(
        state.copyWith(
          videoPaginationData: state.videoPaginationData?.copyWith(
            isLoading: false,
          ),
        ),
      );
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _loadMemories(
    LoadMemoriesEvent event,
    Emitter<ExploreState> emit,
  ) async {
    try {
      final RecommendationMemoriesResponse? recommendationMemories =
          await RecommendationApi.publicMemories(
        page: 1,
      );
      emit(
        state.copyWith(
          recommendationMemories: recommendationMemories?.recommendedMemories,
          memoryPaginationData: state.memoryPaginationData?.copyWith(
            isLoading: false,
            currentPage: 1,
            noMoreData: recommendationMemories?.lastPage,
          ),
        ),
      );
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _onLoadMoreMemories(
    LoadMoreMemoriesEvent event,
    Emitter<ExploreState> emit,
  ) async {
    if (state.memoryPaginationData?.isLoading == true ||
        state.memoryPaginationData?.noMoreData == true) return;
    try {
      emit(
        state.copyWith(
          memoryPaginationData:
              state.memoryPaginationData?.copyWith(isLoading: true),
        ),
      );
      final RecommendationMemoriesResponse? recommendationMemories =
          await RecommendationApi.publicMemories(
        page: event.page!,
      );

      emit(
        state.copyWith(
          recommendationMemories: state.recommendationMemories! +
              (recommendationMemories?.recommendedMemories ?? []),
          memoryPaginationData: state.memoryPaginationData?.copyWith(
            currentPage: event.page,
            isLoading: false,
            noMoreData: recommendationMemories?.lastPage,
          ),
        ),
      );
    } catch (e, s) {
      emit(
        state.copyWith(
          memoryPaginationData: state.memoryPaginationData?.copyWith(
            isLoading: false,
          ),
        ),
      );
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _loadOffers(
    LoadOffersEvent event,
    Emitter<ExploreState> emit,
  ) async {
    try {
      final RecommendationOffersResponse? recommendationOffers =
          await RecommendationApi.publicOffers(
        page: 1,
      );
      emit(
        state.copyWith(
          recommendationOffers: recommendationOffers?.recommendedOffers,
          offersPaginationData: state.offersPaginationData?.copyWith(
            isLoading: false,
            currentPage: 1,
            noMoreData: recommendationOffers?.lastPage,
          ),
        ),
      );
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _onLoadMoreOffers(
    LoadMoreOffersEvent event,
    Emitter<ExploreState> emit,
  ) async {
    if (state.offersPaginationData?.isLoading == true ||
        state.offersPaginationData?.noMoreData == true) return;
    try {
      emit(
        state.copyWith(
          offersPaginationData:
              state.offersPaginationData?.copyWith(isLoading: true),
        ),
      );
      final RecommendationOffersResponse? recommendationOffers =
          await RecommendationApi.publicOffers(
        page: event.page!,
      );

      emit(
        state.copyWith(
          recommendationOffers: state.recommendationOffers! +
              (recommendationOffers?.recommendedOffers ?? []),
          offersPaginationData: state.offersPaginationData?.copyWith(
            currentPage: event.page,
            isLoading: false,
            noMoreData: recommendationOffers?.lastPage,
          ),
        ),
      );
    } catch (e, s) {
      emit(
        state.copyWith(
          offersPaginationData: state.offersPaginationData?.copyWith(
            isLoading: false,
          ),
        ),
      );
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _loadPhotoPosts(
    LoadPhotoPostsEvent event,
    Emitter<ExploreState> emit,
  ) async {
    try {
      final RecommendationPhotoPostsResponse? recommendationPhotoPosts =
          await RecommendationApi.publicPhotoPosts(
        page: 1,
      );
      emit(
        state.copyWith(
          recommendationPhotoPosts:
              recommendationPhotoPosts?.recommendedPhotoPosts,
          photoPostPaginationData: state.photoPostPaginationData?.copyWith(
            isLoading: false,
            currentPage: 1,
            noMoreData: recommendationPhotoPosts?.lastPage,
          ),
        ),
      );
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _onLoadMorePhotoPosts(
    LoadMorePhotoPostsEvent event,
    Emitter<ExploreState> emit,
  ) async {
    if (state.photoPostPaginationData?.isLoading == true ||
        state.photoPostPaginationData?.noMoreData == true) return;
    try {
      emit(
        state.copyWith(
          photoPostPaginationData:
              state.photoPostPaginationData?.copyWith(isLoading: true),
        ),
      );
      final RecommendationPhotoPostsResponse? recommendationPhotoPosts =
          await RecommendationApi.publicPhotoPosts(
        page: event.page!,
      );

      emit(
        state.copyWith(
          recommendationPhotoPosts: state.recommendationPhotoPosts! +
              (recommendationPhotoPosts?.recommendedPhotoPosts ?? []),
          photoPostPaginationData: state.photoPostPaginationData?.copyWith(
            currentPage: event.page,
            isLoading: false,
            noMoreData: recommendationPhotoPosts?.lastPage,
          ),
        ),
      );
    } catch (e, s) {
      emit(
        state.copyWith(
          photoPostPaginationData: state.photoPostPaginationData?.copyWith(
            isLoading: false,
          ),
        ),
      );
      highLevelCatch(e, s);
    }
  }
}
