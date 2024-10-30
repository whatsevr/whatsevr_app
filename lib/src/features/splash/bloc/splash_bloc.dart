import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../../../config/api/external/models/business_validation_exception.dart';
import '../../../../config/routes/router.dart';
import '../../../../config/routes/routes_name.dart';
import '../../../../config/services/auth_db.dart';
import '../../../../config/services/auth_user_service.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashState()) {
    on<InitialEvent>(_onInitial);
    on<InitiateAuthServiceEvent>(_onInitiateAuthService);
  }

  FutureOr<void> _onInitial(
    InitialEvent event,
    Emitter<SplashState> emit,
  ) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final String? lastLoggedUserUid = AuthUserDb.getLastLoggedUserUid();
      if (lastLoggedUserUid == null) {
        add(const InitiateAuthServiceEvent());
        return;
      }

      AppNavigationService.clearAllAndNewRoute(RoutesName.dashboard);
      FirebaseAnalytics.instance.logLogin(loginMethod: 'Auto Login From Local');
    } catch (e, stackTrace) {
      add(const InitiateAuthServiceEvent());
      highLevelCatch(e, stackTrace);
    }

    FirebaseAnalytics.instance.logAppOpen();
  }

  FutureOr<void> _onInitiateAuthService(
    InitiateAuthServiceEvent event,
    Emitter<SplashState> emit,
  ) async {
    await AuthUserService.loginWithOtpLessService(
      onLoginSuccess: (userUid, mobileNumber, emailId) {
        AuthUserService.loginToApp(
            userUid: userUid, mobileNumber: mobileNumber, emailId: emailId,);
      },
      onLoginFailed: (errorMessage) {
        SmartDialog.showToast(errorMessage);
      },
    );
  }
}
