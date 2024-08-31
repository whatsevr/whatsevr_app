import 'package:dio/dio.dart';

class ApiClient {
  static const String BASE_URL = "https://www.whatsevr.com";
  static late Dio client;
  static void init() {
    client = Dio(BaseOptions(
      baseUrl: BASE_URL,
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
    ));
  }
}
