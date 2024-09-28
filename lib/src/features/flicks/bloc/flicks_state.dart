part of 'flicks_bloc.dart';

class FlicksState extends Equatable {
  final PaginationData? flicksPaginationData;
  final List<RecommendedFlick>? recommendationFlicks;
  const FlicksState({
    this.recommendationFlicks,
    this.flicksPaginationData,
  });

  @override
  List<Object?> get props =>
      <Object?>[recommendationFlicks, flicksPaginationData];

  FlicksState copyWith({
    List<RecommendedFlick>? recommendationFlicks,
    PaginationData? flicksPaginationData,
  }) {
    return FlicksState(
      recommendationFlicks: recommendationFlicks ?? this.recommendationFlicks,
      flicksPaginationData: flicksPaginationData ?? this.flicksPaginationData,
    );
  }
}
