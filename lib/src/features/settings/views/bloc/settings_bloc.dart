import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import 'package:whatsevr_app/config/api/methods/community.dart';
import 'package:whatsevr_app/config/api/response_model/community/user_communities.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  static const String settingsBoxName = 'settings';
  late Box<SettingsState> _settingsBox;

  SettingsBloc() : super(const SettingsState()) {
    on<InitialEvent>(_onInitialEvent);
    on<LoadUserCommunitiesEvent>(_onLoadUserCommunitiesEvent);
    on<UpdateNotificationPreferences>(_onUpdateNotificationPreferences);
    on<UpdatePrivacySettings>(_onUpdatePrivacySettings);
    on<UpdateDataSettings>(_onUpdateDataSettings);
    on<UpdateSecuritySettings>(_onUpdateSecuritySettings);
    on<UpdatePermission>(_onUpdatePermission);
    on<UpdateInteractionSettings>(_onUpdateInteractionSettings);
    on<UpdateTextSize>(_onUpdateTextSize);
    on<ToggleBackup>(_onToggleBackup);
    on<ToggleDeveloperMode>(_onToggleDeveloperMode);
    on<UpdateNotificationType>(_onUpdateNotificationType);
    _initHive();
  }

  Future<void> _initHive() async {
    _settingsBox = await Hive.openBox<SettingsState>(settingsBoxName);
    final savedSettings = _settingsBox.get('userSettings');
    if (savedSettings != null) { 
      emit(savedSettings);
    }
  }

  Future<void> _saveSettings(SettingsState settings) async {
    await _settingsBox.put('userSettings', settings);
  }

  FutureOr<void> _onInitialEvent(
    InitialEvent event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      add(LoadUserCommunitiesEvent());
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _onLoadUserCommunitiesEvent(
    LoadUserCommunitiesEvent event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      final UserCommunitiesResponse? userCommunitiesResponse =
          await CommunityApi.getUserCommunities(
        userUid: (AuthUserDb.getLastLoggedUserUid())!,
      );

      emit(state.copyWith(userCommunitiesResponse: userCommunitiesResponse));
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _onUpdateNotificationPreferences(
    UpdateNotificationPreferences event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      final newState = state.copyWith(
        isPushNotificationsEnabled: event.isPushEnabled,
        isEmailNotificationsEnabled: event.isEmailEnabled,
        isPostNotificationsEnabled: event.isPostEnabled,
      );
      emit(newState);
      await _saveSettings(newState);
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _onUpdatePrivacySettings(
    UpdatePrivacySettings event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      final newState = state.copyWith(
        isProfileVisible: event.isProfileVisible,
        isActivityStatusVisible: event.isActivityStatusVisible,
        messageRequestsPreference: event.messageRequests,
      );
      emit(newState);
      await _saveSettings(newState);
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _onUpdateDataSettings(
    UpdateDataSettings event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      final newState = state.copyWith(
        isDataSaverEnabled: event.isDataSaverEnabled,
        isAutoPlayEnabled: event.isAutoPlayEnabled,
        mediaQuality: event.mediaQuality,
      );
      emit(newState);
      await _saveSettings(newState);
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _onUpdateSecuritySettings(
    UpdateSecuritySettings event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      final newState = state.copyWith(
        isBiometricEnabled: event.isBiometricEnabled,
        isTwoFactorEnabled: event.isTwoFactorEnabled,
      );
      emit(newState);
      await _saveSettings(newState);
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _onUpdatePermission(
    UpdatePermission event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      final newPermissions = Map<String, bool>.from(state.permissions);
      newPermissions[event.permission] = event.isEnabled;
      final newState = state.copyWith(permissions: newPermissions);
      emit(newState);
      await _saveSettings(newState);
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _onUpdateInteractionSettings(
    UpdateInteractionSettings event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      final newState = state.copyWith(
        isCommentsEnabled: event.isCommentsEnabled,
        tagPreference: event.tagPreference,
      );
      emit(newState);
      await _saveSettings(newState);
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _onUpdateTextSize(
    UpdateTextSize event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      final newState = state.copyWith(textSize: event.size);
      emit(newState);
      await _saveSettings(newState);
      
      // Apply text size changes to app
      await _applyTextSizeChanges(event.size);
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _onToggleBackup(
    ToggleBackup event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      final newState = state.copyWith(isBackupEnabled: event.enabled);
      emit(newState);
      await _saveSettings(newState);

      if (event.enabled) {
        // Initialize backup service
        await _initializeBackup();
      } else {
        // Disable backup service
        await _disableBackup();
      }
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _onToggleDeveloperMode(
    ToggleDeveloperMode event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      final newState = state.copyWith(isDeveloperMode: event.enabled);
      emit(newState);
      await _saveSettings(newState);

      if (event.enabled) {
        // Enable developer features
        await _enableDeveloperFeatures();
      } else {
        // Disable developer features
        await _disableDeveloperFeatures();
      }
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _onUpdateNotificationType(
    UpdateNotificationType event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      final newNotificationTypes = Map<String, bool>.from(state.notificationTypes);
      newNotificationTypes[event.type] = event.enabled;
      final newState = state.copyWith(notificationTypes: newNotificationTypes);
      emit(newState);
      await _saveSettings(newState);

      // Update notification settings on the server
      await _updateNotificationSettings(event.type, event.enabled);
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  // Helper methods for the handlers
  Future<void> _applyTextSizeChanges(String size) async {
    // Implement text size changes throughout the app
    // This could involve updating a global text scale factor
    // or triggering a rebuild of the app with new text sizes
  }

  Future<void> _initializeBackup() async {
    // Initialize backup service
    // This could involve setting up cloud backup
    // or local backup mechanisms
  }

  Future<void> _disableBackup() async {
    // Disable backup service
    // Clean up any backup-related resources
  }

  Future<void> _enableDeveloperFeatures() async {
    // Enable developer features like
    // - Debug logging
    // - Performance monitoring
    // - Test environments
  }

  Future<void> _disableDeveloperFeatures() async {
    // Disable developer features and clean up
    // any developer-related resources
  }

  Future<void> _updateNotificationSettings(String type, bool enabled) async {
    // Update notification settings on the server
    // This could involve API calls to update user preferences
  }

  @override
  Future<void> close() {
    _settingsBox.close();
    return super.close();
  }
}
