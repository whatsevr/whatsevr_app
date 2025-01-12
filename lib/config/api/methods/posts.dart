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
import 'package:whatsevr_app/config/api/response_model/post/flicks.dart';
import 'package:whatsevr_app/config/api/response_model/post/memories.dart';
import 'package:whatsevr_app/config/api/response_model/post/mix_content.dart';
import 'package:whatsevr_app/config/api/response_model/post/offers.dart';
import 'package:whatsevr_app/config/api/response_model/post/photo_posts.dart';
import 'package:whatsevr_app/config/api/response_model/post/video_posts.dart';

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

  static Future<(int? statusCode, String? message, String? wtvUid)?> createWtv({
    required CreateVideoPostRequest post,
  }) async {
    try {
      final Response response = await ApiClient.client.post(
        '/v1/create-video-post',
        data: post.toMap(),
      );

      return (
        response.statusCode,
        response.data['message'] as String?,
        response.data['wtv_uid'] as String?,
      );
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

  static Future<(int? statusCode, String? message, String? flickUid)?>
      createFlickPost({
    required CreateFlickPostRequest post,
  }) async {
    try {
      final Response response = await ApiClient.client.post(
        '/v1/create-flick-post',
        data: post.toMap(),
      );

      return (
        response.statusCode,
        response.data['message'] as String?,
        response.data['flick_uid'] as String?,
      );
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

  static Future<(int? statusCode, String? message, String? memoryUid)?>
      createMemory({
    required CreateMemoryRequest post,
  }) async {
    try {
      final Response response = await ApiClient.client.post(
        '/v1/create-memory',
        data: post.toMap(),
      );

      return (
        response.statusCode,
        response.data['message'] as String?,
        response.data['memory_uid'] as String?,
      );
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

  static Future<(int? statusCode, String? message, String? offerUid)?>
      createOffer({
    required CreateOfferRequest post,
  }) async {
    try {
      final Response response = await ApiClient.client.post(
        '/v1/create-offer',
        data: post.toMap(),
      );

      return (
        response.statusCode,
        response.data['message'] as String?,
        response.data['offer_uid'] as String?,
      );
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

  static Future<(int? statusCode, String? message, String? photoUid)?>
      createPhotoPost({
    required CreatePhotoPostRequest post,
  }) async {
    try {
      final Response response = await ApiClient.client.post(
        '/v1/create-photo-post',
        data: post.toMap(),
      );

      return (
        response.statusCode,
        response.data['message'] as String?,
        response.data['photo_uid'] as String?,
      );
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<(int? statusCode, String? message, String? pdfUid)?>
      uploadPdfDoc({
    required UploadPdfRequest post,
  }) async {
    try {
      final Response response = await ApiClient.client.post(
        '/v1/upload-pdf-doc',
        data: post.toMap(),
      );

      return (
        response.statusCode,
        response.data['message'] as String?,
        response.data['pdf_uid'] as String?,
      );
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<UserAndCommunityVideoPostsResponse?> getVideoPosts({
    String? userUid,
    String? communityUid,
  }) async {
    try {
      final Response response = await ApiClient.client.get(
        '/v1/get-video-posts',
        queryParameters: <String, dynamic>{
          if (userUid != null) 'user_uid': userUid,
          if (communityUid != null) 'community_uid': communityUid,
        },
      );
      if (response.data != null) {
        return UserAndCommunityVideoPostsResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<UserAndCommunityFlicksResponse?> getFlicks({
    String? userUid,
    String? communityUid,
  }) async {
    try {
      final Response response = await ApiClient.client.get(
        '/v1/get-flicks',
        queryParameters: <String, dynamic>{
          if (userUid != null) 'user_uid': userUid,
          if (communityUid != null) 'community_uid': communityUid,
        },
      );
      if (response.data != null) {
        return UserAndCommunityFlicksResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<UserAndCommunityMemoriesResponse?> getMemories({
    String? userUid,
    String? communityUid,
  }) async {
    try {
      final Response response = await ApiClient.client.get(
        '/v1/get-memories',
        queryParameters: <String, dynamic>{
          if (userUid != null) 'user_uid': userUid,
          if (communityUid != null) 'community_uid': communityUid,
        },
      );
      if (response.data != null) {
        return UserAndCommunityMemoriesResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<UserAndCommunityPhotoPostsResponse?> getPhotoPosts({
    String? userUid,
    String? communityUid,
  }) async {
    try {
      final Response response = await ApiClient.client.get(
        '/v1/get-photo-posts',
        queryParameters: <String, dynamic>{
          if (userUid != null) 'user_uid': userUid,
          if (communityUid != null) 'community_uid': communityUid,
        },
      );
      if (response.data != null) {
        return UserAndCommunityPhotoPostsResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<UserAndCommunityOffersResponse?> getOfferPosts({
    String? userUid,
    String? communityUid,
  }) async {
    try {
      final Response response = await ApiClient.client.get(
        '/v1/get-offer-posts',
        queryParameters: <String, dynamic>{
          if (userUid != null) 'user_uid': userUid,
          if (communityUid != null) 'community_uid': communityUid,
        },
      );
      if (response.data != null) {
        return UserAndCommunityOffersResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<UserAndCommunityMixContentResponse?> getMixContent({
    String? userUid,
    String? communityUid,
  }) async {
    try {
      final Response response = await ApiClient.client.get(
        '/v1/get-mix-content',
        queryParameters: <String, dynamic>{
          if (userUid != null) 'user_uid': userUid,
          if (communityUid != null) 'community_uid': communityUid,
        },
      );
      if (response.data != null) {
        return UserAndCommunityMixContentResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }
}
