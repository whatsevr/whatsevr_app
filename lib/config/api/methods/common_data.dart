import 'dart:io';

import 'package:dio/dio.dart';

import 'package:whatsevr_app/config/api/client.dart';
import 'package:whatsevr_app/config/api/response_model/common_data.dart';

import 'package:whatsevr_app/config/api/response_model/recommendation_videos.dart';

class CommonDataApi {
  static Future<CommonDataResponse?> getAllCommonData() async {
    try {
      Response response = await ApiClient.client.get('/v1/common-data');
      if (response.statusCode == HttpStatus.ok) {
        return CommonDataResponse.fromMap(response.data);
      }
    } catch (e) {
      ApiClient.apiMethodException(e);
    }
    return null;
  }
}
