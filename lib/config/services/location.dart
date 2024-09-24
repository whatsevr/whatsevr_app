import 'package:dio/dio.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/foundation.dart';

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:whatsevr_app/config/api/client.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import '../api/external/models/places_nearby.dart';
import '../api/external/models/similar_place_by_query.dart';

class LocationService {
  static const String _googlePlaceAndGeoCodingApiKey =
      "AIzaSyBO4o78fH_94mh2JHYjiq3WAa9Sue6G5EE";
  LocationService._();

  static Future<void> getNearByPlacesFromLatLong({
    double? lat,
    double? long,
    required Function(PlacesNearbyResponse? nearbyPlacesResponse, double? lat,
            double? long, bool isDeviceGpsEnabled, bool isPermissionAllowed)
        onCompleted,
  }) async {
    try {
      if (lat == null || long == null) {
        bool deviceGpsEnabled = await Geolocator.isLocationServiceEnabled();
        if (!deviceGpsEnabled) {
          onCompleted(null, null, null, false, false);
          return;
        }
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
        }
        if (permission == LocationPermission.deniedForever) {
          onCompleted(null, null, null, true, false);
          return;
        }
        Position position = await Geolocator.getCurrentPosition(
            locationSettings:
                const LocationSettings(accuracy: LocationAccuracy.high));
        lat = position.latitude;
        long = position.longitude;
      }
      Response response = await ApiClient.generalPurposeClient().post(
        'https://places.googleapis.com/v1/places:searchNearby',
        data: {
          "maxResultCount": 20,
          "locationRestriction": {
            "circle": {
              "center": {
                "latitude": lat,
                "longitude": long,
              },
              "radius": 1000.0
            }
          }
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "X-Goog-Api-Key": _googlePlaceAndGeoCodingApiKey,
            "X-Goog-FieldMask":
                "places.displayName,places.location,places.primaryType,places.name,places.userRatingCount",
          },
        ),
      );
      if (response.data == null) {
        onCompleted(null, lat, long, true, true);
      }
      PlacesNearbyResponse nearbyPlacesResponse =
          PlacesNearbyResponse.fromMap(response.data);
      onCompleted(nearbyPlacesResponse, lat, long, true, true);
    } catch (e) {
      if (e is! BusinessValidationException) {
        if (kDebugMode) rethrow;
        return;
      }
      rethrow;
    }
  }

  static void getSearchPredictedPlacesNames(
      {required String searchQuery,
      required Function(SimilarPlacesByQueryResponse?) onCompleted}) async {
    if (searchQuery.length < 4) {
      return;
    }
    EasyDebounce.debounce(
        'easy-debounce-32623', const Duration(milliseconds: 700), () async {
      try {
        Response response =
            await ApiClient.generalPurposeClient(30 * 24 * 60, true).post(
          'https://places.googleapis.com/v1/places:autocomplete',
          data: {
            "input": searchQuery,
            "languageCode": "en",
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "X-Goog-Api-Key": _googlePlaceAndGeoCodingApiKey,
          }),
        );
        if (response.data == null) {
          throw BusinessValidationException(
              'Failed to get search predicted places names');
        }
        SimilarPlacesByQueryResponse placesByQueryResponse =
            SimilarPlacesByQueryResponse.fromMap(response.data);
        onCompleted(placesByQueryResponse);
      } catch (e) {
        if (e is! BusinessValidationException) {
          if (kDebugMode) rethrow;
          return;
        }
        rethrow;
      }
    });
  }

  static Future<void> getLatLongFromGooglePlaceName(
      {required String? placeName,
      Function(double lat, double long)? onCompleted}) async {
    if (placeName == null) return;
    try {
      List<geocoding.Location> locations =
          await geocoding.locationFromAddress(placeName);
      if (locations.isEmpty) {
        return;
      }

      onCompleted?.call(locations.first.latitude, locations.first.longitude);
    } catch (e) {
      if (e is! BusinessValidationException) {
        if (kDebugMode) rethrow;
        return;
      }
      rethrow;
    }
  }
}
