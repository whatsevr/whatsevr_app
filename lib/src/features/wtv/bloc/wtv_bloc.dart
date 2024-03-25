import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'wtv_event.dart';
part 'wtv_state.dart';

class WtvBloc extends Bloc<WtvEvent, WtvState> {
  WtvBloc() : super(WtvInitial()) {
    on<WtvEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
