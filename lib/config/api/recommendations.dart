import 'package:dio/dio.dart';

import 'client.dart';
import 'response_model/recommendation_videos.dart';

class RecommendationApi {
  static Future<RecommendationVideosResponse?> videoPosts({
    int? page = 1,
  }) async {
    try {
      Response response =
          await ApiClient.client.get('/v1/recommendations/video-posts');
      return RecommendationVideosResponse.fromMap(response.data);
    } catch (e) {
      if (e is DioException) {
        throw 'Server Error, code: ${e.response?.statusCode}';
      }
      rethrow;
    }
  }
}