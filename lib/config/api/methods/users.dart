import 'dart:io';

import 'package:dio/dio.dart';

import '../client.dart';
import '../response_model/profile_details.dart';
import '../response_model/user_status.dart';

class UsersApi {
  static Future<UserDetailsResponse?> getUserDetails(
      {required String userUid}) async {
    try {
      Response response = await ApiClient.client
          .get('/v1/user-details', queryParameters: {'user_uid': userUid});
      if (response.statusCode == HttpStatus.ok) {
        return UserDetailsResponse.fromMap(response.data);
      }
    } catch (e) {
      ApiClient.apiMethodException(e);
    }
    return null;
  }

  static Future<ProfileDetailsResponse?> getProfileDetails(
      {required String userUid}) async {
    try {
      Response response = await ApiClient.client
          .get('/v1/profile-details', queryParameters: {'user_uid': userUid});
      if (response.statusCode == HttpStatus.ok) {
        return ProfileDetailsResponse.fromMap(response.data);
      }
    } catch (e) {
      ApiClient.apiMethodException(e);
    }
    return null;
  }
}
