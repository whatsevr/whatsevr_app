part of 'explore_bloc.dart';

class ExploreState extends Equatable {
  final PaginationData? videoPaginationData;
  final List<RecommendedVideo>? recommendationVideos;
  final PaginationData? memoryPaginationData;
  final List<RecommendedMemory>? recommendationMemories;
  final PaginationData? offersPaginationData;
  final List<RecommendedOffer>? recommendationOffers;
  const ExploreState({
    this.recommendationVideos,
    this.videoPaginationData,
    this.recommendationMemories,
    this.memoryPaginationData,
    this.offersPaginationData,
    this.recommendationOffers,
  });

  @override
  List<Object?> get props => <Object?>[
        recommendationVideos,
        videoPaginationData,
        recommendationMemories,
        memoryPaginationData,
        offersPaginationData,
        recommendationOffers,
      ];

  ExploreState copyWith({
    List<RecommendedVideo>? recommendationVideos,
    PaginationData? videoPaginationData,
    List<RecommendedMemory>? recommendationMemories,
    PaginationData? memoryPaginationData,
    List<RecommendedOffer>? recommendationOffers,
    PaginationData? offersPaginationData,
  }) {
    return ExploreState(
      recommendationVideos: recommendationVideos ?? this.recommendationVideos,
      videoPaginationData: videoPaginationData ?? this.videoPaginationData,
      recommendationMemories:
          recommendationMemories ?? this.recommendationMemories,
      memoryPaginationData: memoryPaginationData ?? this.memoryPaginationData,
      recommendationOffers: recommendationOffers ?? this.recommendationOffers,
      offersPaginationData: offersPaginationData ?? this.offersPaginationData,
    );
  }
}
