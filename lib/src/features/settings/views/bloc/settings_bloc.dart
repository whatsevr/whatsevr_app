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


  SettingsBloc() : super(const SettingsState()) {
    on<InitialEvent>(_onInitialEvent);
    on<LoadUserCommunitiesEvent>(_onLoadUserCommunitiesEvent);
    on<UpdateNotificationPreferences>(_onUpdateNotificationPreferences);
    on<UpdatePrivacySettings>(_onUpdatePrivacySettings);

    on<UpdateSecuritySettings>(_onUpdateSecuritySettings);
    on<UpdatePermission>(_onUpdatePermission);

   
    on<UpdateNotificationType>(_onUpdateNotificationType);
    on<UpdateAvailabilityStatus>(_onUpdateAvailabilityStatus);
   
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
      
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }




  FutureOr<void> _onUpdateNotificationType(
    UpdateNotificationType event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      final newNotificationTypes =
          Map<String, bool>.from(state.notificationTypes);
      newNotificationTypes[event.type] = event.enabled;
      final newState = state.copyWith(notificationTypes: newNotificationTypes);
      emit(newState);
      

      // Update notification settings on the server
      
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _onUpdateAvailabilityStatus(
    UpdateAvailabilityStatus event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      final newState = state.copyWith(availabilityStatus: event.status);
      emit(newState);
      
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }





}
