import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:whatsevr_app/config/api/requests_model/upadate_user_work_experiences.dart';
import 'package:whatsevr_app/config/api/requests_model/update_user_educations.dart';
import 'package:whatsevr_app/config/api/requests_model/update_user_services.dart';

import '../client.dart';
import '../requests_model/update_profile_picture.dart';
import '../requests_model/update_user_info.dart';
import '../response_model/multiple_user_details.dart';
import '../response_model/profile_details.dart';

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
      Response response = await ApiClient.client.get('/v1/user-profile-details',
          queryParameters: {'user_uid': userUid});
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

  static Future<String?> updateProfilePicture(
      ProfilePictureUpdateRequest request) async {
    try {
      Response response = await ApiClient.client.post(
        '/v1/user-profile-picture',
        data: request.toMap(),
      );

      return response.data['message'];
    } catch (e) {
      ApiClient.apiMethodException(e);
    }
    return null;
  }

  static Future<String?> updateUserInfo(UpdateUserInfoRequest request) async {
    try {
      Response response = await ApiClient.client.post(
        '/v1/user-info',
        data: request.toMap(),
      );
      return response.data['message'];
    } catch (e) {
      ApiClient.apiMethodException(e);
    }
    return null;
  }

  static Future<String?> updateEducations(
      UpdateUserEducationsRequest request) async {
    try {
      Response response = await ApiClient.client.post(
        '/v1/user-educations',
        data: request.toMap(),
      );
      return response.data['message'];
    } catch (e) {
      ApiClient.apiMethodException(e);
    }
    return null;
  }

  static Future<String?> updateWorkExperiences(
      UpdateUserWorkExperiencesRequest request) async {
    try {
      Response response = await ApiClient.client.post(
        '/v1/user-work-experiences',
        data: request.toMap(),
      );
      return response.data['message'];
    } catch (e) {
      ApiClient.apiMethodException(e);
    }
    return null;
  }

  static Future<String?> updateServices(
      UpdateUserServicesRequest request) async {
    try {
      Response response = await ApiClient.client.post(
        '/v1/user-services',
        data: request.toMap(),
      );
      return response.data['message'];
    } catch (e) {
      ApiClient.apiMethodException(e);
    }
    return null;
  }
}
