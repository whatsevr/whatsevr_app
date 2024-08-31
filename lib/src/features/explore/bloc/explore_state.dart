part of 'explore_bloc.dart';

class ExploreState extends Equatable {
  final List<RecommendationVideo>? recommendationVideos;
  const ExploreState({
    this.recommendationVideos,
  });

  @override
  List<Object?> get props => [recommendationVideos];

  ExploreState copyWith({
    List<RecommendationVideo>? recommendationVideos,
  }) {
    return ExploreState(
      recommendationVideos: recommendationVideos ?? this.recommendationVideos,
    );
  }
}
