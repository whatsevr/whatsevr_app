import 'package:dio/dio.dart';

import 'client.dart';
import 'models/recommendation_videos.dart';

class RecommendationApi {
  static Future<RecommendationVideos?> videos({
    int? page = 1,
  }) async {
    try {
      Response response =
          await ApiClient.client.get('/v1/recommendations/videos');
      return RecommendationVideos.fromMap(response.data);
    } catch (e) {
      if (e is DioException) {
        throw 'Dio Exception: ${e.error}';
      }
      rethrow;
    }
  }
}
