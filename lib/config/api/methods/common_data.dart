import '../client.dart';
import '../external/models/business_validation_exception.dart';
import '../response_model/common_data.dart';

class CommonDataApi {
  static Future<CommonDataResponse?> getAllCommonData() async {
    try {
      final response = await ApiClient.client.get('/v1/common-data');

      if (response.data != null) {
        return CommonDataResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }
}
