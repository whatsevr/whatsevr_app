import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'package:whatsevr_app/config/api/recommendations.dart';

import 'package:whatsevr_app/config/api/response_model/recommendation_videos.dart';

part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ExploreBloc() : super(const ExploreState()) {
    on<ExploreInitialEvent>(_onInitial);
  }

  Future<void> _onInitial(
      ExploreInitialEvent event, Emitter<ExploreState> emit,) async {
    try {
      RecommendationVideosResponse? recommendationVideos =
          await RecommendationApi.videoPosts();
      emit(state.copyWith(
        recommendationVideos: recommendationVideos?.recommendedVideos,
      ),);
    } catch (e) {
      SmartDialog.showToast('Error: $e');
    }
  }
}
