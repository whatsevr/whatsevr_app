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
  List<Object> get props => [isProfileVisible, isActivityStatusVisible, messageRequests];
}

class UpdateDataSettings extends SettingsEvent {
  final bool isDataSaverEnabled;
  final bool isAutoPlayEnabled;
  final String mediaQuality;
  const UpdateDataSettings({
    required this.isDataSaverEnabled,
    required this.isAutoPlayEnabled,
    required this.mediaQuality,
  });
  @override
  List<Object> get props => [isDataSaverEnabled, isAutoPlayEnabled, mediaQuality];
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

class UpdateInteractionSettings extends SettingsEvent {
  final bool isCommentsEnabled;
  final String tagPreference;
  const UpdateInteractionSettings({
    required this.isCommentsEnabled,
    required this.tagPreference,
  });
  @override
  List<Object> get props => [isCommentsEnabled, tagPreference];
}

class UpdateTextSize extends SettingsEvent {
  final String size;
  const UpdateTextSize(this.size);
  @override
  List<Object> get props => [size];
}

class ToggleBackup extends SettingsEvent {
  final bool enabled;
  const ToggleBackup(this.enabled);
  @override
  List<Object> get props => [enabled];
}

class ToggleDeveloperMode extends SettingsEvent {
  final bool enabled;
  const ToggleDeveloperMode(this.enabled);
  @override
  List<Object> get props => [enabled];
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
