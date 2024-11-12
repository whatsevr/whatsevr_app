import 'package:dio/dio.dart';

import '../client.dart';
import '../external/models/business_validation_exception.dart';
import '../requests_model/community/create_community.dart';
import '../response_model/community/community_details.dart';
import '../response_model/community/top_communities.dart';
import '../response_model/community/user_communities.dart';

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
  }) async {
    try {
      final Response response = await ApiClient.client.get(
        '/v1/user-communities',
        queryParameters: <String, dynamic>{'user_uid': userUid},
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
}
