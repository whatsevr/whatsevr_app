import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:whatsevr_app/utils/aes.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';

class ApiEncryptionInterceptor extends Interceptor {
  final AesService _aesService = AesService(
      'A8AtppMyToX2AglM+YR0OxEc+QNhKYumcbiS11DZcCLq3UnI2ugHilCEYSyFx7SQ',);

  ApiEncryptionInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    try {
      if (_shouldEncrypt(options.path)) {
        if (options.data != null) {
          final encryptedData = _aesService.encrypt(jsonEncode(options.data));
          options.data = {'data': encryptedData};
        } else if (options.queryParameters.isNotEmpty) {
          final encryptedQueryParams =
              _aesService.encrypt(jsonEncode(options.queryParameters));
          options.queryParameters = {'data': encryptedQueryParams};
        }
      }
    } catch (e, stackTrace) {
      lowLevelCatch(e, stackTrace);
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    try {
      if (_shouldEncrypt(response.requestOptions.path)) {
        response.data = jsonDecode(_aesService.decrypt(response.data));
      }
    } catch (e, stackTrace) {
      lowLevelCatch(e, stackTrace);
    }
    super.onResponse(response, handler);
  }

  bool _shouldEncrypt(String path) {
    const encryptedEndpoints = ['/auth/register', '/auth/login'];
    return encryptedEndpoints.contains(path);
  }
}
