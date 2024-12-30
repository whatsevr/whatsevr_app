part of 'bloc.dart';

class CommunityState extends Equatable {
  final String? communityUid;
  final bool isEditMode;
  final CommunityProfileDataResponse? communityDetailsResponse;
  final List<VideoPost?> communityVideoPosts;

  final List<Memory?> communityMemories;
  final List<OfferPost?> communityOffers;
  final List<MixContent?> communityMixContent;

  const CommunityState({
    this.communityUid,
    this.isEditMode = false,
    this.communityDetailsResponse,
    this.communityVideoPosts = const [],
    this.communityMemories = const [],
    this.communityOffers = const [],
    this.communityMixContent = const [],
  });

  @override
  List<Object?> get props => <Object?>[
        communityDetailsResponse,
        communityVideoPosts,
        communityMemories,
        communityOffers,
        communityMixContent,
      ];

  CommunityState copyWith({
    String? communityUid,
    bool? isEditMode,
    CommunityProfileDataResponse? communityDetailsResponse,
    List<VideoPost>? communityVideoPosts,
    List<Memory>? communityMemories,
    List<OfferPost>? communityOffers,
    List<MixContent>? communityMixContent,
  }) {
    return CommunityState(
      communityUid: communityUid ?? this.communityUid,
      isEditMode: isEditMode ?? this.isEditMode,
      communityDetailsResponse:
          communityDetailsResponse ?? this.communityDetailsResponse,
      communityVideoPosts: communityVideoPosts ?? this.communityVideoPosts,
      communityMemories: communityMemories ?? this.communityMemories,
      communityOffers: communityOffers ?? this.communityOffers,
      communityMixContent: communityMixContent ?? this.communityMixContent,
    );
  }
}
