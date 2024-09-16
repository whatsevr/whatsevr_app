import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:whatsevr_app/config/api/response_model/user_profile.dart';

import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/routes/routes_name.dart';
import 'package:otpless_flutter/otpless_flutter.dart';

import 'package:whatsevr_app/config/api/methods/users.dart';
import 'package:whatsevr_app/config/api/response_model/auth_user.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashState()) {
    on<InitialEvent>(_onInitial);
    on<LoginOrSignupEvent>(_onLoginOrSignup);
    on<CheckUserStatus>(_onCheckUserStatus);
  }

  FutureOr<void> _onInitial(
    InitialEvent event,
    Emitter<SplashState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 1));

    AuthServiceUserResponse? loggedAuthorisedUserResponse =
        await AuthUserDb.getLastLoggedAuthorisedUser();
    if (loggedAuthorisedUserResponse?.data?.userId != null) {
      AppNavigationService.newRoute(RoutesName.dashboard);
      FirebaseCrashlytics.instance
          .setUserIdentifier(loggedAuthorisedUserResponse!.data!.userId!);
      FirebaseAnalytics.instance
          .setUserId(id: loggedAuthorisedUserResponse.data!.userId!);
      FirebaseAnalytics.instance.logLogin(loginMethod: 'Auto Login From Local');
      FirebaseAnalytics.instance.setUserProperty(
        name: 'user_uid',
        value: loggedAuthorisedUserResponse.data?.userId,
      );
    } else {
      add(const LoginOrSignupEvent());
    }
    FirebaseAnalytics.instance.logAppOpen();
  }

  FutureOr<void> _onLoginOrSignup(
    LoginOrSignupEvent event,
    Emitter<SplashState> emit,
  ) async {
    final Otpless otplessFlutterPlugin = Otpless();
    Map<String, String> arg = <String, String>{
      'appId': 'YAA8EYVROHZ00125AAAV',
    };

    await otplessFlutterPlugin.openLoginPage(
      (result) {
        log('result XXXXX: $result');
        print(result.runtimeType);
        if (result['data'] != null) {
          add(CheckUserStatus(authUserData: result));
        } else {
          SmartDialog.showToast('${result['errorMessage']}');
        }
      },
      arg,
    );
  }

  FutureOr<void> _onCheckUserStatus(
    CheckUserStatus event,
    Emitter<SplashState> emit,
  ) async {
    try {
      AuthServiceUserResponse? authServiceUserResponse =
          AuthServiceUserResponse.fromMap(event.authUserData!);
      if (authServiceUserResponse.data?.userId == null ||
          authServiceUserResponse.data!.userId!.isEmpty) {
        throw Exception(
            'Unable to get user details from auth service provider');
      }
      UserDetailsResponse? userStatusResponse = await UsersApi.getUserDetails(
        userUid: authServiceUserResponse.data!.userId!,
      );
      await AuthUserDb.saveAuthorisedUser(authServiceUserResponse);
      await AuthUserDb.saveLastLoggedUserId(authServiceUserResponse);

      FirebaseCrashlytics.instance
          .setUserIdentifier(authServiceUserResponse.data!.userId!);
      FirebaseAnalytics.instance
          .setUserId(id: authServiceUserResponse.data!.userId!);
      FirebaseAnalytics.instance.logLogin(loginMethod: 'OTP');
      FirebaseAnalytics.instance.setUserProperty(
        name: 'mobile_number',
        value: userStatusResponse?.data?.mobileNumber,
      );
      FirebaseAnalytics.instance.setUserProperty(
        name: 'email_id',
        value: userStatusResponse?.data?.emailId,
      );
      FirebaseAnalytics.instance.setDefaultEventParameters(
        <String, dynamic>{
          'user_uid': authServiceUserResponse.data?.userId,
          'mobile_number': userStatusResponse?.data?.mobileNumber,
          'email_id': userStatusResponse?.data?.emailId,
        },
      );
      SmartDialog.showToast('${userStatusResponse!.message}');

      AppNavigationService.newRoute(RoutesName.dashboard);
    } catch (e) {
      SmartDialog.showToast('Error: $e');
      if (kDebugMode) rethrow;
    }
  }
}
