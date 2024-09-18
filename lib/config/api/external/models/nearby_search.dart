import 'dart:convert';

class NearbySearchResponse {
  final List<Place>? places;

  NearbySearchResponse({
    this.places,
  });

  factory NearbySearchResponse.fromJson(String str) =>
      NearbySearchResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NearbySearchResponse.fromMap(Map<String, dynamic> json) =>
      NearbySearchResponse(
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
  final int? userRatingCount;
  final DisplayName? displayName;
  final String? primaryType;

  Place({
    this.name,
    this.userRatingCount,
    this.displayName,
    this.primaryType,
  });

  factory Place.fromJson(String str) => Place.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Place.fromMap(Map<String, dynamic> json) => Place(
        name: json["name"],
        userRatingCount: json["userRatingCount"],
        displayName: json["displayName"] == null
            ? null
            : DisplayName.fromMap(json["displayName"]),
        primaryType: json["primaryType"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "userRatingCount": userRatingCount,
        "displayName": displayName?.toMap(),
        "primaryType": primaryType,
      };
}

class DisplayName {
  final String? text;
  final String? languageCode;

  DisplayName({
    this.text,
    this.languageCode,
  });

  factory DisplayName.fromJson(String str) =>
      DisplayName.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DisplayName.fromMap(Map<String, dynamic> json) => DisplayName(
        text: json["text"],
        languageCode: json["languageCode"],
      );

  Map<String, dynamic> toMap() => {
        "text": text,
        "languageCode": languageCode,
      };
}
