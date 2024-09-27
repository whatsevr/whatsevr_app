import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';

import 'package:whatsevr_app/config/api/response_model/recommendation_videos.dart';

import '../../../../config/api/external/models/pagination_data.dart';
import '../../../../config/api/methods/recommendations.dart';

part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ExploreBloc()
      : super(const ExploreState(
          videoPaginationData: PaginationData(
            currentVideoPage: 1,
            isLoading: false,
            isLastPage: false,
          ),
          recommendationVideos: [],
        )) {
    on<ExploreInitialEvent>(_onInitial);
    on<LoadVideosEvent>(_loadVideos);
    on<LoadMoreVideosEvent>(_onLoadMoreVideos);
  }

  Future<void> _onInitial(
    ExploreInitialEvent event,
    Emitter<ExploreState> emit,
  ) async {
    add(LoadVideosEvent());
  }

  FutureOr<void> _loadVideos(
      LoadVideosEvent event, Emitter<ExploreState> emit) async {
    try {
      emit(
        state.copyWith(
          videoPaginationData: state.videoPaginationData?.copyWith(
            currentVideoPage: 1,
            isLastPage: false,
            isLoading: true,
          ),
        ),
      );
      RecommendationVideosResponse? recommendationVideos =
          await RecommendationApi.publicVideoPosts(
        page: state.videoPaginationData?.currentVideoPage ?? 1,
      );
      emit(
        state.copyWith(
          recommendationVideos: recommendationVideos?.recommendedVideos,
          videoPaginationData: state.videoPaginationData?.copyWith(
            isLoading: false,
            isLastPage: recommendationVideos?.lastPage,
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

      if (recommendationVideos?.lastPage == true) {
        SmartDialog.showToast('No more videos to load');
      }
      emit(state.copyWith(
        recommendationVideos: state.recommendationVideos! +
            (recommendationVideos?.recommendedVideos ?? []),
        videoPaginationData: state.videoPaginationData?.copyWith(
          currentVideoPage: event.page,
          isLoading: false,
          isLastPage: recommendationVideos?.lastPage,
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
}
