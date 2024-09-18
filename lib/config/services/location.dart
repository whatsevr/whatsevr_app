import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:geolocator/geolocator.dart';

import '../api/external/models/nearby_search.dart';
import '../api/external/models/place_by_query.dart';

class LocationService {
  static String googlePlaceAndGeoCodingApiKey =
      "AIzaSyBO4o78fH_94mh2JHYjiq3WAa9Sue6G5EE";
  LocationService._();

  static Future<void> getNearByPlacesFromLatLong({
    double? lat,
    double? long,
    required Function(NearbySearchResponse? nearbyPlacesResponse, double? lat,
            double? long, bool isDeviceGpsEnabled, bool isPermissionAllowed)
        onCompleted,
  }) async {
    try {
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
      Response response = await Dio().post(
        'https://places.googleapis.com/v1/places:searchNearby',
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
          headers: {
            "Content-Type": "application/json",
            "X-Goog-Api-Key": googlePlaceAndGeoCodingApiKey,
            "X-Goog-FieldMask":
                "places.displayName,places.primaryType,places.name,places.userRatingCount"
          },
        ),
      );
      if (response.statusCode != 200) {
        onCompleted(null, lat, long, true, true);
      }
      NearbySearchResponse nearbyPlacesResponse =
          NearbySearchResponse.fromMap(response.data);
      onCompleted(nearbyPlacesResponse, lat, long, true, true);
    } catch (e) {
      if (e is SocketException) {
        throw Exception('Unable to connect to the internet');
      }
      if (e is DioException) {
        throw Exception('Server client error');
      }
      rethrow;
    }
  }

  static void getSearchPredictedPlacesNames(
      {required String searchQuery,
      required Function(PlacesByQueryResponse?) onCompleted}) async {
    if (searchQuery.length < 4) {
      return;
    }
    EasyDebounce.debounce(
        'easy-debounce-32623', const Duration(milliseconds: 700), () async {
      try {
        Response response = await Dio().post(
          'https://places.googleapis.com/v1/places:autocomplete',
          data: {
            "input": searchQuery,
            "languageCode": "en",
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "X-Goog-Api-Key": googlePlaceAndGeoCodingApiKey,
          }),
        );
        if (response.statusCode != 200) {
          return;
        }
        PlacesByQueryResponse placesByQueryResponse =
            PlacesByQueryResponse.fromMap(response.data);
        onCompleted(placesByQueryResponse);
      } catch (e) {
        if (e is SocketException) {
          throw Exception('Unable to connect to the internet');
        }
        if (e is DioException) {
          throw Exception('Server client error');
        }
        rethrow;
      }
    });
  }

  static Future<void> getLatLongFromPlaceId(
      {required String googlePlaceId,
      Function(double? lat, double? long)? onCompleted}) async {}
}
