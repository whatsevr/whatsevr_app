import 'package:dio/dio.dart';

import 'package:whatsevr_app/config/api/client.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import 'package:whatsevr_app/config/api/requests_model/create_flick_post.dart';
import 'package:whatsevr_app/config/api/requests_model/create_memory.dart';
import 'package:whatsevr_app/config/api/requests_model/create_offer.dart';
import 'package:whatsevr_app/config/api/requests_model/create_photo_post.dart';
import 'package:whatsevr_app/config/api/requests_model/create_video_post.dart';
import 'package:whatsevr_app/config/api/requests_model/sanity_check_new_flick_post.dart';
import 'package:whatsevr_app/config/api/requests_model/sanity_check_new_memory.dart';
import 'package:whatsevr_app/config/api/requests_model/sanity_check_new_offer.dart';
import 'package:whatsevr_app/config/api/requests_model/sanity_check_new_photo_posts.dart';
import 'package:whatsevr_app/config/api/requests_model/sanity_check_new_video_post.dart';
import 'package:whatsevr_app/config/api/requests_model/upload_pdf.dart';

class PostApi {
  static Future<(String? message, int? statusCode)?> sanityCheckNewVideoPost({
    required SanityCheckNewVideoPostRequest request,
  }) async {
    try {
      final Response response = await ApiClient.client.post(
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
      final Response response = await ApiClient.client.post(
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
      final Response response = await ApiClient.client.post(
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
      final Response response = await ApiClient.client.post(
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
    required SanityCheckNewMemoryRequest request,
  }) async {
    try {
      final Response response = await ApiClient.client.post(
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
    required CreateMemoryRequest post,
  }) async {
    try {
      final Response response = await ApiClient.client.post(
        '/v1/create-memory',
        data: post.toMap(),
      );

      return (response.data['message'] as String?, response.statusCode);
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<(String? message, int? statusCode)?> sanityCheckNewOffer({
    required SanityCheckNewOfferRequest request,
  }) async {
    try {
      final Response response = await ApiClient.client.post(
        '/v1/sanity-check-new-offer',
        data: request.toMap(),
      );

      return (response.data['message'] as String?, response.statusCode);
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<(String? message, int? statusCode)?> createOffer({
    required CreateOfferRequest post,
  }) async {
    try {
      final Response response = await ApiClient.client.post(
        '/v1/create-offer',
        data: post.toMap(),
      );

      return (response.data['message'] as String?, response.statusCode);
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<(String? message, int? statusCode)?> sanityCheckNewPhotoPost({
    required SanityCheckNewPhotoPostRequest request,
  }) async {
    try {
      final Response response = await ApiClient.client.post(
        '/v1/sanity-check-new-photo-post',
        data: request.toMap(),
      );

      return (response.data['message'] as String?, response.statusCode);
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<(String? message, int? statusCode)?> createPhotoPost({
    required CreatePhotoPostRequest post,
  }) async {
    try {
      final Response response = await ApiClient.client.post(
        '/v1/create-photo-post',
        data: post.toMap(),
      );

      return (response.data['message'] as String?, response.statusCode);
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<(String? message, int? statusCode)?> uploadPdfDoc({
    required UploadPdfRequest post,
  }) async {
    try {
      final Response response = await ApiClient.client.post(
        '/v1/upload-pdf-doc',
        data: post.toMap(),
      );

      return (response.data['message'] as String?, response.statusCode);
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }
}
