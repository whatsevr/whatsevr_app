import 'package:dio/dio.dart';

import 'package:whatsevr_app/config/api/client.dart';

import 'package:whatsevr_app/config/api/response_model/reactions/get_reactions.dart';

import '../external/models/business_validation_exception.dart';

class ReactionsApi {
  static Future<GetReactionsResponse?> getReactions({
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
      Response response =
          await ApiClient.client.get('/v1/get-reactions', queryParameters: {
        'page': page,
        'page_size': pageSize,
        'video_post_uid': videoPostUid,
        'flick_post_uid': flickPostUid,
        'memory_uid': memoryUid,
        'offer_post_uid': offerPostUid,
        'photo_post_uid': photoPostUid,
        'pdf_uid': pdfUid,
      });
      if (response.data != null) {
        return GetReactionsResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<(int? statusCode, String? message)?> recordReaction({
    required String? reactionType,
    required String? userUid,
    String? videoPostUid,
    String? flickPostUid,
    String? memoryUid,
    String? offerPostUid,
    String? photoPostUid,
    String? pdfUid,
  }) async {
    try {
      Response response = await ApiClient.client.post(
        '/v1/record-reaction',
        data: {
          'reaction_type': reactionType,
          'user_uid': userUid,
          'video_post_uid': videoPostUid,
          'flick_post_uid': flickPostUid,
          'memory_uid': memoryUid,
          'offer_post_uid': offerPostUid,
          'photo_post_uid': photoPostUid,
          'pdf_uid': pdfUid,
        },
      );
      if (response.data != null) {
        return (
          response.statusCode,
          response.data['message'] as String?,
        );
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<(int? statusCode, String? message)?> deleteReaction({
    required String? userUid,
    String? videoPostUid,
    String? flickPostUid,
    String? memoryUid,
    String? offerPostUid,
    String? photoPostUid,
    String? pdfUid,
  }) async {
    try {
      Response response = await ApiClient.client.post(
        '/v1/remove-reaction',
        data: {
          'user_uid': userUid,
          'video_post_uid': videoPostUid,
          'flick_post_uid': flickPostUid,
          'memory_uid': memoryUid,
          'offer_post_uid': offerPostUid,
          'photo_post_uid': photoPostUid,
          'pdf_uid': pdfUid,
        },
      );
      if (response.data != null) {
        return (
          response.statusCode,
          response.data['message'] as String?,
        );
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }
}
