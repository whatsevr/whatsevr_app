import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';

import '../../../../config/api/methods/recommendations.dart';
import '../../../../config/api/response_model/recommendation_flicks.dart';

part 'flicks_event.dart';
part 'flicks_state.dart';

class FlicksBloc extends Bloc<FlicksEvent, FlicksState> {
  FlicksBloc() : super(FlicksState()) {
    on<FlicksInitialEvent>(_onInitial);
  }

  Future<void> _onInitial(
    FlicksInitialEvent event,
    Emitter<FlicksState> emit,
  ) async {
    try {
      RecommendationFlicksResponse? recommendationVideos =
          await RecommendationApi.publicFlickPosts();
      emit(
        state.copyWith(
          recommendationFlicks: recommendationVideos?.recommendedFlicks,
        ),
      );
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }
}
