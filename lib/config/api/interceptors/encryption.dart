import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:encrypt/encrypt.dart';

import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';

class ApiEncryptionInterceptor extends Interceptor {
  final String encryptionKey;

  ApiEncryptionInterceptor(this.encryptionKey);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    try {
      if (_shouldEncrypt(options.path)) {
        if (options.data != null) {
          final encryptedData = _encryptWithAES(jsonEncode(options.data));
          options.data = {'data': encryptedData};
        } else if (options.queryParameters.isNotEmpty) {
          final encryptedQueryParams =
              _encryptWithAES(jsonEncode(options.queryParameters));
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
        response.data = jsonDecode(_decryptWithAES(response.data));
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

  String _encryptWithAES(String plainText) {
    final cipherKey = Key.fromUtf8(encryptionKey);
    final encryptService = Encrypter(AES(cipherKey, mode: AESMode.cbc));
    final initVector = IV.fromUtf8(encryptionKey.substring(0, 16));
    final Encrypted encryptedText =
        encryptService.encrypt(plainText, iv: initVector);
    final String encryptedBase64String = encryptedText.base64;
    return encryptedBase64String;
  }

  String _decryptWithAES(String encryptedText) {
    try {
      final cipherKey = Key.fromUtf8(encryptionKey);
      final encryptService = Encrypter(AES(cipherKey, mode: AESMode.cbc));
      final initVector = IV.fromUtf8(encryptionKey.substring(0, 16));
      final String decryptedText = encryptService
          .decrypt(Encrypted.fromBase64(encryptedText), iv: initVector);

      return decryptedText;
    } catch (e) {
      rethrow;
    }
  }
}
