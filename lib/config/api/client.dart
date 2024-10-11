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
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        validateStatus: (int? status) {
          /// this client will only accept status code 200 and 204 as success
          return status == HttpStatus.ok ||
              status == HttpStatus.noContent ||
              status == HttpStatus.badRequest;
        },
        headers: <String, dynamic>{
          'secret': 'your_secret_key',
          'ETag': '56574',
        },
      ),
    );
    dioCacheDirectory = await getTemporaryDirectory();
    client.interceptors.addAll(<Interceptor>[
      ApiRetryInterceptor(dio: client),
      ApiCacheInterceptor(
          cacheDirectoryPath: dioCacheDirectory?.path,
          maxMinuteOnDevice: 60 * 24 * 7,
          cachePostRequest: false),
      TalkerService.dioLogger,
    ]);
  }

  static Dio generalPurposeClient(
      [int? cacheMaxAgeInMin, bool? cachePostRequest]) {
    Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
      ),
    );
    dio.interceptors.addAll(<Interceptor>[
      ApiRetryInterceptor(dio: dio),
      ApiCacheInterceptor(
        cacheDirectoryPath: dioCacheDirectory?.path,
        maxMinuteOnDevice: cacheMaxAgeInMin,
        cachePostRequest: cachePostRequest,
      ),
      TalkerService.dioLogger,
    ]);
    return dio;
  }
}
