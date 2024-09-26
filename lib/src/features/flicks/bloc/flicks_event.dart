part of 'flicks_bloc.dart';

sealed class FlicksEvent extends Equatable {
  const FlicksEvent();
}

class FlicksInitialEvent extends FlicksEvent {
  @override
  List<Object> get props => <Object>[];
}
