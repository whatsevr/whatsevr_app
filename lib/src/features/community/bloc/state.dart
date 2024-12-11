part of 'bloc.dart';

class CommunityState extends Equatable {
  final String? communityUid;
  final bool isEditMode;
  final CommunityProfileDataResponse? communityDetailsResponse;
  final List<VideoPost?> communityVideoPosts;

  final List<Memory?> communityMemories;
  final List<OfferPost?> communityOffers;

  const CommunityState({
    this.communityUid,
    this.isEditMode = false,
    this.communityDetailsResponse,
    this.communityVideoPosts = const [],
    this.communityMemories = const [],
    this.communityOffers = const [],
  });

  @override
  List<Object?> get props => <Object?>[
        communityDetailsResponse,
        communityVideoPosts,
        communityMemories,
        communityOffers,
      ];

  CommunityState copyWith({
    String? communityUid,
    bool? isEditMode,
    CommunityProfileDataResponse? communityDetailsResponse,
    List<VideoPost>? communityVideoPosts,
    List<Memory>? communityMemories,
    List<OfferPost>? communityOffers,
  }) {
    return CommunityState(
      communityUid: communityUid ?? this.communityUid,
      isEditMode: isEditMode ?? this.isEditMode,
      communityDetailsResponse:
          communityDetailsResponse ?? this.communityDetailsResponse,
      communityVideoPosts: communityVideoPosts ?? this.communityVideoPosts,
      communityMemories: communityMemories ?? this.communityMemories,
      communityOffers: communityOffers ?? this.communityOffers,
    );
  }
}
