import 'package:dio/dio.dart';

import 'package:whatsevr_app/config/api/client.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import 'package:whatsevr_app/config/api/requests_model/community/create_community.dart';
import 'package:whatsevr_app/config/api/response_model/community/community_details.dart';
import 'package:whatsevr_app/config/api/response_model/community/community_members.dart';
import 'package:whatsevr_app/config/api/response_model/community/top_communities.dart';
import 'package:whatsevr_app/config/api/response_model/community/user_communities.dart';

class CommunityApi {
  static Future<TopCommunitiesResponse?> topCommunities({
    required int page,
    int pageSize = 30,
  }) async {
    try {
      final Response response = await ApiClient.client.get(
        '/v1/top-communities',
        queryParameters: {'page': page, 'page_size': pageSize},
      );
      if (response.data != null) {
        return TopCommunitiesResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<(String? message, int? statusCode)?> createCommunity({
    required CreateCommunityRequest post,
  }) async {
    try {
      final Response response = await ApiClient.client.post(
        '/v1/create-community',
        data: post.toMap(),
      );

      return (response.data['message'] as String?, response.statusCode);
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<UserCommunitiesResponse?> getUserCommunities({
    required String userUid,
     int? page=1,
    int? pageSize = 30,
  }) async {
    try {
      final Response response = await ApiClient.client.get(
        '/v1/user-communities',
        queryParameters: <String, dynamic>{
          'user_uid': userUid,
          'page': page,
          'page_size': pageSize,
        },
      );
      if (response.data != null) {
        return UserCommunitiesResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<CommunityProfileDataResponse?> getCommunityDetails({
    required String communityUid,
  }) async {
    try {
      final Response response = await ApiClient.client.get(
        '/v1/get-community-profile-data',
        queryParameters: <String, dynamic>{'community_uid': communityUid},
      );
      if (response.data != null) {
        return CommunityProfileDataResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<(String? message, int? statusCode)?> joinCommunity({
    required String joineeUserUid,
    required String communityUid,
  }) async {
    try {
      final Response response = await ApiClient.client.post(
        '/v1/join-community',
        data: {
          'joinee_user_uid': joineeUserUid,
          'community_uid': communityUid,
        },
      );

      return (response.data['message'] as String?, response.statusCode);
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<(String? message, int? statusCode)?> leaveCommunity({
    required String memberUserUid,
    required String communityUid,
  }) async {
    try {
      final Response response = await ApiClient.client.post(
        '/v1/leave-community',
        data: {
          'member_user_uid': memberUserUid,
          'community_uid': communityUid,
        },
      );

      return (response.data['message'] as String?, response.statusCode);
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  //get members
  static Future<CommunityMembersResponse?> getCommunityMembers({
    required String communityUid,
    int? page = 1,
    int? pageSize = 30,
  }) async {
    try {
      final Response response = await ApiClient.client.get(
        '/v1/get-community-members',
        queryParameters: <String, dynamic>{
          'community_uid': communityUid,
          'page': page,
          'page_size': pageSize,
        },
      );
      if (response.data != null) {
        return CommunityMembersResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }
}
