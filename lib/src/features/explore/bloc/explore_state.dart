part of 'explore_bloc.dart';

class ExploreState extends Equatable {
  final PaginationData? videoPaginationData;
  final List<RecommendedVideo>? recommendationVideos;
  const ExploreState({
    this.recommendationVideos,
    this.videoPaginationData,
  });

  @override
  List<Object?> get props =>
      <Object?>[recommendationVideos, videoPaginationData];

  ExploreState copyWith({
    List<RecommendedVideo>? recommendationVideos,
    PaginationData? videoPaginationData,
  }) {
    return ExploreState(
      recommendationVideos: recommendationVideos ?? this.recommendationVideos,
      videoPaginationData: videoPaginationData ?? this.videoPaginationData,
    );
  }
}
