part of 'account_bloc.dart';

class AccountState extends Equatable {
  final String? userUid;
  final bool isEditMode;
  final ProfileDetailsResponse? profileDetailsResponse;
  final List<VideoPost?> userVideoPosts;
  final List<Flick?> userFlicks;
  final List<Memory?> userMemories;
  final List<OfferPost?> userOffers;

  const AccountState({
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

  AccountState copyWith({
    String? userUid,
    bool? isEditMode,
    ProfileDetailsResponse? profileDetailsResponse,
    List<VideoPost>? userVideoPosts,
    List<Flick>? userFlicks,
    List<Memory>? userMemories,
    List<OfferPost>? userOffers,
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
    );
  }
}
