import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static String googlePlaceAndGeoCodingApiKey =
      "AIzaSyBO4o78fH_94mh2JHYjiq3WAa9Sue6G5EE";
  LocationService._();

  static getNearByPlacesFromLatLong({
    required double? lat,
    required double? long,
    Function(List<String>? placeNames, double? lat, double? long,
            bool isDeviceGpsEnabled, bool isPermissionAllowed)?
        onCompleted,
  }) async {
    if (lat == null || long == null) {
      bool deviceGpsEnabled = await Geolocator.isLocationServiceEnabled();
      if (!deviceGpsEnabled) {
        onCompleted!(null, null, null, false, false);
        return;
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        onCompleted!(null, null, null, true, false);
        return;
      }
      Position position = await Geolocator.getCurrentPosition(
          locationSettings:
              const LocationSettings(accuracy: LocationAccuracy.high));
      lat = position.latitude;
      long = position.longitude;
    }
    Response response =
        await Dio().post('https://places.googleapis.com/v1/places:searchNearby',
            data: {
              "maxResultCount": 10,
              "locationRestriction": {
                "circle": {
                  "center": {
                    "latitude": lat,
                    "longitude": long,
                  },
                  "radius": 4000.0
                }
              }
            },
            options: Options(
              headers: {"Authorization": ""},
            ),);
  }

  static getSearchPredictedPlacesWithoutLatLong({
    Function(String? placeName, double? lat, double? long)? onCompleted,
  }) {}

  static _getLatLongFromPlaceId(
      {required String placeId,
      Function(double? lat, double? long)? onCompleted}) {}
}
