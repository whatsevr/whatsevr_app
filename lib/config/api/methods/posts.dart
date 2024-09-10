import 'dart:io';

import 'package:dio/dio.dart';

import 'package:whatsevr_app/config/api/client.dart';
import 'package:whatsevr_app/config/api/requests_model/create_video_post.dart';
import 'package:whatsevr_app/config/api/response_model/create_video_post.dart';

class PostApi {
  static Future<CreateVideoPostResponse?> createVideoPost({
    required CreateVideoPostRequest post,
  }) async {
    try {
      Response response = await ApiClient.client.post(
        '/v1/create-video-post',
        data: post.toMap(),
      );

      return CreateVideoPostResponse.fromMap(response.data);
    } catch (e) {
      ApiClient.apiMethodException(e);
    }
    return null;
  }
}
