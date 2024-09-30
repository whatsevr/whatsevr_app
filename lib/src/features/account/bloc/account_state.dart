part of 'account_bloc.dart';

class AccountState extends Equatable {
  final ProfileDetailsResponse? profileDetailsResponse;
  final List<VideoPost?> userVideoPosts;
  const AccountState({
    this.profileDetailsResponse,
    this.userVideoPosts = const [],
  });

  @override
  List<Object?> get props => <Object?>[profileDetailsResponse, userVideoPosts];

  AccountState copyWith({
    ProfileDetailsResponse? profileDetailsResponse,
    List<VideoPost>? userVideoPosts,
  }) {
    return AccountState(
      profileDetailsResponse:
          profileDetailsResponse ?? this.profileDetailsResponse,
      userVideoPosts: userVideoPosts ?? this.userVideoPosts,
    );
  }
}
