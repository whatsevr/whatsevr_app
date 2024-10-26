import 'package:dio/dio.dart';

import 'package:whatsevr_app/config/api/client.dart';
import 'package:whatsevr_app/config/api/response_model/comments/get_comments.dart';

import 'package:whatsevr_app/config/api/response_model/recommendation_videos.dart';

import '../external/models/business_validation_exception.dart';

class CommentsApi {
  static Future<GetCommentsResponse?> getComments({
    required int page,
    int pageSize = 10,
    String? videoPostUid,
  }) async {
    try {
      Response response =
          await ApiClient.client.get('/v1/get-comments', queryParameters: {
        'page': page,
        'page_size': pageSize,
        'video_post_uid': videoPostUid,
      });
      if (response.data != null) {
        return GetCommentsResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }
}
