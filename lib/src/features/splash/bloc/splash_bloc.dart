import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../../../config/routes/router.dart';
import '../../../../config/routes/routes_name.dart';
import 'package:otpless_flutter/otpless_flutter.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashState()) {
    on<InitialEvent>(_onInitial);
  }

  FutureOr<void> _onInitial(
      InitialEvent event, Emitter<SplashState> emit) async {
    await Future.delayed(const Duration(seconds: 2));
    final Otpless otplessFlutterPlugin = Otpless();
    var arg = {
      'appId': 'YAA8EYVROHZ00125AAAV',
    };

    String token = "";
    await otplessFlutterPlugin.openLoginPage((result) {
      var message = "";
      if (result['data'] != null) {
        token = result['response']['token'];
      } else {
        message = result['errorMessage'];
        SmartDialog.showToast(message);
      }
    }, arg);
    if (token.isNotEmpty) {
      AppNavigationService.newRoute(RoutesName.dashboard);
    } else {
      SmartDialog.showToast('Login Failed');
    }
  }
}
