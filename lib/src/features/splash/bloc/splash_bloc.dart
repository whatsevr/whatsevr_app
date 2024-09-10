import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';
import 'package:supabase/supabase.dart';
import 'package:whatsevr_app/config/api/response_model/user_profile.dart';

import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/routes/routes_name.dart';
import 'package:otpless_flutter/otpless_flutter.dart';

import '../../../../config/api/methods/users.dart';
import '../../../../config/api/response_model/auth_user.dart';
import '../../../../config/services/auth_db.dart';

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
    await Future.delayed(const Duration(seconds: 3));

    AuthorisedUserResponse? loggedAuthorisedUserResponse =
        await AuthUserDb.getLastLoggedAuthorisedUser();
    if (loggedAuthorisedUserResponse != null) {
      AppNavigationService.newRoute(RoutesName.dashboard);
    } else {
      add(LoginOrSignupEvent());
    }
  }

  FutureOr<void> _onLoginOrSignup(
      LoginOrSignupEvent event, Emitter<SplashState> emit) async {
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
      CheckUserStatus event, Emitter<SplashState> emit) async {
    try {
      AuthorisedUserResponse? authorisedUserResponse =
          AuthorisedUserResponse.fromMap(event.authUserData!);
      UserDetailsResponse? userStatusResponse = await UsersApi.getUserDetails(
        userUid: authorisedUserResponse.data!.userId!,
      );
      await AuthUserDb.saveAuthorisedUser(authorisedUserResponse);
      await AuthUserDb.saveLastLoggedUserId(authorisedUserResponse);
      SmartDialog.showToast('${userStatusResponse!.message}');

      AppNavigationService.newRoute(RoutesName.dashboard);
    } catch (e) {
      SmartDialog.showToast('Error: $e');
      if (kDebugMode) rethrow;
    }
  }
}
