import 'package:dio/dio.dart';

import 'package:whatsevr_app/config/api/client.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import 'package:whatsevr_app/config/api/requests_model/comments/comment_and_reply.dart';
import 'package:whatsevr_app/config/api/response_model/comments/get_comments.dart';

class CommentsApi {
  static Future<GetCommentsResponse?> getComments({
    required int page,
    int pageSize = 10,
    String? videoPostUid,
    String? flickPostUid,
    String? memoryUid,
    String? offerPostUid,
    String? photoPostUid,
    String? pdfUid,
  }) async {
    try {
      final Response response = await ApiClient.client.get(
        '/v1/get-comments',
        queryParameters: {
          'page': page,
          'page_size': pageSize,
          'video_post_uid': videoPostUid,
          'flick_post_uid': flickPostUid,
          'memory_uid': memoryUid,
          'offer_post_uid': offerPostUid,
          'photo_post_uid': photoPostUid,
          'pdf_uid': pdfUid,
        },
      );
      if (response.data != null) {
        return GetCommentsResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<(int? statusCode, String? message, String? newCommentUid)?>
      postCommentOrReply(CommentAndReplyRequest request) async {
    try {
      final Response response = await ApiClient.client
          .post('/v1/post-comment-or-reply', data: request.toJson());
      if (response.data != null) {
        return (
          response.statusCode,
          response.data['message'] as String?,
          response.data['comment_uid'] as String?,

        );
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }
}
