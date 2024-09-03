import 'package:dio/dio.dart';

import '../client.dart';
import '../response_model/user_status.dart';

class UsersApi {
  static Future<UserStatusResponse?> checkUserStatus(
      {required String userUid}) async {
    try {
      Response response = await ApiClient.client
          .get('/v1/user-status', queryParameters: {'user_uid': userUid});
      return UserStatusResponse.fromMap(response.data);
    } catch (e) {
      ApiClient.apiMethodException(e);
    }
    return null;
  }
}
