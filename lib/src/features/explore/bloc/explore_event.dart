part of 'explore_bloc.dart';

sealed class ExploreEvent extends Equatable {
  const ExploreEvent();
}

class ExploreInitialEvent extends ExploreEvent {
  @override
  List<Object> get props => <Object>[];
}

class LoadVideosEvent extends ExploreEvent {
  @override
  List<Object> get props => <Object>[];
}

class LoadMoreVideosEvent extends ExploreEvent {
  final int? page;
  const LoadMoreVideosEvent({required this.page});
  @override
  List<Object?> get props => <Object?>[page];
}

class LoadMemoriesEvent extends ExploreEvent {
  @override
  List<Object> get props => <Object>[];
}

class LoadMoreMemoriesEvent extends ExploreEvent {
  final int? page;
  const LoadMoreMemoriesEvent({required this.page});
  @override
  List<Object?> get props => <Object?>[page];
}
