import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:whatsevr_app/config/api/client.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import 'package:whatsevr_app/config/api/requests_model/update_user_cover_media.dart';
import 'package:whatsevr_app/config/api/requests_model/update_user_profile_picture.dart';
import 'package:whatsevr_app/config/api/requests_model/user/update_user_educations.dart';
import 'package:whatsevr_app/config/api/requests_model/user/update_user_info.dart';
import 'package:whatsevr_app/config/api/requests_model/user/update_user_portfolio_info.dart';
import 'package:whatsevr_app/config/api/requests_model/user/update_user_services.dart';
import 'package:whatsevr_app/config/api/requests_model/user/update_user_work_experiences.dart';
import 'package:whatsevr_app/config/api/response_model/multiple_user_details.dart';
import 'package:whatsevr_app/config/api/response_model/profile_details.dart';
import 'package:whatsevr_app/config/api/response_model/user/user_supportive_data.dart';
import 'package:whatsevr_app/config/api/response_model/user_details.dart';

class UsersApi {
  static Future<UserDetailsResponse?> getUserDetails({
    required String userUid,
  }) async {
    try {
      final Response response = await ApiClient.client.get(
        '/v1/user-details',
        queryParameters: <String, dynamic>{'user_uid': userUid},
      );
      if (response.data != null) {
        return UserDetailsResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<(int? statusCode, UserSupportiveDataResponse data)?>
      getSupportiveUserData({
    required String userUid,
  }) async {
    try {
      final Response response = await ApiClient.client.get(
        '/v1/get-user-supportive-data',
        queryParameters: <String, dynamic>{'user_uid': userUid},
      );
      if (response.data != null) {
        return (
          response.statusCode,
          UserSupportiveDataResponse.fromMap(response.data)
        );
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<UserProfileDetailsResponse?> getProfileDetails({
    required String userUid,
  }) async {
    try {
      final Response response = await ApiClient.client.get(
        '/v1/user-profile-details',
        queryParameters: <String, dynamic>{'user_uid': userUid},
      );
      if (response.data != null) {
        return UserProfileDetailsResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<MultipleUserDetailsResponse?> getMultipleUserDetails({
    required List<String> userUids,
  }) async {
    try {
      final Response response = await ApiClient.client.get(
        '/v1/multiple-user-details',
        queryParameters: <String, dynamic>{'user_uids': jsonEncode(userUids)},
      );
      if (response.data != null) {
        return MultipleUserDetailsResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<String?> updateProfilePicture(
    ProfilePictureUpdateRequest request,
  ) async {
    try {
      final Response response = await ApiClient.client.post(
        '/v1/user-profile-picture',
        data: request.toMap(),
      );

      return response.data['message'];
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<(int? statusCode, String? message)?> updateUserInfo(
    UpdateUserInfoRequest request,
  ) async {
    try {
      final Response response = await ApiClient.client.post(
        '/v1/user-info',
        data: request.toMap(),
      );
      return (response.statusCode, response.data['message'] as String);
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<(int? statusCode, String? message)?> updateUserPortfolioInfo(
    UpdateUserPortfolioInfoRequest request,
  ) async {
    try {
      final Response response = await ApiClient.client.post(
        '/v1/update-user-portfolio-info',
        data: request.toMap(),
      );
      return (response.statusCode, response.data['message'] as String);
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<(int? statusCode, String? message)?> updateEducations(
    UpdateUserEducationsRequest request,
  ) async {
    try {
      final Response response = await ApiClient.client.post(
        '/v1/user-educations',
        data: request.toMap(),
      );
      return (response.statusCode, response.data['message'] as String);
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<(int? statusCode, String? message)?> updateWorkExperiences(
    UpdateUserWorkExperiencesRequest request,
  ) async {
    try {
      final Response response = await ApiClient.client.post(
        '/v1/user-work-experiences',
        data: request.toMap(),
      );
      return (response.statusCode, response.data['message'] as String);
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<(int? statusCode, String? message)?> updateServices(
    UpdateUserServicesRequest request,
  ) async {
    try {
      final Response response = await ApiClient.client.post(
        '/v1/user-services',
        data: request.toMap(),
      );
      return (response.statusCode, response.data['message'] as String);
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<String?> updateCoverMedia(
    UpdateUserCoverMediaRequest request,
  ) async {
    try {
      final Response response = await ApiClient.client.post(
        '/v1/user-cover-media',
        data: request.toMap(),
      );
      return response.data['message'];
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }
}
