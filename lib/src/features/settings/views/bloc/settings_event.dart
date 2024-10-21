part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();
}

class InitialEvent extends SettingsEvent {
  @override
  List<Object> get props => [];
}

class LoadUserCommunitiesEvent extends SettingsEvent {
  @override
  List<Object> get props => [];
}
