import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';

import 'interceptors/cache.dart';
import 'interceptors/retry.dart';

class ApiClient {
  /// Restricting any instantiation of this class
  ApiClient._();

  // static const String BASE_URL = "https://www.whatsevr.com"; cannot use this for now for follow redirect 300+ code use
  static const String BASE_URL = 'https://whatsevr-server-dev.onrender.com/';
  static late Dio client;
  static void init() {
    client = Dio(
      BaseOptions(
        baseUrl: BASE_URL,
        connectTimeout: Duration(seconds: 30),
        receiveTimeout: Duration(seconds: 30),
        sendTimeout: Duration(seconds: 30),
        validateStatus: (int? status) {
          return status == 200;
        },
        headers: <String, dynamic>{
          'secret': 'your_secret_key',
        },
      ),
    );
    client.interceptors.addAll([
      ApiRetryInterceptor(dio: client),
      ApiCacheInterceptor(),
    ]);
  }

  static void apiMethodException(Object e) {
    if (e is DioException) {
      if (e.response?.statusCode == 500) {
        throw ('Internal Server Error');
      }
      throw ('${e.response?.data['message']}');
    }

    throw ('Error creating post: ${e.toString()}');
  }
}
