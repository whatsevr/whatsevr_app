part of 'explore_bloc.dart';

sealed class ExploreEvent extends Equatable {
  const ExploreEvent();
}

class ExploreInitialEvent extends ExploreEvent {
  @override
  List<Object> get props => [];
}
