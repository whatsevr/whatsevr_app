import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whatsevr_app/config/api/interceptors/header.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';
import 'package:whatsevr_app/config/services/device_info.dart';

import 'package:whatsevr_app/dev/talker.dart';
import 'package:whatsevr_app/config/api/interceptors/cache.dart';
import 'package:whatsevr_app/config/api/interceptors/retry.dart';

class ApiClient {
  /// Restricting any instantiation of this class
  ApiClient._();

  // static const String BASE_URL = "https://www.whatsevr.com"; cannot use this for now for follow redirect 300+ code use
  static const String whatsevrApiBaseUrl =
      'https://whatsevr-server-dev.onrender.com/';
  static late Dio client;
  static Directory? dioCacheDirectory;
  static Future<void> init() async {
    client = Dio(
      BaseOptions(
        baseUrl: whatsevrApiBaseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        validateStatus: (int? status) {
          /// this client will only accept status code 200 and 204 as success
          return status == HttpStatus.ok ||
              status == HttpStatus.badRequest ||
              status == HttpStatus.forbidden ||
              status == HttpStatus.partialContent ||
              status == HttpStatus.notAcceptable;
        },
        headers: <String, dynamic>{
          'x-user-agent-id': DeviceInfoService.currentDeviceInfo?.deviceId,
          'x-user-agent-name': DeviceInfoService.currentDeviceInfo?.deviceName,
          'x-user-agent-type': DeviceInfoService.currentDeviceInfo?.deviceOs,
          'x-app-version-code': 1,
        },
      ),
    );
    dioCacheDirectory = await getTemporaryDirectory();

    client.interceptors.addAll(<Interceptor>[
      ApiHeaderInterceptor(),
      ApiRetryInterceptor(dio: client),
      ApiCacheInterceptor(
        cacheDirectoryPath: dioCacheDirectory?.path,
        maxMinuteOnDevice: 60 * 24 * 2,
        cachePostRequest: false,
      ),
      TalkerService.dioLogger,
    ]);
  }

  static Dio generalPurposeClient([
    int? cacheMaxAgeInMin,
    bool? cachePostRequest,
  ]) {
    final Dio dio = Dio(
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
