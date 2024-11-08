import 'package:dio/dio.dart';
import 'package:whatsevr_app/config/api/response_model/search/searched_communities.dart';
import 'package:whatsevr_app/config/api/response_model/search/searched_flick_posts.dart';
import 'package:whatsevr_app/config/api/response_model/search/searched_memories.dart';
import 'package:whatsevr_app/config/api/response_model/search/searched_offers.dart';
import 'package:whatsevr_app/config/api/response_model/search/searched_pdfs.dart';
import 'package:whatsevr_app/config/api/response_model/search/searched_photo_posts.dart';
import 'package:whatsevr_app/config/api/response_model/search/searched_portfolios.dart';
import 'package:whatsevr_app/config/api/response_model/search/searched_users.dart';
import 'package:whatsevr_app/config/api/response_model/search/searched_video_posts.dart';

import '../client.dart';

import '../external/models/business_validation_exception.dart';
import '../response_model/search/searched_users_communities.dart';

class TextSearchApi {
  static Future<SearchedUsersAndCommunitiesResponse?>
      searchUsersAndCommunities({
    required String query,
    int page = 1,
    int pageSize = 20,
  }) async {
    if (query.length < 4) {
      return null;
    }
    try {
      final Response response = await ApiClient.client.get(
        '/v1/search-users-communities',
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

  static Future<SearchedUsersResponse?> searchUsers({
    required String query,
    int page = 1,
    int pageSize = 20,
  }) async {
    if (query.length < 4) {
      return null;
    }
    try {
      final Response response = await ApiClient.client.get(
        '/v1/search-users',
        queryParameters: {
          'input_text': query,
          'page': page,
          'page_size': pageSize
        },
      );

      if (response.data != null) {
        return SearchedUsersResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<SearchedPortfoliosResponse?> searchPortfolios({
    required String query,
    int page = 1,
    int pageSize = 20,
  }) async {
    if (query.length < 4) {
      return null;
    }
    try {
      final Response response = await ApiClient.client.get(
        '/v1/search-portfolios',
        queryParameters: {
          'input_text': query,
          'page': page,
          'page_size': pageSize
        },
      );

      if (response.data != null) {
        return SearchedPortfoliosResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<SearchedCommunitiesResponse?> searchCommunities({
    required String query,
    int page = 1,
    int pageSize = 20,
  }) async {
    if (query.length < 4) {
      return null;
    }
    try {
      final Response response = await ApiClient.client.get(
        '/v1/search-communities',
        queryParameters: {
          'input_text': query,
          'page': page,
          'page_size': pageSize
        },
      );

      if (response.data != null) {
        return SearchedCommunitiesResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<SearchedOffersResponse?> searchOffers({
    required String query,
    int page = 1,
    int pageSize = 20,
  }) async {
    if (query.length < 4) {
      return null;
    }
    try {
      final Response response = await ApiClient.client.get(
        '/v1/search-offers',
        queryParameters: {
          'input_text': query,
          'page': page,
          'page_size': pageSize
        },
      );

      if (response.data != null) {
        return SearchedOffersResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<SearchedVideoPostsResponse?> searchVideoPosts({
    required String query,
    int page = 1,
    int pageSize = 20,
  }) async {
    if (query.length < 4) {
      return null;
    }
    try {
      final Response response = await ApiClient.client.get(
        '/v1/search-video-posts',
        queryParameters: {
          'input_text': query,
          'page': page,
          'page_size': pageSize
        },
      );

      if (response.data != null) {
        return SearchedVideoPostsResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<SearchedFlickPostsResponse?> searchFlickPosts({
    required String query,
    int page = 1,
    int pageSize = 20,
  }) async {
    if (query.length < 4) {
      return null;
    }
    try {
      final Response response = await ApiClient.client.get(
        '/v1/search-flick-posts',
        queryParameters: {
          'input_text': query,
          'page': page,
          'page_size': pageSize
        },
      );

      if (response.data != null) {
        return SearchedFlickPostsResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<SearchedPhotoPostsResponse?> searchPhotoPosts({
    required String query,
    int page = 1,
    int pageSize = 20,
  }) async {
    if (query.length < 4) {
      return null;
    }
    try {
      final Response response = await ApiClient.client.get(
        '/v1/search-photo-posts',
        queryParameters: {
          'input_text': query,
          'page': page,
          'page_size': pageSize
        },
      );

      if (response.data != null) {
        return SearchedPhotoPostsResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<SearchedMemoriesResponse?> searchMemories({
    required String query,
    int page = 1,
    int pageSize = 20,
  }) async {
    if (query.length < 4) {
      return null;
    }
    try {
      final Response response = await ApiClient.client.get(
        '/v1/search-memories',
        queryParameters: {
          'input_text': query,
          'page': page,
          'page_size': pageSize
        },
      );

      if (response.data != null) {
        return SearchedMemoriesResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<SearchedPdfsResponse?> searchPdfs({
    required String query,
    int page = 1,
    int pageSize = 20,
  }) async {
    if (query.length < 4) {
      return null;
    }
    try {
      final Response response = await ApiClient.client.get(
        '/v1/search-pdfs',
        queryParameters: {
          'input_text': query,
          'page': page,
          'page_size': pageSize
        },
      );

      if (response.data != null) {
        return SearchedPdfsResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }
}
