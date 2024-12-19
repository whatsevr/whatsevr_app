part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  final UserCommunitiesResponse? userCommunitiesResponse;
  final bool isPushNotificationsEnabled;
  final bool isEmailNotificationsEnabled;
  final bool isPostNotificationsEnabled;
  final bool isBusinessPortfolio;
  final bool isBiometricEnabled;
  final GetUserLoginSessionsResponse? loginSessionsResponse;
  final Map<String, bool> permissions;
  final Map<String, bool> notificationTypes;

  const SettingsState({
    this.userCommunitiesResponse,
    this.isPushNotificationsEnabled = false,
    this.isEmailNotificationsEnabled = false,
    this.isPostNotificationsEnabled = false,
    this.isBusinessPortfolio = false,
    this.isBiometricEnabled = false,
    this.loginSessionsResponse,
    this.notificationTypes = const {
      'global': false,
      'account': false,
      'promotional': false,
    },
    this.permissions = const {
      'notification': false,
      'camera': false,
      'storage': false,
      'location': false,
      'microphone': false,
    },
  });

  @override
  List<Object?> get props => [
        userCommunitiesResponse,
        isPushNotificationsEnabled,
        isEmailNotificationsEnabled,
        isPostNotificationsEnabled,
        isBusinessPortfolio,
        isBiometricEnabled,
        loginSessionsResponse,
        permissions,
        notificationTypes,
      ];

  SettingsState copyWith({
    UserCommunitiesResponse? userCommunitiesResponse,
    bool? isPushNotificationsEnabled,
    bool? isEmailNotificationsEnabled,
    bool? isPostNotificationsEnabled,
    bool? isBusinessPortfolio,
    bool? isBiometricEnabled,
    GetUserLoginSessionsResponse? loginSessionsResponse,
    Map<String, bool>? notificationTypes,
    Map<String, bool>? permissions,
  }) {
    return SettingsState(
      userCommunitiesResponse: userCommunitiesResponse ?? this.userCommunitiesResponse,
      isPushNotificationsEnabled: isPushNotificationsEnabled ?? this.isPushNotificationsEnabled,
      isEmailNotificationsEnabled: isEmailNotificationsEnabled ?? this.isEmailNotificationsEnabled,
      isPostNotificationsEnabled: isPostNotificationsEnabled ?? this.isPostNotificationsEnabled,
      isBusinessPortfolio: isBusinessPortfolio ?? this.isBusinessPortfolio,
      isBiometricEnabled: isBiometricEnabled ?? this.isBiometricEnabled,
      loginSessionsResponse: loginSessionsResponse ?? this.loginSessionsResponse,
      notificationTypes: notificationTypes ?? this.notificationTypes,
      permissions: permissions ?? this.permissions,
    );
  }
}
