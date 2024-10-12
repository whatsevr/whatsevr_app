import 'package:dio/dio.dart';

import 'package:whatsevr_app/config/api/client.dart';

import 'package:whatsevr_app/config/api/response_model/recommendation_videos.dart';

import '../external/models/business_validation_exception.dart';
import '../response_model/recommendation_flicks.dart';
import '../response_model/recommendation_memories.dart';
import '../response_model/recommendation_offers.dart';
import '../response_model/recommendation_photo_posts.dart';

class RecommendationApi {
  static Future<RecommendationVideosResponse?> publicVideoPosts({
    required int page,
    int pageSize = 5,
  }) async {
    try {
      Response response = await ApiClient.client.get(
          '/v1/public-recommendations/video-posts',
          queryParameters: {'page': page, 'page_size': pageSize});
      if (response.data != null) {
        return RecommendationVideosResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<RecommendationFlicksResponse?> publicFlickPosts({
    required int page,
    int pageSize = 5,
  }) async {
    try {
      Response response = await ApiClient.client.get(
        '/v1/public-recommendations/flick-posts',
        queryParameters: {'page': page, 'page_size': pageSize},
      );
      if (response.data != null) {
        return RecommendationFlicksResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<RecommendationMemoriesResponse?> publicMemories({
    required int page,
    int pageSize = 10,
  }) async {
    try {
      Response response = await ApiClient.client.get(
          '/v1/public-recommendations/memories',
          queryParameters: {'page': page, 'page_size': pageSize});
      if (response.data != null) {
        return RecommendationMemoriesResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<RecommendationOffersResponse?> publicOffers({
    required int page,
    int pageSize = 5,
  }) async {
    try {
      Response response = await ApiClient.client.get(
          '/v1/public-recommendations/offers',
          queryParameters: {'page': page, 'page_size': pageSize});
      if (response.data != null) {
        return RecommendationOffersResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<RecommendationPhotoPostsResponse?> publicPhotoPosts({
    required int page,
    int pageSize = 5,
  }) async {
    try {
      Response response = await ApiClient.client.get(
          '/v1/public-recommendations/photo-posts',
          queryParameters: {'page': page, 'page_size': pageSize});
      if (response.data != null) {
        return RecommendationPhotoPostsResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }
}
