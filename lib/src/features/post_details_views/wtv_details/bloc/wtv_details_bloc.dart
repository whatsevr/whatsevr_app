import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsevr_app/src/features/post_details_views/wtv_details/views/page.dart';

part 'wtv_details_event.dart';
part 'wtv_details_state.dart';

class WtvDetailsBloc extends Bloc<WtvDetailsEvent, WtvDetailsState> {
  WtvDetailsBloc() : super(WtvDetailsState()) {
    on<InitialEvent>(_onInitialEvent);
  }

  FutureOr<void> _onInitialEvent(
      InitialEvent event, Emitter<WtvDetailsState> emit) {
    emit(state.copyWith(
      videoPostUid: event.pageArgument.videoPostUid,
      thumbnail: event.pageArgument.thumbnail,
      videoUrl: event.pageArgument.videoUrl,
    ));
  }
}
