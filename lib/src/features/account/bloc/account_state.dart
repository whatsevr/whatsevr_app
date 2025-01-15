part of 'account_bloc.dart';

class AccountState extends Equatable {
  final String? userUid;
  final bool isEditMode;
  final UserProfileDetailsResponse? profileDetailsResponse;
  final List<Wtv?> userVideoPosts;
  final List<Flick?> userFlicks;
  final List<Memory?> userMemories;
  final List<OfferPost?> userOffers;
  final List<MixContent?> userMixContent;
  final List<TaggedContent?> userTaggedContent;

  const AccountState({
    this.userUid,
    this.isEditMode = false,
    this.profileDetailsResponse,
    this.userVideoPosts = const [],
    this.userFlicks = const [],
    this.userMemories = const [],
    this.userOffers = const [],
    this.userMixContent = const [],
    this.userTaggedContent = const [],
  });

  @override
  List<Object?> get props => <Object?>[
        profileDetailsResponse,
        userVideoPosts,
        userFlicks,
        userMemories,
        userOffers,
        userMixContent,
        userTaggedContent,
      ];

  AccountState copyWith({
    String? userUid,
    bool? isEditMode,
    UserProfileDetailsResponse? profileDetailsResponse,
    List<Wtv>? userVideoPosts,
    List<Flick>? userFlicks,
    List<Memory>? userMemories,
    List<OfferPost>? userOffers,
    List<MixContent>? userMixContent,
    List<TaggedContent>? userTaggedContent,
  }) {
    return AccountState(
      userUid: userUid ?? this.userUid,
      isEditMode: isEditMode ?? this.isEditMode,
      profileDetailsResponse:
          profileDetailsResponse ?? this.profileDetailsResponse,
      userVideoPosts: userVideoPosts ?? this.userVideoPosts,
      userFlicks: userFlicks ?? this.userFlicks,
      userMemories: userMemories ?? this.userMemories,
      userOffers: userOffers ?? this.userOffers,
      userMixContent: userMixContent ?? this.userMixContent,
      userTaggedContent: userTaggedContent ?? this.userTaggedContent,
    );
  }
}
