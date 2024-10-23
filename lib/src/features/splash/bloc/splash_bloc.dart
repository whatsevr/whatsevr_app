import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import 'package:whatsevr_app/config/api/methods/auth.dart';
import 'package:whatsevr_app/config/api/response_model/auth/login.dart';

import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/routes/routes_name.dart';

import 'package:whatsevr_app/config/api/response_model/auth_service_user.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';
import 'package:whatsevr_app/config/services/auth_user_service.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashState()) {
    on<InitialEvent>(_onInitial);
    on<InitiateAuthServiceEvent>(_onInitiateAuthService);
    on<ContinueToLoginAndRegisterEvent>(_onContinueToLoginAndRegister);
  }

  FutureOr<void> _onInitial(
    InitialEvent event,
    Emitter<SplashState> emit,
  ) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      String? lastLoggedUserUid = AuthUserDb.getLastLoggedUserUid();
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
      onLoginSuccess: (userUid) {
        add(ContinueToLoginAndRegisterEvent(userUid: userUid));
      },
      onLoginFailed: (errorMessage) {
        SmartDialog.showToast(errorMessage);
      },
    );
  }

  FutureOr<void> _onContinueToLoginAndRegister(
    ContinueToLoginAndRegisterEvent event,
    Emitter<SplashState> emit,
  ) async {
    try {
      (int?, String?, LoginSuccessResponse?)? loginInfo = await AuthApi.login(
        event.userUid,
      );
      if (loginInfo?.$1 == HttpStatus.ok) {
        await AuthUserDb.saveAuthorisedUserUid(loginInfo!.$3!.userInfo!.uid!);
        await AuthUserDb.saveLastLoggedUserUid(loginInfo.$3!.userInfo!.uid!);

        FirebaseCrashlytics.instance
            .setUserIdentifier(loginInfo.$3!.userInfo!.uid!);
        FirebaseAnalytics.instance.setUserId(id: loginInfo.$3!.userInfo!.uid!);
        FirebaseAnalytics.instance.logLogin(loginMethod: 'OTP');
        FirebaseAnalytics.instance.setUserProperty(
          name: 'mobile_number',
          value: loginInfo.$3?.userInfo?.mobileNumber,
        );
        FirebaseAnalytics.instance.setUserProperty(
          name: 'email_id',
          value: loginInfo.$3?.userInfo?.emailId,
        );
        FirebaseAnalytics.instance.setDefaultEventParameters(
          <String, dynamic>{
            'user_uid': loginInfo.$3?.userInfo?.uid,
            'mobile_number': loginInfo.$3?.userInfo?.mobileNumber,
            'email_id': loginInfo.$3?.userInfo?.emailId,
          },
        );
        SmartDialog.showToast('Login Successful');

        AppNavigationService.clearAllAndNewRoute(RoutesName.dashboard);
      } else {
        SmartDialog.showToast('${loginInfo?.$2}');
      }
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }
}
