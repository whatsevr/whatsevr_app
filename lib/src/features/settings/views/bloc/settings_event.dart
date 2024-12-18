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

class UpdateNotificationPreferences extends SettingsEvent {
  final bool isPushEnabled;
  final bool isEmailEnabled;
  final bool isPostEnabled;
  const UpdateNotificationPreferences({
    required this.isPushEnabled,
    required this.isEmailEnabled,
    required this.isPostEnabled,
  });
  @override
  List<Object> get props => [isPushEnabled, isEmailEnabled, isPostEnabled];
}

class UpdatePrivacySettings extends SettingsEvent {
  final bool isProfileVisible;
  final bool isActivityStatusVisible;
  final String messageRequests;
  const UpdatePrivacySettings({
    required this.isProfileVisible,
    required this.isActivityStatusVisible,
    required this.messageRequests,
  });
  @override
  List<Object> get props =>
      [isProfileVisible, isActivityStatusVisible, messageRequests];
}



class UpdateSecuritySettings extends SettingsEvent {
  final bool isBiometricEnabled;
  final bool isTwoFactorEnabled;
  const UpdateSecuritySettings({
    required this.isBiometricEnabled,
    required this.isTwoFactorEnabled,
  });
  @override
  List<Object> get props => [isBiometricEnabled, isTwoFactorEnabled];
}

class UpdatePermission extends SettingsEvent {
  final String permission;
  final bool isEnabled;
  const UpdatePermission({
    required this.permission,
    required this.isEnabled,
  });
  @override
  List<Object> get props => [permission, isEnabled];
}









class UpdateNotificationType extends SettingsEvent {
  final String type;
  final bool enabled;
  const UpdateNotificationType({required this.type, required this.enabled});
  @override
  List<Object> get props => [type, enabled];
}

class UpdateAvailabilityStatus extends SettingsEvent {
  final String status;
  const UpdateAvailabilityStatus(this.status);
  @override
  List<Object> get props => [status];
}
