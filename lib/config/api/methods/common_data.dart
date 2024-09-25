import 'package:dio/dio.dart';

import 'package:whatsevr_app/config/api/client.dart';
import 'package:whatsevr_app/config/api/response_model/common_data.dart';

import '../external/models/business_validation_exception.dart';

class CommonDataApi {
  static Future<CommonDataResponse?> getAllCommonData() async {
    try {
      Response response = await ApiClient.client.get('/v1/common-data');

      if (response.data != null) {
        return CommonDataResponse.fromMap(response.data);
      }
    } catch (e, s) {
      productionSafetyCatch(e, s);
    }
    return null;
  }
}
