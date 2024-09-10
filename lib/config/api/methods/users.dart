import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../client.dart';
import '../requests_model/update_profile_picture.dart';
import '../response_model/multiple_user_details.dart';
import '../response_model/profile_details.dart';
import '../response_model/update_profile_picture_response.dart';
import '../response_model/user_profile.dart';

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

  static Future<MultipleUserDetailsResponse?> getMultipleUserDetails(
      {required List<String> userUids}) async {
    try {
      Response response = await ApiClient.client.get(
          '/v1/multiple-user-details',
          queryParameters: {'user_uids': jsonEncode(userUids)});
      if (response.statusCode == HttpStatus.ok) {
        return MultipleUserDetailsResponse.fromMap(response.data);
      }
    } catch (e) {
      ApiClient.apiMethodException(e);
    }
    return null;
  }

  static Future<ProfilePictureUpdateResponse?> updateUserProfilePicture(
      ProfilePictureUpdateRequest request) async {
    try {
      Response response = await ApiClient.client.post(
        '/v1/user-profile-picture',
        data: request.toMap(),
      );

      return ProfilePictureUpdateResponse.fromMap(response.data);
    } catch (e) {
      ApiClient.apiMethodException(e);
    }
    return null;
  }
}
