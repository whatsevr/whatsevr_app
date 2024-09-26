import 'package:dio/dio.dart';

import 'package:whatsevr_app/config/api/client.dart';
import 'package:whatsevr_app/config/api/requests_model/create_video_post.dart';

import '../external/models/business_validation_exception.dart';
import '../requests_model/create_flick_post.dart';
import '../requests_model/sanity_check_new_flick_post.dart';
import '../requests_model/sanity_check_new_video_post.dart';

class PostApi {
  static Future<(String? message, int? statusCode)?> sanityCheckNewVideoPost({
    required SanityCheckNewVideoPostRequest request,
  }) async {
    try {
      Response response = await ApiClient.client.post(
        '/v1/sanity-check-new-video-post',
        data: request.toMap(),
      );

      return (response.data['message'] as String?, response.statusCode);
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<(String? message, int? statusCode)?> createVideoPost({
    required CreateVideoPostRequest post,
  }) async {
    try {
      Response response = await ApiClient.client.post(
        '/v1/create-video-post',
        data: post.toMap(),
      );

      return (response.data['message'] as String?, response.statusCode);
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<(String? message, int? statusCode)?> sanityCheckNewFlickPost({
    required SanityCheckNewFlickPostRequest request,
  }) async {
    try {
      Response response = await ApiClient.client.post(
        '/v1/sanity-check-new-flick-post',
        data: request.toMap(),
      );

      return (response.data['message'] as String?, response.statusCode);
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<(String? message, int? statusCode)?> createFlickPost({
    required CreateFlickPostRequest post,
  }) async {
    try {
      Response response = await ApiClient.client.post(
        '/v1/create-flick-post',
        data: post.toMap(),
      );

      return (response.data['message'] as String?, response.statusCode);
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<(String? message, int? statusCode)?> sanityCheckNewMemory({
    required SanityCheckNewFlickPostRequest request,
  }) async {
    try {
      Response response = await ApiClient.client.post(
        '/v1/sanity-check-new-memory',
        data: request.toMap(),
      );

      return (response.data['message'] as String?, response.statusCode);
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<(String? message, int? statusCode)?> createMemory({
    required CreateFlickPostRequest post,
  }) async {
    try {
      Response response = await ApiClient.client.post(
        '/v1/create-memory',
        data: post.toMap(),
      );

      return (response.data['message'] as String?, response.statusCode);
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }
}
