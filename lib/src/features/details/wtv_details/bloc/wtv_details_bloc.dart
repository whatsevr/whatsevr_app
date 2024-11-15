import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsevr_app/config/api/methods/post_details.dart';
import 'package:whatsevr_app/config/api/response_model/post_details/video.dart';
import 'package:whatsevr_app/src/features/details/wtv_details/views/page.dart';

part 'wtv_details_event.dart';
part 'wtv_details_state.dart';

class WtvDetailsBloc extends Bloc<WtvDetailsEvent, WtvDetailsState> {
  WtvDetailsBloc() : super(WtvDetailsState()) {
    on<InitialEvent>(_onInitialEvent);
    on<FetchVideoPostDetails>(_onFetchVideoPostDetails);
  }

  FutureOr<void> _onInitialEvent(
      InitialEvent event, Emitter<WtvDetailsState> emit,) {
    add(FetchVideoPostDetails(
      videoPostUid: event.pageArgument.videoPostUid,
      thumbnail: event.pageArgument.thumbnail,
      videoUrl: event.pageArgument.videoUrl,
    ),);
  }

  FutureOr<void> _onFetchVideoPostDetails(
      FetchVideoPostDetails event, Emitter<WtvDetailsState> emit,) async {
    emit(WtvDetailsState(
      thumbnail: event.thumbnail,
      videoUrl: event.videoUrl,
      videoPostUid: event.videoPostUid,
    ),);
    final videoPostDetailsResponse = await PostDetailsApi.video(
      videoPostUid: event.videoPostUid!,
    );
    emit(state.copyWith(
        thumbnail: videoPostDetailsResponse?.videoPostDetails?.thumbnail,
        videoUrl: videoPostDetailsResponse?.videoPostDetails?.videoUrl,
        videoPostUid: videoPostDetailsResponse?.videoPostDetails?.uid,
        videoPostDetailsResponse: videoPostDetailsResponse,),);
  }
}
