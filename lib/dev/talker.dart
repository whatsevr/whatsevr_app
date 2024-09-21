import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerService {
  TalkerService._();
  static Talker instance = Talker(
    settings: TalkerSettings(
      enabled: true,
      useConsoleLogs: false,
    ),
  );
  static TalkerBlocObserver blocObserver = TalkerBlocObserver(talker: instance);

  static TalkerDioLogger dioLogger = TalkerDioLogger(talker: instance);

  static TalkerRouteObserver takerRouteObserver() {
    return TalkerRouteObserver(instance);
  }

  static void init() {
    Bloc.observer = TalkerService.blocObserver;
  }
}

class WhatsevrTalkerWrapper extends StatelessWidget {
  final Widget child;
  const WhatsevrTalkerWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return TalkerWrapper(
      talker: TalkerService.instance,
      options: const TalkerWrapperOptions(
        enableErrorAlerts: true,
      ),
      child: child,
    );
  }
}
