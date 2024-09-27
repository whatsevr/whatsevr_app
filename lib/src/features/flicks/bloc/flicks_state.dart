part of 'flicks_bloc.dart';

class FlicksState extends Equatable {
  final int? currentFlickPage;
  final List<RecommendedFlick>? recommendationFlicks;
  const FlicksState({
    this.recommendationFlicks,
    this.currentFlickPage,
  });

  @override
  List<Object?> get props => <Object?>[recommendationFlicks, currentFlickPage];

  FlicksState copyWith({
    List<RecommendedFlick>? recommendationFlicks,
    int? currentFlickPage,
  }) {
    return FlicksState(
      recommendationFlicks: recommendationFlicks ?? this.recommendationFlicks,
      currentFlickPage: currentFlickPage ?? this.currentFlickPage,
    );
  }
}
