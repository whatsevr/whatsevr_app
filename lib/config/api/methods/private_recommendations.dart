import 'package:dio/dio.dart';

import 'package:whatsevr_app/config/api/client.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import 'package:whatsevr_app/config/api/response_model/private_recommendation/flicks.dart';
import 'package:whatsevr_app/config/api/response_model/private_recommendation/memories.dart';
import 'package:whatsevr_app/config/api/response_model/private_recommendation/mix_community_content.dart';
import 'package:whatsevr_app/config/api/response_model/private_recommendation/mix_content.dart';
import 'package:whatsevr_app/config/api/response_model/private_recommendation/offers.dart';
import 'package:whatsevr_app/config/api/response_model/private_recommendation/photo_posts.dart';
import 'package:whatsevr_app/config/api/response_model/private_recommendation/videos.dart';

class PrivateRecommendationApi {
  static Future<PrivateRecommendationVideosResponse?> getVideoPosts({
    required int page,
    required String userUid,
    int pageSize = 10,
  }) async {
    try {
      final Response response = await ApiClient.client.get(
        '/v1/private-recommendations/video-posts',
        queryParameters: {
          'page': page,
          'page_size': pageSize,
          'user_uid': userUid,
        },
      );
      if (response.data != null) {
        return PrivateRecommendationVideosResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<PrivateRecommendationFlicksResponse?> getFlickPosts({
    required int page,
    required String userUid,
    int pageSize = 10,
  }) async {
    try {
      final Response response = await ApiClient.client.get(
        '/v1/private-recommendations/flick-posts',
        queryParameters: {
          'page': page,
          'page_size': pageSize,
          'user_uid': userUid,
        },
      );
      if (response.data != null) {
        return PrivateRecommendationFlicksResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<PrivateRecommendationMemoriesResponse?> getMemories({
    required int page,
    required String userUid,
    int pageSize = 60,
  }) async {
    try {
      final Response response = await ApiClient.client.get(
        '/v1/private-recommendations/memories',
        queryParameters: {
          'page': page,
          'page_size': pageSize,
          'user_uid': userUid,
        },
      );
      if (response.data != null) {
        return PrivateRecommendationMemoriesResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<PrivateRecommendationOffersResponse?> getOffers({
    required int page,
    required String userUid,
    int pageSize = 10,
  }) async {
    try {
      final Response response = await ApiClient.client.get(
        '/v1/private-recommendations/offers',
        queryParameters: {
          'page': page,
          'page_size': pageSize,
          'user_uid': userUid,
        },
      );
      if (response.data != null) {
        return PrivateRecommendationOffersResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<PrivateRecommendationPhotoPostsResponse?> getPhotoPosts({
    required int page,
    required String userUid,
    int pageSize = 10,
  }) async {
    try {
      final Response response = await ApiClient.client.get(
        '/v1/private-recommendations/photo-posts',
        queryParameters: {
          'page': page,
          'page_size': pageSize,
          'user_uid': userUid,
        },
      );
      if (response.data != null) {
        return PrivateRecommendationPhotoPostsResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<PrivateRecommendationMixContentResponse?> getMixContent({
    required int page,
    required String userUid,
    int pageSize = 20,
  }) async {
    try {
      final Response response = await ApiClient.client.get(
        '/v1/private-recommendations/get-mix-content',
        queryParameters: {
          'page': page,
          'page_size': pageSize,
          'user_uid': userUid,
        },
      );
      if (response.data != null) {
        return PrivateRecommendationMixContentResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<PrivateRecommendationMixCommunityContentResponse?>
      getMixCommunityContent({
    required int page,
    required String userUid,
    int pageSize = 20,
  }) async {
    try {
      final Response response = await ApiClient.client.get(
        '/v1/private-recommendations/get-mix-community-content',
        queryParameters: {
          'page': page,
          'page_size': pageSize,
          'user_uid': userUid,
        },
      );
      if (response.data != null) {
        return PrivateRecommendationMixCommunityContentResponse.fromMap(
            response.data,);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }
}
