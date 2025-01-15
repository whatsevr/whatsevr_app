import 'dart:developer';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:otpless_flutter/otpless_flutter.dart';
import 'package:whatsevr_app/config/api/response_model/user/user_supportive_data.dart';
import 'package:whatsevr_app/config/enums/activity_type.dart';
import 'package:whatsevr_app/config/services/activity_track/activity_tracking.dart';
import 'package:whatsevr_app/config/services/user_agent_info.dart';

import 'package:whatsevr_app/dev/talker.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import 'package:whatsevr_app/config/api/methods/auth.dart';
import 'package:whatsevr_app/config/api/methods/users.dart';
import 'package:whatsevr_app/config/api/response_model/auth/login.dart';
import 'package:whatsevr_app/config/api/response_model/auth_service_user.dart';
import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/routes/routes_name.dart';
import 'package:whatsevr_app/config/widgets/dialogs/auth_dialogs.dart';
import 'package:whatsevr_app/config/widgets/dialogs/showAppModalSheet.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';

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
    final Map<String, String> arg = <String, String>{
      'appId': 'YAA8EYVROHZ00125AAAV',
    };

    await otplessFlutterPlugin.openLoginPage(
      (result) {
        log('auth-service-response (${result.runtimeType}): $result');

        if (result['data'] != null) {
          final OtpLessSuccessResponse authServiceUserResponse =
              OtpLessSuccessResponse.fromMap(result['data']);
          if (authServiceUserResponse.userId == null) {
            onLoginFailed('User id is received as null from auth service');
            return;
          }
          final String? emailId = authServiceUserResponse.identities
              ?.firstWhereOrNull(
                (element) => element.identityType == 'EMAIL',
              )
              ?.identityValue;
          final String? mobileNumber = authServiceUserResponse.identities
              ?.firstWhereOrNull(
                (element) => element.identityType == 'MOBILE',
              )
              ?.identityValue;
          TalkerService.instance.log({
            'event': 'login_with_otpless',
            'user_uid': authServiceUserResponse.userId!,
            'mobile_number': mobileNumber,
            'email_id': emailId,
          });
          if (emailId == null && mobileNumber == null) {
            onLoginFailed('Email id and mobile number both are empty');
            return;
          }

          onLoginSuccess(
            authServiceUserResponse.userId!,
            mobileNumber,
            emailId,
          );
        } else {
          onLoginFailed('${result['errorMessage']}');
        }
      },
      arg,
    );
  }

  static Future<void> loginToApp({
    required String userUid,
    required String? mobileNumber,
    required String? emailId,
  }) async {
    ActivityLoggingService.log(
      userUid: userUid,
      activityType: WhatsevrActivityType.system,
      metadata: {'message': 'Login  attempt'},
      priority: Priority.critical,
    );
    (int?, String?, LoginSuccessResponse?)? loginInfo = await AuthApi.login(
      userUid: userUid,
      mobileNumber: mobileNumber,
      emailId: emailId,
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
      FirebaseAnalytics.instance.setUserProperty(
        name: 'app_version',
        value: UserAgentInfoService.currentDeviceInfo?.appVersion,
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
      ActivityLoggingService.log(
        userUid: userUid,
        activityType: WhatsevrActivityType.system,
        metadata: {
          'message': 'Login failed',
          if (loginInfo?.$2 != null) 'description': loginInfo?.$2,
        },
        priority: Priority.critical,
      );
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
          flexibleSheet: false,
          dismissPrevious: true,
          child: AccountBannedUi(
            userUid: userUid,
            mobileNumber: mobileNumber,
            emailId: emailId,
          ),
        );
      } else if (loginInfo?.$1 == HttpStatus.partialContent) {
        showAppModalSheet(
          flexibleSheet: false,
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

  static UserSupportiveDataResponse? supportiveData;
  static Future<void> getUserSuppotiveData() async {
    final String? currentlyLoggedUserUid = AuthUserDb.getLastLoggedUserUid();
    try {
      supportiveData = null;
      if (currentlyLoggedUserUid != null) {
        (int?, UserSupportiveDataResponse)? supportiveDataResponse =
            await UsersApi.getSupportiveUserData(
          userUid: currentlyLoggedUserUid,
        );
        if (supportiveDataResponse?.$1 == HttpStatus.unauthorized) {
          throw BusinessException('User authenticity check failed');
        }
        supportiveData = supportiveDataResponse?.$2;
        ActivityLoggingService.log(
          activityType: WhatsevrActivityType.system,
          metadata: {'message': 'Account accessed'},
          priority: Priority.critical,
          uploadToDb: true,
        );
      }
    } catch (e, stackTrace) {
      ActivityLoggingService.log(
        activityType: WhatsevrActivityType.system,
        metadata: {
          'message': 'Account accessed failed',
        },
        priority: Priority.critical,
        uploadToDb: true,
      );
      AuthUserDb.removeAuthorisedUserUid(currentlyLoggedUserUid!);
      AuthUserDb.clearLastLoggedUserUid();
      if (AuthUserDb.getAllAuthorisedUserUid().isNotEmpty) {
        AuthUserDb.saveLastLoggedUserUid(
          AuthUserDb.getAllAuthorisedUserUid().first,
        );
      }
      AppNavigationService.clearAllAndNewRoute(RoutesName.auth);
      highLevelCatch(e, stackTrace);
    }
  }
}
