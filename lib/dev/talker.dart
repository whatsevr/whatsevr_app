import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerService {
  TalkerService._();
  static Talker instance = Talker(
    settings: TalkerSettings(
      enabled: true,
      useConsoleLogs: true,
    ),
  );
  static TalkerBlocObserver blocObserver = TalkerBlocObserver(talker: instance);

  static TalkerDioLogger dioLogger = TalkerDioLogger(
      talker: instance,
      settings: TalkerDioLoggerSettings(
        printRequestHeaders: true,
      ));

  static TalkerRouteObserver takerRouteObserver() {
    return TalkerRouteObserver(instance);
  }

  static void init() {
    if (kReleaseMode) {
      Bloc.observer = TalkerService.blocObserver;
    }
  }
}
