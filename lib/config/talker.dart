import 'package:bloc/bloc.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerService {
  static Talker instance = Talker(
    settings: TalkerSettings(
      enabled: true,
      useConsoleLogs: false,
    ),
  );
  static TalkerBlocObserver blocObserver = TalkerBlocObserver(talker: instance);

  static TalkerDioLogger dioLogger = TalkerDioLogger(talker: instance);

  static void init() {
    Bloc.observer = TalkerService.blocObserver;
  }
}
