import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';

import '../../../../config/api/methods/recommendations.dart';
import '../../../../config/api/response_model/recommendation_flicks.dart';

part 'flicks_event.dart';
part 'flicks_state.dart';

class FlicksBloc extends Bloc<FlicksEvent, FlicksState> {
  FlicksBloc()
      : super(const FlicksState(
          currentFlickPage: 1,
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
        ),
      );
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _onLoadMoreFlicks(
      LoadMoreFlicksEvent event, Emitter<FlicksState> emit) async {
    try {
      RecommendationFlicksResponse? recommendationVideos =
          await RecommendationApi.publicFlickPosts(
        page: event.page!,
      );
      if (recommendationVideos?.recommendedFlicks == null ||
          recommendationVideos!.recommendedFlicks!.isEmpty) {
        throw BusinessException('${recommendationVideos?.message}');
      }
      emit(
        state.copyWith(
          recommendationFlicks: [
            ...state.recommendationFlicks!,
            ...recommendationVideos.recommendedFlicks!,
          ],
          currentFlickPage: event.page,
        ),
      );
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }
}
