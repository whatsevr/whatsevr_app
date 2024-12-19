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

// Replace UpdateNotificationPreferences with:
class UpdatePushNotification extends SettingsEvent {
  final bool isEnabled;
  const UpdatePushNotification({required this.isEnabled});
  @override
  List<Object> get props => [isEnabled];
}

class UpdateEmailNotification extends SettingsEvent {
  final bool isEnabled;
  const UpdateEmailNotification({required this.isEnabled});
  @override
  List<Object> get props => [isEnabled];
}

class UpdatePostNotification extends SettingsEvent {
  final bool isEnabled;
  const UpdatePostNotification({required this.isEnabled});
  @override
  List<Object> get props => [isEnabled];
}

// Removed UpdatePrivacySettings and replaced with the following three events

class TooglePortfolioStatus extends SettingsEvent {
  final bool isVisible;
  const TooglePortfolioStatus({required this.isVisible});
  @override
  List<Object> get props => [isVisible];
}





// Replace UpdateSecuritySettings with:
class UpdateBiometricSecurity extends SettingsEvent {
  final bool isEnabled;
  const UpdateBiometricSecurity({required this.isEnabled});
  @override
  List<Object> get props => [isEnabled];
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

class UpdatePermissionsStatus extends SettingsEvent {
  final Map<String, bool> permissions;
  const UpdatePermissionsStatus({required this.permissions});
  @override
  List<Object> get props => [permissions];
}

class LoadLoginSessionsEvent extends SettingsEvent {
  @override
  List<Object> get props => [];
}

class LogoutDeviceEvent extends SettingsEvent {
  final String sessionId;
  const LogoutDeviceEvent(this.sessionId);
  @override
  List<Object> get props => [sessionId];
}


