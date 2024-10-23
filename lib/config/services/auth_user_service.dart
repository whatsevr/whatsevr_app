import 'dart:developer';
import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:otpless_flutter/otpless_flutter.dart';
import 'package:whatsevr_app/config/api/interceptors/cache.dart';
import 'package:whatsevr_app/config/api/methods/auth.dart';

import 'package:whatsevr_app/config/api/response_model/auth/login.dart';
import 'package:whatsevr_app/config/api/response_model/auth_service_user.dart';
import 'package:whatsevr_app/config/api/response_model/user_details.dart';
import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/routes/routes_name.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';

import 'package:whatsevr_app/dev/talker.dart';

class AuthUserService {
  AuthUserService._privateConstructor();

  static final AuthUserService _instance =
      AuthUserService._privateConstructor();

  static AuthUserService get instance => _instance;

  static Future<void> logOutCurrentUser({
    bool startFomBegin = false,
  }) async {
    await AuthUserDb.clearLastLoggedUserUid();

    if (startFomBegin) {
      AppNavigationService.clearAllAndNewRoute(RoutesName.auth);
    }
  }

  static Future<void> logOutAllUser({
    bool startFomBegin = false,
  }) async {
    await AuthUserDb.clearAllAuthData();

    if (startFomBegin) {
      AppNavigationService.clearAllAndNewRoute(RoutesName.auth);
    }
  }

  static Future<void> loginWithOtpLessService({
    required Function(String userUid) onLoginSuccess,
    required Function(String errorMessage) onLoginFailed,
  }) async {
    final Otpless otplessFlutterPlugin = Otpless();
    Map<String, String> arg = <String, String>{
      'appId': 'YAA8EYVROHZ00125AAAV',
    };

    await otplessFlutterPlugin.openLoginPage(
      (result) {
        log('auth-service-response (${result.runtimeType}): $result');

        if (result['data'] != null) {
          OtpLessSuccessResponse authServiceUserResponse =
              OtpLessSuccessResponse.fromMap(result);
          if (authServiceUserResponse.data?.userId == null) {
            onLoginFailed('User id is received as null from auth service');
            return;
          }
          onLoginSuccess(authServiceUserResponse.data!.userId!);
        } else {
          onLoginFailed('${result['errorMessage']}');
        }
      },
      arg,
    );
  }

  static Future<void> loginToApp(
    String userUid,
  ) async {
    (int?, String?, LoginSuccessResponse?)? loginInfo = await AuthApi.login(
      userUid,
    );
    if (loginInfo?.$1 == HttpStatus.ok) {
      await AuthUserDb.saveAuthorisedUserUid(userUid);
      await AuthUserDb.saveLastLoggedUserUid(userUid);

      AppNavigationService.clearAllAndNewRoute(RoutesName.dashboard);
      FirebaseCrashlytics.instance.setUserIdentifier(userUid);
      FirebaseAnalytics.instance.setUserId(id: userUid);
      FirebaseAnalytics.instance.setUserProperty(
        name: 'user_uid',
        value: userUid,
      );
    } else {
      SmartDialog.showToast('Failed to login, ${loginInfo?.$2}');
    }
  }
}
