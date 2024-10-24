import 'dart:developer';
import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:otpless_flutter/otpless_flutter.dart';
import 'package:whatsevr_app/config/api/methods/auth.dart';

import 'package:whatsevr_app/config/api/response_model/auth/login.dart';
import 'package:whatsevr_app/config/api/response_model/auth_service_user.dart';
import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/routes/routes_name.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';
import 'package:collection/collection.dart';
import 'package:whatsevr_app/config/widgets/auth_dialogs.dart';
import 'package:whatsevr_app/config/widgets/showAppModalSheet.dart';
import 'package:whatsevr_app/dev/talker.dart';

class AuthUserService {
  AuthUserService._privateConstructor();

  static final AuthUserService _instance =
      AuthUserService._privateConstructor();

  static AuthUserService get instance => _instance;

  static Future<void> logOutAllUser({
    bool startFomBegin = false,
  }) async {
    await AuthUserDb.clearAllAuthData();

    if (startFomBegin) {
      AppNavigationService.clearAllAndNewRoute(RoutesName.auth);
    }
  }

  static Future<void> loginWithOtpLessService({
    required Function(String userUid, String? mobileNumber, String? emailId)
        onLoginSuccess,
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
          String? emailId = authServiceUserResponse.data?.identities
              ?.firstWhereOrNull(
                (element) => element.identityType == 'EMAIL',
              )
              ?.identityValue;
          String? mobileNumber = authServiceUserResponse.data?.identities
              ?.firstWhereOrNull(
                (element) => element.identityType == 'MOBILE',
              )
              ?.identityValue;
          TalkerService.instance.log({
            'event': 'login_with_otpless',
            'user_uid': authServiceUserResponse.data!.userId!,
            'mobile_number': mobileNumber,
            'email_id': emailId,
          });
          if (emailId == null && mobileNumber == null) {
            onLoginFailed('Email id and mobile number both are empty');
            return;
          }
          onLoginSuccess(
              authServiceUserResponse.data!.userId!, mobileNumber, emailId);
        } else {
          onLoginFailed('${result['errorMessage']}');
        }
      },
      arg,
    );
  }

  static Future<void> loginToApp(
      {required String userUid,
      required String? mobileNumber,
      required String? emailId}) async {
    (int?, String?, LoginSuccessResponse?)? loginInfo = await AuthApi.login(
      userUid,
      mobileNumber,
      emailId,
    );
    if (loginInfo?.$1 == HttpStatus.ok) {
      await AuthUserDb.saveAuthorisedUserUid(userUid);
      await AuthUserDb.saveLastLoggedUserUid(userUid);
      FirebaseCrashlytics.instance.setUserIdentifier(userUid);
      FirebaseAnalytics.instance.setUserId(id: userUid);
      FirebaseAnalytics.instance.setUserProperty(
        name: 'user_uid',
        value: userUid,
      );
      FirebaseAnalytics.instance.setUserProperty(
        name: 'mobile_number',
        value: loginInfo?.$3?.userInfo?.mobileNumber,
      );
      FirebaseAnalytics.instance.setUserProperty(
        name: 'email_id',
        value: loginInfo?.$3?.userInfo?.emailId,
      );
      FirebaseAnalytics.instance.setDefaultEventParameters(
        <String, dynamic>{
          'user_uid': userUid,
          'mobile_number': loginInfo?.$3?.userInfo?.mobileNumber,
          'email_id': loginInfo?.$3?.userInfo?.emailId,
        },
      );
      AppNavigationService.clearAllAndNewRoute(RoutesName.auth);
    } else {
      if (loginInfo?.$1 == HttpStatus.notAcceptable) {
        showAppModalSheet(
          dismissPrevious: true,
          child: CreateAccountUi(
            userUid: userUid,
            mobileNumber: mobileNumber,
            emailId: emailId,
          ),
        );
      } else if (loginInfo?.$1 == HttpStatus.forbidden) {
        showAppModalSheet(
          draggableScrollable: false,
          dismissPrevious: true,
          child: AccountBannedUi(
            userUid: userUid,
            mobileNumber: mobileNumber,
            emailId: emailId,
          ),
        );
      } else if (loginInfo?.$1 == HttpStatus.partialContent) {
        showAppModalSheet(
          draggableScrollable: false,
          dismissPrevious: true,
          child: AccountIsDeactivatedStateUi(
            userUid: userUid,
            mobileNumber: mobileNumber,
            emailId: emailId,
          ),
        );
      } else {
        SmartDialog.showToast(loginInfo?.$2 ?? 'Something went wrong');
      }
    }
  }
}
