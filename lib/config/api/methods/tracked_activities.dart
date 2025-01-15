import 'package:dio/dio.dart';
import 'package:whatsevr_app/config/api/client.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import 'package:whatsevr_app/config/api/requests_model/tracked_activity/track_activities.dart';
import 'package:whatsevr_app/config/api/response_model/tracked_activities/user_tracked_activities.dart';

class TrackedActivityApi {
  static Future<UserTrackedActivitiesResponse?> getUserActivities({
    required String userUid,
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final Response response = await ApiClient.client.get(
        '/v1/get-user-activities',
        queryParameters: {
          'user_uid': userUid,
          'page': page,
          'page_size': pageSize,
        },
      );

      if (response.data != null) {
        return UserTrackedActivitiesResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<(int? statusCode, String? message)?> trackActivities({
    required TrackActivitiesRequest request,
  }) async {
    try {
      final Response response = await ApiClient.client.post(
        '/v1/track-activities',
        data: request.toMap(),
      );

      return (
        response.statusCode,
        response.data['message'] as String?,
      );
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }
}
