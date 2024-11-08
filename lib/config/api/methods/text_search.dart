import 'package:dio/dio.dart';

import '../client.dart';

import '../external/models/business_validation_exception.dart';
import '../response_model/search/searched_users_communities.dart';

class TextSearchApi {
  static Future<SearchedUsersAndCommunitiesResponse?>
      searchUsersAndCommunities({
    required String query,
    int page = 1,
    int pageSize = 5,
  }) async {
    if (query.length < 4) {
      return null;
    }
    try {
      final Response response = await ApiClient.client.get(
        '/v1/search/users_communities',
        queryParameters: {
          'input_text': query,
          'page': page,
          'page_size': pageSize
        },
      );

      if (response.data != null) {
        return SearchedUsersAndCommunitiesResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }
}
