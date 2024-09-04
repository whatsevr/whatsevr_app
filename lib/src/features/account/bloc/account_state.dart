part of 'account_bloc.dart';

class AccountState extends Equatable {
  final ProfileDetailsResponse? profileDetailsResponse;
  const AccountState({
    this.profileDetailsResponse,
  });

  @override
  List<Object?> get props => [profileDetailsResponse];

  AccountState copyWith({
    ProfileDetailsResponse? profileDetailsResponse,
  }) {
    return AccountState(
      profileDetailsResponse:
          profileDetailsResponse ?? this.profileDetailsResponse,
    );
  }
}
