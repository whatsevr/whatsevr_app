part of 'explore_bloc.dart';

class ExploreState extends Equatable {
  final List<RecommendedVideo>? recommendationVideos;
  const ExploreState({
    this.recommendationVideos,
  });

  @override
  List<Object?> get props => [recommendationVideos];

  ExploreState copyWith({
    List<RecommendedVideo>? recommendationVideos,
  }) {
    return ExploreState(
      recommendationVideos: recommendationVideos ?? this.recommendationVideos,
    );
  }
}
