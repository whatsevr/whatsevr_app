part of 'account_bloc.dart';

class AccountState extends Equatable {
  final ProfileDetailsResponse? profileDetailsResponse;
  final List<VideoPost?> userVideoPosts;
  final List<Flick?> userFlicks;
  const AccountState({
    this.profileDetailsResponse,
    this.userVideoPosts = const [],
    this.userFlicks = const [],
  });

  @override
  List<Object?> get props =>
      <Object?>[profileDetailsResponse, userVideoPosts, userFlicks];

  AccountState copyWith({
    ProfileDetailsResponse? profileDetailsResponse,
    List<VideoPost>? userVideoPosts,
    List<Flick>? userFlicks,
  }) {
    return AccountState(
      profileDetailsResponse:
          profileDetailsResponse ?? this.profileDetailsResponse,
      userVideoPosts: userVideoPosts ?? this.userVideoPosts,
      userFlicks: userFlicks ?? this.userFlicks,
    );
  }
}
