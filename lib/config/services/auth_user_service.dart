import 'dart:developer';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:otpless_flutter/otpless_flutter.dart';
import 'package:whatsevr_app/config/services/follow_unfollow_middleware.dart';
import 'package:whatsevr_app/config/services/react_unreact_middleware.dart';

import '../../dev/talker.dart';
import '../api/external/models/business_validation_exception.dart';
import '../api/methods/auth.dart';
import '../api/methods/users.dart';
import '../api/response_model/auth/login.dart';
import '../api/response_model/auth_service_user.dart';
import '../routes/router.dart';
import '../routes/routes_name.dart';
import '../widgets/dialogs/auth_dialogs.dart';
import '../widgets/dialogs/showAppModalSheet.dart';
import 'auth_db.dart';

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
      FollowUnfollowMiddleware.fetchAndCacheAllFollowedUsers();
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

  static Future<void> getSupportiveDataForLoggedUser() async {
    final String? currentlyLoggedUserUid = AuthUserDb.getLastLoggedUserUid();
    try {
      if (currentlyLoggedUserUid != null) {
        ReactUnreactMiddleware.fetchAndCacheReactions();
        FollowUnfollowMiddleware.fetchAndCacheAllFollowedUsers();
        (int?, dynamic)? supportiveDataResponse =
            await UsersApi.getSupportiveUserData(
          userUid: currentlyLoggedUserUid,
        );
        if (supportiveDataResponse?.$1 != HttpStatus.ok) {
          throw BusinessException('Failed to fetch logged user data');
        }
      }
    } catch (e, stackTrace) {
      AuthUserDb.clearLastLoggedUserUid();
      AppNavigationService.clearAllAndNewRoute(RoutesName.auth);
      highLevelCatch(e, stackTrace);
    }
  }
}
