import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';

import '../../../../config/api/external/models/pagination_data.dart';
import '../../../../config/api/methods/recommendations.dart';
import '../../../../config/api/response_model/recommendation_flicks.dart';

part 'flicks_event.dart';
part 'flicks_state.dart';

class FlicksBloc extends Bloc<FlicksEvent, FlicksState> {
  FlicksBloc()
      : super(const FlicksState(
          flicksPaginationData: PaginationData(
            currentPage: 1,
            isLoading: false,
            noMoreData: false,
          ),
          recommendationFlicks: [],
        )) {
    on<FlicksInitialEvent>(_onInitial);
    on<LoadFlicksEvent>(_loadFlicks);
    on<LoadMoreFlicksEvent>(_onLoadMoreFlicks);
  }

  Future<void> _onInitial(
    FlicksInitialEvent event,
    Emitter<FlicksState> emit,
  ) async {
    add(LoadFlicksEvent());
  }

  FutureOr<void> _loadFlicks(
      LoadFlicksEvent event, Emitter<FlicksState> emit) async {
    try {
      RecommendationFlicksResponse? recommendationVideos =
          await RecommendationApi.publicFlickPosts(
        page: 1,
      );
      emit(
        state.copyWith(
          recommendationFlicks: recommendationVideos?.recommendedFlicks,
          flicksPaginationData: state.flicksPaginationData?.copyWith(
            isLoading: false,
            noMoreData: recommendationVideos?.lastPage,
          ),
        ),
      );
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _onLoadMoreFlicks(
      LoadMoreFlicksEvent event, Emitter<FlicksState> emit) async {
    if (state.flicksPaginationData?.isLoading == true) return;
    try {
      emit(
        state.copyWith(
          flicksPaginationData: state.flicksPaginationData?.copyWith(
            isLoading: true,
          ),
        ),
      );
      RecommendationFlicksResponse? recommendationVideos =
          await RecommendationApi.publicFlickPosts(
        page: event.page!,
      );

      emit(
        state.copyWith(
          recommendationFlicks: [
            ...state.recommendationFlicks ?? [],
            ...recommendationVideos?.recommendedFlicks ?? [],
          ],
          flicksPaginationData: state.flicksPaginationData?.copyWith(
            currentPage: event.page,
            isLoading: false,
            noMoreData: recommendationVideos?.lastPage,
          ),
        ),
      );
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }
}
