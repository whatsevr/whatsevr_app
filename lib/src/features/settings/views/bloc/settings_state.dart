part of 'settings_bloc.dart';

@HiveType(typeId: 2) // Adjust typeId as needed
class SettingsState extends Equatable {
  @HiveField(0)
  final UserCommunitiesResponse? userCommunitiesResponse;
  @HiveField(1)
  final bool isPushNotificationsEnabled;
  @HiveField(2)
  final bool isEmailNotificationsEnabled;
  @HiveField(3)
  final bool isBusinessPortfolio;
  @HiveField(4)
  final bool isBiometricEnabled;
  @HiveField(5)
  final bool isActivityStatusVisible;
  @HiveField(6)
  final bool isDataSaverEnabled;
  @HiveField(7)
  final bool isAutoPlayEnabled;
  @HiveField(8)
  final String selectedLanguage;
  @HiveField(9)
  final String contentFilterLevel;
  @HiveField(10)
  final String mediaQuality;
  @HiveField(11)
  final bool isTwoFactorEnabled;
  @HiveField(12)
  final Map<String, bool> permissions;
  @HiveField(13)
  final bool isPostNotificationsEnabled;
  @HiveField(14)
  final String messageRequestsPreference;
  @HiveField(15)
  final bool isCommentsEnabled;
  @HiveField(16)
  final String tagPreference;
  @HiveField(17)
  final bool isBackupEnabled;
  @HiveField(18)
  final String textSize;
  @HiveField(19)
  final Map<String, bool> notificationTypes;
  @HiveField(20)
  final bool isDeveloperMode;
  @HiveField(21)
  final String availabilityStatus;

  const SettingsState({
    this.userCommunitiesResponse,
    this.isPushNotificationsEnabled = true,
    this.isEmailNotificationsEnabled = true,
    this.isBusinessPortfolio = true,
    this.isBiometricEnabled = false,
    this.isActivityStatusVisible = true,
    this.isDataSaverEnabled = false,
    this.isAutoPlayEnabled = true,
    this.selectedLanguage = 'English (US)',
    this.contentFilterLevel = 'Standard',
    this.mediaQuality = 'High',
    this.isTwoFactorEnabled = false,
    this.isPostNotificationsEnabled = true,
    this.messageRequestsPreference = 'Everyone',
    this.isCommentsEnabled = true,
    this.tagPreference = 'Everyone',
    this.isBackupEnabled = false,
    this.textSize = 'Medium',
    this.isDeveloperMode = false,
    this.notificationTypes = const {
      'global': true,
      'account': true,
      'promotional': true,
    },
    this.permissions = const {
      'camera': true,
      'storage': true,
      'location': true,
      'microphone': true,
    },
    this.availabilityStatus = 'Available',
  });

  @override
  List<Object?> get props => [
        userCommunitiesResponse,
        isPushNotificationsEnabled,
        isEmailNotificationsEnabled,
        isBusinessPortfolio,
        isBiometricEnabled,
        isActivityStatusVisible,
        isDataSaverEnabled,
        isAutoPlayEnabled,
        selectedLanguage,
        contentFilterLevel,
        mediaQuality,
        isTwoFactorEnabled,
        permissions,
        isPostNotificationsEnabled,
        messageRequestsPreference,
        isCommentsEnabled,
        tagPreference,
        isBackupEnabled,
        textSize,
        notificationTypes,
        isDeveloperMode,
        availabilityStatus,
      ];

  SettingsState copyWith({
    UserCommunitiesResponse? userCommunitiesResponse,
    bool? isPushNotificationsEnabled,
    bool? isEmailNotificationsEnabled,
    bool? isProfileVisible,
    bool? isBiometricEnabled,
    bool? isActivityStatusVisible,
    bool? isDataSaverEnabled,
    bool? isAutoPlayEnabled,
    String? selectedLanguage,
    String? contentFilterLevel,
    String? mediaQuality,
    bool? isTwoFactorEnabled,
    bool? isPostNotificationsEnabled,
    String? messageRequestsPreference,
    bool? isCommentsEnabled,
    String? tagPreference,
    bool? isBackupEnabled,
    String? textSize,
    bool? isDeveloperMode,
    Map<String, bool>? notificationTypes,
    Map<String, bool>? permissions,
    String? availabilityStatus,
  }) {
    return SettingsState(
      userCommunitiesResponse:
          userCommunitiesResponse ?? this.userCommunitiesResponse,
      isPushNotificationsEnabled:
          isPushNotificationsEnabled ?? this.isPushNotificationsEnabled,
      isEmailNotificationsEnabled:
          isEmailNotificationsEnabled ?? this.isEmailNotificationsEnabled,
      isBusinessPortfolio: isProfileVisible ?? this.isBusinessPortfolio,
      isBiometricEnabled: isBiometricEnabled ?? this.isBiometricEnabled,
      isActivityStatusVisible:
          isActivityStatusVisible ?? this.isActivityStatusVisible,
      isDataSaverEnabled: isDataSaverEnabled ?? this.isDataSaverEnabled,
      isAutoPlayEnabled: isAutoPlayEnabled ?? this.isAutoPlayEnabled,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      contentFilterLevel: contentFilterLevel ?? this.contentFilterLevel,
      mediaQuality: mediaQuality ?? this.mediaQuality,
      isTwoFactorEnabled: isTwoFactorEnabled ?? this.isTwoFactorEnabled,
      isPostNotificationsEnabled:
          isPostNotificationsEnabled ?? this.isPostNotificationsEnabled,
      messageRequestsPreference:
          messageRequestsPreference ?? this.messageRequestsPreference,
      isCommentsEnabled: isCommentsEnabled ?? this.isCommentsEnabled,
      tagPreference: tagPreference ?? this.tagPreference,
      isBackupEnabled: isBackupEnabled ?? this.isBackupEnabled,
      textSize: textSize ?? this.textSize,
      isDeveloperMode: isDeveloperMode ?? this.isDeveloperMode,
      notificationTypes: notificationTypes ?? this.notificationTypes,
      permissions: permissions ?? this.permissions,
      availabilityStatus: availabilityStatus ?? this.availabilityStatus,
    );
  }
}
