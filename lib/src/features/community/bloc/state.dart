part of 'bloc.dart';

class CommunityState extends Equatable {
  final String? communityUid;
  final bool isEditMode;
  final CommunityProfileDataResponse? communityDetailsResponse;
  final List<Wtv?> communityVideoPosts;
  final List<Memory?> communityMemories;
  final List<OfferPost?> communityOffers;
  final List<MixContent?> communityMixContent;
  final List<TaggedContent?> communityTaggedContent;

  const CommunityState({
    this.communityUid,
    this.isEditMode = false,
    this.communityDetailsResponse,
    this.communityVideoPosts = const [],
    this.communityMemories = const [],
    this.communityOffers = const [],
    this.communityMixContent = const [],
    this.communityTaggedContent = const [],
  });

  @override
  List<Object?> get props => <Object?>[
        communityDetailsResponse,
        communityVideoPosts,
        communityMemories,
        communityOffers,
        communityMixContent,
        communityTaggedContent,
      ];

  CommunityState copyWith({
    String? communityUid,
    bool? isEditMode,
    CommunityProfileDataResponse? communityDetailsResponse,
    List<Wtv>? communityVideoPosts,
    List<Memory>? communityMemories,
    List<OfferPost>? communityOffers,
    List<MixContent>? communityMixContent,
    List<TaggedContent>? communityTaggedContent,
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
      communityTaggedContent:
          communityTaggedContent ?? this.communityTaggedContent,
    );
  }
}
