import 'package:dio/dio.dart';
import 'package:whatsevr_app/config/api/client.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import 'package:whatsevr_app/config/api/response_model/tag_registry/user_tagged_content.dart';
import 'package:whatsevr_app/config/api/response_model/tag_registry/community_tagged_content.dart';

class TagRegistryApi {
  static Future<UserTaggedContentResponse?> getUserTaggedContent({
    required String userUid,
    required int page,
    int pageSize = 20,
  }) async {
    try {
      final Response response = await ApiClient.client.get(
        '/v1/get-user-tagged-content',
        queryParameters: {
          'user_uid': userUid,
          'page': page,
          'page_size': pageSize,
        },
      );
      if (response.data != null) {
        return UserTaggedContentResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<CommunityTaggedContentResponse?> getCommunityTaggedContent({
    required String communityUid,
    required int page,
    int pageSize = 20,
  }) async {
    try {
      final Response response = await ApiClient.client.get(
        '/v1/get-community-tagged-content',
        queryParameters: {
          'community_uid': communityUid,
          'page': page,
          'page_size': pageSize,
        },
      );
      if (response.data != null) {
        return CommunityTaggedContentResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }
}
