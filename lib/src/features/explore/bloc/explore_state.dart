part of 'explore_bloc.dart';

class ExploreState extends Equatable {
  final PaginationData? videoPaginationData;
  final List<RecommendedVideo>? recommendationVideos;
  final PaginationData? memoryPaginationData;
  final List<RecommendedMemory>? recommendationMemories;
  const ExploreState({
    this.recommendationVideos,
    this.videoPaginationData,
    this.recommendationMemories,
    this.memoryPaginationData,
  });

  @override
  List<Object?> get props => <Object?>[
        recommendationVideos,
        videoPaginationData,
        recommendationMemories,
        memoryPaginationData
      ];

  ExploreState copyWith({
    List<RecommendedVideo>? recommendationVideos,
    PaginationData? videoPaginationData,
    List<RecommendedMemory>? recommendationMemories,
    PaginationData? memoryPaginationData,
  }) {
    return ExploreState(
      recommendationVideos: recommendationVideos ?? this.recommendationVideos,
      videoPaginationData: videoPaginationData ?? this.videoPaginationData,
      recommendationMemories:
          recommendationMemories ?? this.recommendationMemories,
      memoryPaginationData: memoryPaginationData ?? this.memoryPaginationData,
    );
  }
}
