import 'package:dio/dio.dart';
import 'package:whatsevr_app/config/api/client.dart';

import '../response_model/recommendation_videos.dart';

class RecommendationApi {
  static Future<RecommendationVideosResponse?> videos({
    int? page = 1,
  }) async {
    try {
      Response response =
          await ApiClient.client.get('/v1/recommendations/videos');
      return RecommendationVideosResponse.fromMap(response.data);
    } catch (e) {
      if (e is DioException) {
        throw 'Dio Exception: ${e.error}';
      }
      rethrow;
    }
  }
}
