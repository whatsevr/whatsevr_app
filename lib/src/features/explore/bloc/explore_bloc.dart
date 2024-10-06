import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';

import 'package:whatsevr_app/config/api/response_model/recommendation_videos.dart';

import '../../../../config/api/external/models/pagination_data.dart';
import '../../../../config/api/methods/recommendations.dart';
import '../../../../config/api/response_model/recommendation_memories.dart';

part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ExploreBloc()
      : super(const ExploreState(
          videoPaginationData: PaginationData(
            currentPage: 1,
            isLoading: false,
            noMoreData: false,
          ),
          memoryPaginationData: PaginationData(
            currentPage: 1,
            isLoading: false,
            noMoreData: false,
          ),
          recommendationVideos: [],
          recommendationMemories: [],
        )) {
    on<ExploreInitialEvent>(_onInitial);
    on<LoadVideosEvent>(_loadVideos);

    on<LoadMoreVideosEvent>(_onLoadMoreVideos);
    on<LoadMemoriesEvent>(_loadMemories);
    on<LoadMoreMemoriesEvent>(_onLoadMoreMemories);
  }

  Future<void> _onInitial(
    ExploreInitialEvent event,
    Emitter<ExploreState> emit,
  ) async {
    add(LoadVideosEvent());
    add(LoadMemoriesEvent());
  }

  FutureOr<void> _loadVideos(
      LoadVideosEvent event, Emitter<ExploreState> emit) async {
    try {
      emit(
        state.copyWith(
          videoPaginationData: state.videoPaginationData?.copyWith(
            currentPage: 1,
            noMoreData: false,
            isLoading: true,
          ),
        ),
      );
      RecommendationVideosResponse? recommendationVideos =
          await RecommendationApi.publicVideoPosts(
        page: state.videoPaginationData?.currentPage ?? 1,
      );
      emit(
        state.copyWith(
          recommendationVideos: recommendationVideos?.recommendedVideos,
          videoPaginationData: state.videoPaginationData?.copyWith(
            isLoading: false,
            noMoreData: recommendationVideos?.lastPage,
          ),
        ),
      );
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _onLoadMoreVideos(
      LoadMoreVideosEvent event, Emitter<ExploreState> emit) async {
    if (state.videoPaginationData?.isLoading == true) return;
    try {
      emit(
        state.copyWith(
            videoPaginationData:
                state.videoPaginationData?.copyWith(isLoading: true)),
      );
      RecommendationVideosResponse? recommendationVideos =
          await RecommendationApi.publicVideoPosts(
        page: event.page!,
      );

      emit(state.copyWith(
        recommendationVideos: state.recommendationVideos! +
            (recommendationVideos?.recommendedVideos ?? []),
        videoPaginationData: state.videoPaginationData?.copyWith(
          currentPage: event.page,
          isLoading: false,
          noMoreData: recommendationVideos?.lastPage,
        ),
      ));
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
      LoadMemoriesEvent event, Emitter<ExploreState> emit) async {
    try {
      emit(
        state.copyWith(
          memoryPaginationData: state.memoryPaginationData?.copyWith(
            currentPage: 1,
            noMoreData: false,
            isLoading: true,
          ),
        ),
      );
      RecommendationMemoriesResponse? recommendationMemories =
          await RecommendationApi.publicMemories(
        page: state.memoryPaginationData?.currentPage ?? 1,
      );
      emit(
        state.copyWith(
          recommendationMemories: recommendationMemories?.recommendedMemories,
          memoryPaginationData: state.memoryPaginationData?.copyWith(
            isLoading: false,
            noMoreData: recommendationMemories?.lastPage,
          ),
        ),
      );
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _onLoadMoreMemories(
      LoadMoreMemoriesEvent event, Emitter<ExploreState> emit) async {
    if (state.memoryPaginationData?.isLoading == true) return;
    try {
      emit(
        state.copyWith(
            memoryPaginationData:
                state.memoryPaginationData?.copyWith(isLoading: true)),
      );
      RecommendationMemoriesResponse? recommendationMemories =
          await RecommendationApi.publicMemories(
        page: event.page!,
      );

      emit(state.copyWith(
        recommendationMemories: state.recommendationMemories! +
            (recommendationMemories?.recommendedMemories ?? []),
        memoryPaginationData: state.memoryPaginationData?.copyWith(
          currentPage: event.page,
          isLoading: false,
          noMoreData: recommendationMemories?.lastPage,
        ),
      ));
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
}
