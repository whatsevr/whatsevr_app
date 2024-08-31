import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/routes/routes_name.dart';
import 'package:otpless_flutter/otpless_flutter.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashState()) {
    on<InitialEvent>(_onInitial);
  }

  FutureOr<void> _onInitial(
    InitialEvent event,
    Emitter<SplashState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 2));
    AppNavigationService.newRoute(RoutesName.dashboard);
    return;
    final Otpless otplessFlutterPlugin = Otpless();
    Map<String, String> arg = <String, String>{
      'appId': 'YAA8EYVROHZ00125AAAV',
    };

    await otplessFlutterPlugin.openLoginPage(
      (result) {
        log('result XXXXX: $result');
        if (result['data']['token'].isNotEmpty) {
          AppNavigationService.newRoute(RoutesName.dashboard);
        } else {
          SmartDialog.showToast('${result['errorMessage']}');
        }
      },
      arg,
    );
  }
}
