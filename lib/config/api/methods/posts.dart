import 'package:dio/dio.dart';

import 'package:whatsevr_app/config/api/client.dart';
import 'package:whatsevr_app/config/api/requests_model/create_video_post.dart';
import 'package:whatsevr_app/config/api/response_model/create_video_post.dart';

import '../external/models/business_validation_exception.dart';
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
      productionSafetyCatch(e, s);
    }
    return null;
  }

  static Future<CreateVideoPostResponse?> createVideoPost({
    required CreateVideoPostRequest post,
  }) async {
    try {
      Response response = await ApiClient.client.post(
        '/v1/create-video-post',
        data: post.toMap(),
      );

      return CreateVideoPostResponse.fromMap(response.data);
    } catch (e, s) {
      productionSafetyCatch(e, s);
    }
    return null;
  }
}
