part of 'explore_bloc.dart';

class ExploreState extends Equatable {
  final PaginationData? videoPaginationData;
  final List<RecommendedVideo>? recommendationVideos;
  final PaginationData? memoryPaginationData;
  final List<RecommendedMemory>? recommendationMemories;
  final PaginationData? offersPaginationData;
  final List<RecommendedOffer>? recommendationOffers;
  final PaginationData? photoPostPaginationData;
  final List<RecommendedPhotoPost>? recommendationPhotoPosts;
  const ExploreState({
    this.recommendationVideos = const [],
    this.videoPaginationData,
    this.recommendationMemories = const [],
    this.memoryPaginationData,
    this.offersPaginationData,
    this.recommendationOffers = const [],
    this.photoPostPaginationData,
    this.recommendationPhotoPosts = const [],
  });

  @override
  List<Object?> get props => <Object?>[
        recommendationVideos,
        videoPaginationData,
        recommendationMemories,
        memoryPaginationData,
        offersPaginationData,
        recommendationOffers,
        photoPostPaginationData,
        recommendationPhotoPosts,
      ];

  ExploreState copyWith({
    List<RecommendedVideo>? recommendationVideos,
    PaginationData? videoPaginationData,
    List<RecommendedMemory>? recommendationMemories,
    PaginationData? memoryPaginationData,
    List<RecommendedOffer>? recommendationOffers,
    PaginationData? offersPaginationData,
    PaginationData? photoPostPaginationData,
    List<RecommendedPhotoPost>? recommendationPhotoPosts,
  }) {
    return ExploreState(
      recommendationVideos: recommendationVideos ?? this.recommendationVideos,
      videoPaginationData: videoPaginationData ?? this.videoPaginationData,
      recommendationMemories:
          recommendationMemories ?? this.recommendationMemories,
      memoryPaginationData: memoryPaginationData ?? this.memoryPaginationData,
      recommendationOffers: recommendationOffers ?? this.recommendationOffers,
      offersPaginationData: offersPaginationData ?? this.offersPaginationData,
      photoPostPaginationData:
          photoPostPaginationData ?? this.photoPostPaginationData,
      recommendationPhotoPosts:
          recommendationPhotoPosts ?? this.recommendationPhotoPosts,
    );
  }
}
