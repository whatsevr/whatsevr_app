part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  final UserCommunitiesResponse? userCommunitiesResponse;
  const SettingsState({this.userCommunitiesResponse});
  @override
  List<Object?> get props => <Object?>[userCommunitiesResponse];

  SettingsState copyWith({
    UserCommunitiesResponse? userCommunitiesResponse,
  }) {
    return SettingsState(
      userCommunitiesResponse:
          userCommunitiesResponse ?? this.userCommunitiesResponse,
    );
  }
}
