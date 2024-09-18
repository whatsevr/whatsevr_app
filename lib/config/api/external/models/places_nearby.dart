import 'dart:convert';

class PlacesNearbyResponse {
  final List<Place>? places;

  PlacesNearbyResponse({
    this.places,
  });

  factory PlacesNearbyResponse.fromJson(String str) =>
      PlacesNearbyResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlacesNearbyResponse.fromMap(Map<String, dynamic> json) =>
      PlacesNearbyResponse(
        places: json["places"] == null
            ? []
            : List<Place>.from(json["places"]!.map((x) => Place.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "places": places == null
            ? []
            : List<dynamic>.from(places!.map((x) => x.toMap())),
      };
}

class Place {
  final String? name;
  final Location? location;
  final int? userRatingCount;
  final DisplayName? displayName;

  Place({
    this.name,
    this.location,
    this.userRatingCount,
    this.displayName,
  });

  factory Place.fromJson(String str) => Place.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Place.fromMap(Map<String, dynamic> json) => Place(
        name: json["name"],
        location: json["location"] == null
            ? null
            : Location.fromMap(json["location"]),
        userRatingCount: json["userRatingCount"],
        displayName: json["displayName"] == null
            ? null
            : DisplayName.fromMap(json["displayName"]),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "location": location?.toMap(),
        "userRatingCount": userRatingCount,
        "displayName": displayName?.toMap(),
      };
}

class DisplayName {
  final String? text;

  DisplayName({
    this.text,
  });

  factory DisplayName.fromJson(String str) =>
      DisplayName.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DisplayName.fromMap(Map<String, dynamic> json) => DisplayName(
        text: json["text"],
      );

  Map<String, dynamic> toMap() => {
        "text": text,
      };
}

class Location {
  final double? latitude;
  final double? longitude;

  Location({
    this.latitude,
    this.longitude,
  });

  factory Location.fromJson(String str) => Location.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Location.fromMap(Map<String, dynamic> json) => Location(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}
