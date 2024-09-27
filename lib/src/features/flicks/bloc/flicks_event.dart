part of 'flicks_bloc.dart';

sealed class FlicksEvent extends Equatable {
  const FlicksEvent();
}

class FlicksInitialEvent extends FlicksEvent {
  @override
  List<Object> get props => <Object>[];
}

class LoadFlicksEvent extends FlicksEvent {
  @override
  List<Object> get props => <Object>[];
}

class LoadMoreFlicksEvent extends FlicksEvent {
  final int? page;
  const LoadMoreFlicksEvent({this.page});
  @override
  List<Object?> get props => <Object?>[page];
}
