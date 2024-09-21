import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whatsevr_app/dev/talker.dart';

import 'package:whatsevr_app/config/api/interceptors/cache.dart';
import 'package:whatsevr_app/config/api/interceptors/retry.dart';

class ApiClient {
  /// Restricting any instantiation of this class
  ApiClient._();

  // static const String BASE_URL = "https://www.whatsevr.com"; cannot use this for now for follow redirect 300+ code use
  static const String BASE_URL = 'https://whatsevr-server-dev.onrender.com/';
  static late Dio client;
  static Directory? dioCacheDirectory;
  static Future<void> init() async {
    client = Dio(
      BaseOptions(
        baseUrl: BASE_URL,
        connectTimeout: Duration(seconds: 30),
        receiveTimeout: Duration(seconds: 30),
        sendTimeout: Duration(seconds: 30),
        validateStatus: (int? status) {
          /// this client will only accept status code 200 and 204 as success
          return status == HttpStatus.ok || status == HttpStatus.noContent;
        },
        headers: <String, dynamic>{
          'secret': 'your_secret_key',
        },
      ),
    );
    dioCacheDirectory = await getTemporaryDirectory();
    client.interceptors.addAll(<Interceptor>[
      ApiRetryInterceptor(dio: client),
      ApiCacheInterceptor(
          cacheDirectoryPath: dioCacheDirectory?.path,
          maxMinuteOnDevice: 60 * 24 * 7),
      TalkerService.dioLogger,
    ]);
  }

  static Dio generalPurposeClient([int? cacheMaxAgeInMin]) {
    Dio dio = Dio(
      BaseOptions(
        connectTimeout: Duration(seconds: 30),
        receiveTimeout: Duration(seconds: 30),
        sendTimeout: Duration(seconds: 30),
      ),
    );
    dio.interceptors.addAll(<Interceptor>[
      ApiRetryInterceptor(dio: dio),
      ApiCacheInterceptor(
        cacheDirectoryPath: dioCacheDirectory?.path,
        maxMinuteOnDevice: cacheMaxAgeInMin,
      ),
      TalkerService.dioLogger,
    ]);
    return dio;
  }

  static void apiMethodException(Object e) {
    if (e is SocketException) {
      TalkerService.instance.error('Unable to connect to the server.');
      throw ('Unable to connect to the server.');
    }
    if (e is DioException) {
      if (e.response?.statusCode == 500) {
        TalkerService.instance.error('Server response: Internal Server Error');
        throw ('Server response: Internal Server Error');
      }
      TalkerService.instance
          .error('Server response: ${e.response?.data['message']}');
      throw ('Server response: ${e.response?.data['message']}');
    }
    TalkerService.instance.error('App Error: ${e.toString()}');
    throw ('App Error: ${e.toString()}');
  }
}
