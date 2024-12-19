import 'package:dio/dio.dart';
import 'package:whatsevr_app/config/api/client.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import 'package:whatsevr_app/config/api/response_model/security/get_user_logins.dart';

class SecurityApi {
  static Future<dynamic> getDeviceLogins({
    required String? userUid,
  }) async {
    try {
      final Response response = await ApiClient.client.get(
        '/v1/get-user-login-sessions',
        queryParameters: {
          'user_uid': userUid,
        },
      );
      if (response.data != null) {
        return GetUserLoginSessionsResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }
}
