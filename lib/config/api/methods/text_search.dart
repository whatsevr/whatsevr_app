import 'package:dio/dio.dart';

import 'package:whatsevr_app/config/api/client.dart';
import 'package:whatsevr_app/config/api/response_model/common_data.dart';

import '../response_model/text_search_users_communities.dart';

class TextSearchApi {
  static Future<TextSearchUsersAndCommunitiesResponse?>
      searchUsersAndCommunities({required String query}) async {
    if (query.length < 4) {
      return null;
    }
    try {
      Response response = await ApiClient.client.post(
        '/v1/search/users_communities',
        data: {'input_text': query},
      );

      if (response.data != null) {
        return TextSearchUsersAndCommunitiesResponse.fromMap(response.data);
      }
    } catch (e) {
      ApiClient.apiMethodException(e);
    }
    return null;
  }
}
