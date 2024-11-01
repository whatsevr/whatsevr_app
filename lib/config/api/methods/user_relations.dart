import 'package:dio/dio.dart';
import 'package:whatsevr_app/config/api/response_model/user_relations/user_relations.dart';

import '../client.dart';
import '../external/models/business_validation_exception.dart';

class UserRelationsApi {
  static Future<(int? statusCode, String? message)?> followUser({
    required String followerUserUid,
    required String followeeUserUid,
  }) async {
    try {
      final Response response = await ApiClient.client.post(
        '/v1/follow-user',
        data: {
          'follower_user_uid': followerUserUid,
          'followee_user_uid': followeeUserUid,
        },
      );
      if (response.data != null) {
        return (
          response.statusCode,
          response.data['message'] as String?,
        );
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
      return null;
    }
    return null;
  }

  static Future<(int? statusCode, String? message)?> unfollowUser({
    required String followerUserUid,
    required String followeeUserUid,
  }) async {
    try {
      final Response response = await ApiClient.client.post(
        '/v1/unfollow-user',
        data: {
          'follower_user_uid': followerUserUid,
          'followee_user_uid': followeeUserUid,
        },
      );
      if (response.data != null) {
        return (
          response.statusCode,
          response.data['message'] as String?,
        );
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
      return null;
    }
    return null;
  }

  static Future<(int? statusCode, String? message)?> removeFollower({
    required String followerUserUid,
    required String followeeUserUid,
  }) async {
    try {
      final Response response = await ApiClient.client.post(
        '/v1/remove-follower',
        data: {
          'follower_user_uid': followerUserUid,
          'followee_user_uid': followeeUserUid,
        },
      );
      if (response.data != null) {
        return (
          response.statusCode,
          response.data['message'] as String?,
        );
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
      return null;
    }
    return null;
  }

  static Future<UsersRelationResponse?> getAllFollowing({
    required String userUid,
    required int page,
    int pageSize = 20,
  }) async {
    try {
      final Response response = await ApiClient.client.get(
        '/v1/get-all-following',
        queryParameters: {
          'user_uid': userUid,
          'page': page,
          'page_size': pageSize,
        },
      );
      return UsersRelationResponse.fromMap(response.data);
    } catch (e, s) {
      lowLevelCatch(e, s);
      return null;
    }
  }

  static Future<UsersRelationResponse?> getAllFollowers({
    required String userUid,
    required int page,
    int pageSize = 20,
  }) async {
    try {
      final Response response = await ApiClient.client.get(
        '/v1/get-all-followers',
        queryParameters: {
          'user_uid': userUid,
          'page': page,
          'page_size': pageSize,
        },
      );
      return UsersRelationResponse.fromMap(response.data);
    } catch (e, s) {
      lowLevelCatch(e, s);
      return null;
    }
  }

  static Future<UsersRelationResponse?> getMutualFollowing({
    required String userUid1,
    required String userUid2,
    required int page,
    int pageSize = 20,
  }) async {
    try {
      final Response response = await ApiClient.client.get(
        '/v1/get-mutual-followings',
        queryParameters: {
          'user_uid_1': userUid1,
          'user_uid_2': userUid2,
          'page': page,
          'page_size': pageSize,
        },
      );
      return UsersRelationResponse.fromMap(response.data);
    } catch (e, s) {
      lowLevelCatch(e, s);
      return null;
    }
  }

  static Future<UsersRelationResponse?> getMutualConnections({
    required String userUid,
    required int page,
    int pageSize = 20,
  }) async {
    try {
      final Response response = await ApiClient.client.get(
        '/v1/get-mutual-connections',
        queryParameters: {
          'user_uid': userUid,
          'page': page,
          'page_size': pageSize,
        },
      );
      return UsersRelationResponse.fromMap(response.data);
    } catch (e, s) {
      lowLevelCatch(e, s);
      return null;
    }
  }
}
