import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import 'package:whatsevr_app/config/api/methods/community.dart';
import 'package:whatsevr_app/config/api/response_model/community/user_communities.dart';
import 'package:whatsevr_app/config/api/response_model/security/get_user_logins.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';
import 'package:whatsevr_app/config/api/methods/security.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState()) {
    on<InitialEvent>(_onInitialEvent);
    on<LoadUserCommunitiesEvent>(_onLoadUserCommunitiesEvent);
    on<UpdatePermission>(_onUpdatePermission);
    on<UpdateNotificationType>(_onUpdateNotificationType);
    on<TooglePortfolioStatus>(_onPortfolioStatus);
    on<UpdatePushNotification>(_onUpdatePushNotification);
    on<UpdateEmailNotification>(_onUpdateEmailNotification);
    on<UpdatePostNotification>(_onUpdatePostNotification);
    on<UpdateBiometricSecurity>(_onUpdateBiometricSecurity);
    on<UpdatePermissionsStatus>(_onUpdatePermissionsStatus);
    on<LoadLoginSessionsEvent>(_onLoadLoginSessions);
    on<LogoutDeviceEvent>(_onLogoutDevice);
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



  FutureOr<void> _onPortfolioStatus(
    TooglePortfolioStatus event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      emit(state.copyWith(isBusinessPortfolio: event.isVisible));
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }





  FutureOr<void> _onUpdatePushNotification(
    UpdatePushNotification event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      emit(state.copyWith(isPushNotificationsEnabled: event.isEnabled));
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _onUpdateEmailNotification(
    UpdateEmailNotification event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      emit(state.copyWith(isEmailNotificationsEnabled: event.isEnabled));
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _onUpdatePostNotification(
    UpdatePostNotification event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      emit(state.copyWith(isPostNotificationsEnabled: event.isEnabled));
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _onUpdateBiometricSecurity(
    UpdateBiometricSecurity event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      emit(state.copyWith(isBiometricEnabled: event.isEnabled));
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _onUpdatePermissionsStatus(
    UpdatePermissionsStatus event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      emit(state.copyWith(permissions: event.permissions));
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _onLoadLoginSessions(
    LoadLoginSessionsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      final response = await SecurityApi.getDeviceLogins(
        userUid: AuthUserDb.getLastLoggedUserUid(),
      );
      if (response != null) {
        emit(state.copyWith(loginSessionsResponse: response));
      }
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _onLogoutDevice(
    LogoutDeviceEvent event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      // TODO: Implement logout device API call
      // After successful logout, reload sessions
      add(LoadLoginSessionsEvent());
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }
}


