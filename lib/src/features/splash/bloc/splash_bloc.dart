import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:supabase/supabase.dart';
import 'package:whatsevr_app/config/api/response_model/user_status.dart';

import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/routes/routes_name.dart';
import 'package:otpless_flutter/otpless_flutter.dart';

import '../../../../config/api/methods/users.dart';
import '../../../../config/api/response_model/user.dart';
import '../../../../config/services/logged_user.dart';

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
    await Future.delayed(const Duration(seconds: 2));
    AuthorisedUserResponse? user = await LoggedUser.getLoggedUser();
    if (user != null) {
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
        if (result['data']['userId'].isNotEmpty) {
          add(CheckUserStatus(userUid: result['data']['userId']));
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
      UserStatusResponse? userStatusResponse = await UsersApi.checkUserStatus(
        userUid: event.userUid!,
      );
      SmartDialog.showToast('${userStatusResponse!.message}');
    } catch (e) {
      SmartDialog.showToast('Error: $e');
      if (kDebugMode) rethrow;
    }
  }
}
