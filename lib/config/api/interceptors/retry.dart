import 'package:dio_smart_retry/dio_smart_retry.dart';

class ApiRetryInterceptor extends RetryInterceptor {
  ApiRetryInterceptor({
    required super.dio,
    Function? logPrint,
    super.retries,
    super.retryDelays = const <Duration>[
      // set delays between retries (optional)
      Duration(seconds: 1),
      Duration(seconds: 2),
      Duration(seconds: 3),
    ],
  }) : super(
          logPrint: print,
        );
}