part of 'home_bloc.dart';

class HomeState extends Equatable {
  final PaginationData videoPaginationData;
  final List<RecommendedVideo> recommendationVideos;
  final PaginationData memoryPaginationData;
  final List<RecommendedMemory> recommendationMemories;
  final PaginationData offersPaginationData;
  final List<RecommendedOffer> recommendationOffers;
  final PaginationData photoPostPaginationData;
  final List<RecommendedPhotoPost> recommendationPhotoPosts;
  final PaginationData mixContentPaginationData;
  final List<MixContent> mixContent;
  final PaginationData trackedActivitiesPaginationData;
  final List<Activity> trackedActivities;
  final PaginationData mixCommunityContentPaginationData;
  final List<CommunityMixContent> mixCommunityContent;
  const HomeState({
    this.recommendationVideos = const [],
    this.videoPaginationData = const PaginationData(),
    this.recommendationMemories = const [],
    this.memoryPaginationData = const PaginationData(),
    this.offersPaginationData = const PaginationData(),
    this.recommendationOffers = const [],
    this.photoPostPaginationData = const PaginationData(),
    this.recommendationPhotoPosts = const [],
    this.mixContentPaginationData = const PaginationData(),
    this.mixContent = const [],
    this.trackedActivitiesPaginationData = const PaginationData(),
    this.trackedActivities = const [],
    this.mixCommunityContentPaginationData = const PaginationData(),
    this.mixCommunityContent = const [],
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
        mixContentPaginationData,
        mixContent,
        trackedActivitiesPaginationData,
        trackedActivities,
        mixCommunityContentPaginationData,
        mixCommunityContent,
      ];

  HomeState copyWith({
    List<RecommendedVideo>? recommendationVideos,
    PaginationData? videoPaginationData,
    List<RecommendedMemory>? recommendationMemories,
    PaginationData? memoryPaginationData,
    List<RecommendedOffer>? recommendationOffers,
    PaginationData? offersPaginationData,
    PaginationData? photoPostPaginationData,
    List<RecommendedPhotoPost>? recommendationPhotoPosts,
    PaginationData? mixContentPaginationData,
    List<MixContent>? mixContent,
    PaginationData? trackedActivitiesPaginationData,
    List<Activity>? trackedActivities,
    PaginationData? mixCommunityContentPaginationData,
    List<CommunityMixContent>? mixCommunityContent,
  }) {
    return HomeState(
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
      mixContentPaginationData:
          mixContentPaginationData ?? this.mixContentPaginationData,
      mixContent: mixContent ?? this.mixContent,
      trackedActivitiesPaginationData: trackedActivitiesPaginationData ??
          this.trackedActivitiesPaginationData,
      trackedActivities: trackedActivities ?? this.trackedActivities,
      mixCommunityContentPaginationData: mixCommunityContentPaginationData ??
          this.mixCommunityContentPaginationData,
      mixCommunityContent: mixCommunityContent ?? this.mixCommunityContent,
    );
  }
}
