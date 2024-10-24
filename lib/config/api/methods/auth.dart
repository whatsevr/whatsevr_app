import 'dart:io';

import 'package:dio/dio.dart';

import 'package:whatsevr_app/config/api/client.dart';
import 'package:whatsevr_app/config/api/requests_model/auth/register.dart';

import 'package:whatsevr_app/config/api/response_model/auth/login.dart';

import '../external/models/business_validation_exception.dart';

class AuthApi {
  static Future<
      (
        int? statusCode,
        String? message,
        LoginSuccessResponse? loginSuccessResponse
      )?> login(
    String userUid,
    String? mobileNumber,
    String? emailId,
  ) async {
    try {
      Response response = await ApiClient.client.post(
        '/v1/auth/login',
        data: {
          'user_uid': userUid,
          'mobile_number': mobileNumber,
          'email_id': emailId,
        },
      );

      return (
        response.statusCode,
        response.data['message'] as String?,
        response.statusCode == HttpStatus.ok
            ? LoginSuccessResponse.fromMap(response.data)
            : null,
      );
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  //register
  static Future<(String? message, int? statusCode)?> register(
      UserRegistrationRequest registrationRequest) async {
    try {
      Response response = await ApiClient.client.post(
        '/v1/auth/register',
        data: registrationRequest.toMap(),
      );

      return (response.data['message'] as String?, response.statusCode);
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }
}
