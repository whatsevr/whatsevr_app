import 'package:dio/dio.dart';

import 'package:whatsevr_app/config/api/client.dart';
import 'package:whatsevr_app/config/api/response_model/community/top_communities.dart';

import '../external/models/business_validation_exception.dart';

class CommunityApi {
  static Future<TopCommunitiesResponse?> topCommunities({
    required int page,
    int pageSize = 20,
  }) async {
    try {
      Response response = await ApiClient.client.get(
          '/v1/top-communities',
          queryParameters: {'page': page, 'page_size': pageSize});
      if (response.data != null) {
        return TopCommunitiesResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }
}
