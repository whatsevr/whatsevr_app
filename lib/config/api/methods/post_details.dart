import 'package:dio/dio.dart';
import 'package:whatsevr_app/config/api/client.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import 'package:whatsevr_app/config/api/response_model/post_details/video.dart';

class PostDetailsApi {
  static Future<VideoPostDetailsResponse?> video({
    required String videoPostUid,
  }) async {
    try {
      final Response response = await ApiClient.client
          .get('/v1/video-post-details', queryParameters: {
        'video_post_uid': videoPostUid,
      },);
      if (response.data != null) {
        return VideoPostDetailsResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }
}
