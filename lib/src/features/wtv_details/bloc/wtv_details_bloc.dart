import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'wtv_details_event.dart';
part 'wtv_details_state.dart';

class WtvDetailsBloc extends Bloc<WtvDetailsEvent, WtvDetailsState> {
  WtvDetailsBloc() : super(WtvDetailsInitial()) {
    on<WtvDetailsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
