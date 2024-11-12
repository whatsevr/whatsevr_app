part of 'bloc.dart';

class CommunityState extends Equatable {
  final String? userUid;
  final bool isEditMode;
  final ProfileDetailsResponse? profileDetailsResponse;
  final List<VideoPost?> userVideoPosts;
  final List<Flick?> userFlicks;
  final List<Memory?> userMemories;
  final List<OfferPost?> userOffers;

  const CommunityState({
    this.userUid,
    this.isEditMode = false,
    this.profileDetailsResponse,
    this.userVideoPosts = const [],
    this.userFlicks = const [],
    this.userMemories = const [],
    this.userOffers = const [],
  });

  @override
  List<Object?> get props => <Object?>[
        profileDetailsResponse,
        userVideoPosts,
        userFlicks,
        userMemories,
        userOffers,
      ];

  CommunityState copyWith({
    String? userUid,
    bool? isEditMode,
    ProfileDetailsResponse? profileDetailsResponse,
    List<VideoPost>? userVideoPosts,
    List<Flick>? userFlicks,
    List<Memory>? userMemories,
    List<OfferPost>? userOffers,
  }) {
    return CommunityState(
      userUid: userUid ?? this.userUid,
      isEditMode: isEditMode ?? this.isEditMode,
      profileDetailsResponse:
          profileDetailsResponse ?? this.profileDetailsResponse,
      userVideoPosts: userVideoPosts ?? this.userVideoPosts,
      userFlicks: userFlicks ?? this.userFlicks,
      userMemories: userMemories ?? this.userMemories,
      userOffers: userOffers ?? this.userOffers,
    );
  }
}
