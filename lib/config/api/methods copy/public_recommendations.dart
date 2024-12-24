import 'package:dio/dio.dart';

import 'package:whatsevr_app/config/api/client.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import 'package:whatsevr_app/config/api/response_model/public_recommendation/mix_content.dart';
import 'package:whatsevr_app/config/api/response_model/public_recommendation/flicks.dart';
import 'package:whatsevr_app/config/api/response_model/public_recommendation/memories.dart';
import 'package:whatsevr_app/config/api/response_model/public_recommendation/offers.dart';
import 'package:whatsevr_app/config/api/response_model/public_recommendation/photo_posts.dart';
import 'package:whatsevr_app/config/api/response_model/public_recommendation/videos.dart';

class PublicRecommendationApi {
  static Future<PublicRecommendationVideosResponse?> publicVideoPosts({
    required int page,
    int pageSize = 10,
  }) async {
    try {
      final Response response = await ApiClient.client.get(
        '/v1/public-recommendations/video-posts',
        queryParameters: {'page': page, 'page_size': pageSize},
      );
      if (response.data != null) {
        return PublicRecommendationVideosResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<PublicRecommendationFlicksResponse?> publicFlickPosts({
    required int page,
    int pageSize = 10,
  }) async {
    try {
      final Response response = await ApiClient.client.get(
        '/v1/public-recommendations/flick-posts',
        queryParameters: {'page': page, 'page_size': pageSize},
      );
      if (response.data != null) {
        return PublicRecommendationFlicksResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<PublicRecommendationMemoriesResponse?> publicMemories({
    required int page,
    int pageSize = 60,
  }) async {
    try {
      final Response response = await ApiClient.client.get(
        '/v1/public-recommendations/memories',
        queryParameters: {'page': page, 'page_size': pageSize},
      );
      if (response.data != null) {
        return PublicRecommendationMemoriesResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<PublicRecommendationOffersResponse?> publicOffers({
    required int page,
    int pageSize = 10,
  }) async {
    try {
      final Response response = await ApiClient.client.get(
        '/v1/public-recommendations/offers',
        queryParameters: {'page': page, 'page_size': pageSize},
      );
      if (response.data != null) {
        return PublicRecommendationOffersResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<PublicRecommendationPhotoPostsResponse?> publicPhotoPosts({
    required int page,
    int pageSize = 10,
  }) async {
    try {
      final Response response = await ApiClient.client.get(
        '/v1/public-recommendations/photo-posts',
        queryParameters: {'page': page, 'page_size': pageSize},
      );
      if (response.data != null) {
        return PublicRecommendationPhotoPostsResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

    static Future<PublicRecommendationMixContentResponse?> getMixContent({
    required int page,
    int pageSize = 20,
  }) async {
    try {
      final Response response = await ApiClient.client.get(
        '/v1/public-recommendations/get-mix-content',
        queryParameters: {'page': page, 'page_size': pageSize},
      );
      if (response.data != null) {
        return PublicRecommendationMixContentResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }
}
