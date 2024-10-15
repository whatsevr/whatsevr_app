part of 'account_bloc.dart';

class AccountState extends Equatable {
  final ProfileDetailsResponse? profileDetailsResponse;
  final List<VideoPost?> userVideoPosts;
  final List<Flick?> userFlicks;
  final List<Memory?> userMemories;
  final List<OfferPost?> userOffers;

  const AccountState({
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
    ProfileDetailsResponse? profileDetailsResponse,
    List<VideoPost>? userVideoPosts,
    List<Flick>? userFlicks,
    List<Memory>? userMemories,
    List<OfferPost>? userOffers,
  }) {
    return AccountState(
      profileDetailsResponse:
          profileDetailsResponse ?? this.profileDetailsResponse,
      userVideoPosts: userVideoPosts ?? this.userVideoPosts,
      userFlicks: userFlicks ?? this.userFlicks,
      userMemories: userMemories ?? this.userMemories,
      userOffers: userOffers ?? this.userOffers,
    );
  }
}
