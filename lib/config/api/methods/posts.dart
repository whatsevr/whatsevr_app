import 'package:dio/dio.dart';

import '../client.dart';
import '../requests_model/create_video_post.dart';
import '../response_model/create_video_post.dart';

class PostApi {
  Future<CreateVideoPostResponse?> createVideoPost(
      {required CreateVideoPostRequest post}) async {
    try {
      Response response = await ApiClient.client
          .post('/v1/create-video-post', data: post.toMap());
      return CreateVideoPostResponse.fromMap(response.data);
    } catch (e) {
      if (e is DioException) {
        throw 'Dio Exception: ${e.error}';
      }
      rethrow;
    }
  }
}
