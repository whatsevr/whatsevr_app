import 'package:dio/dio.dart';

import 'package:whatsevr_app/config/api/client.dart';

import 'package:whatsevr_app/config/api/response_model/recommendation_videos.dart';

import '../external/models/business_validation_exception.dart';
import '../response_model/recommendation_flicks.dart';

class RecommendationApi {
  static Future<RecommendationVideosResponse?> publicVideoPosts({
    int? page = 1,
  }) async {
    try {
      Response response =
          await ApiClient.client.get('/v1/recommendations/video-posts');
      if (response.data != null) {
        return RecommendationVideosResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<RecommendationFlicksResponse?> publicFlickPosts({
    int? page = 1,
  }) async {
    try {
      Response response =
          await ApiClient.client.get('/v1/recommendations/flick-posts');
      if (response.data != null) {
        return RecommendationFlicksResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }
}
