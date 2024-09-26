part of 'flicks_bloc.dart';

class FlicksState extends Equatable {
  final List<RecommendedFlick>? recommendationFlicks;
  const FlicksState({
    this.recommendationFlicks,
  });

  @override
  List<Object?> get props => <Object?>[recommendationFlicks];

  FlicksState copyWith({
    List<RecommendedFlick>? recommendationFlicks,
  }) {
    return FlicksState(
      recommendationFlicks: recommendationFlicks ?? this.recommendationFlicks,
    );
  }
}
