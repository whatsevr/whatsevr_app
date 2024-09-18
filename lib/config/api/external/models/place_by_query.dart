import 'dart:convert';

class PlacesByQueryResponse {
  final List<Suggestion>? suggestions;

  PlacesByQueryResponse({
    this.suggestions,
  });

  factory PlacesByQueryResponse.fromJson(String str) =>
      PlacesByQueryResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlacesByQueryResponse.fromMap(Map<String, dynamic> json) =>
      PlacesByQueryResponse(
        suggestions: json["suggestions"] == null
            ? []
            : List<Suggestion>.from(
                json["suggestions"]!.map((x) => Suggestion.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "suggestions": suggestions == null
            ? []
            : List<dynamic>.from(suggestions!.map((x) => x.toMap())),
      };
}

class Suggestion {
  final PlacePrediction? placePrediction;

  Suggestion({
    this.placePrediction,
  });

  factory Suggestion.fromJson(String str) =>
      Suggestion.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Suggestion.fromMap(Map<String, dynamic> json) => Suggestion(
        placePrediction: json["placePrediction"] == null
            ? null
            : PlacePrediction.fromMap(json["placePrediction"]),
      );

  Map<String, dynamic> toMap() => {
        "placePrediction": placePrediction?.toMap(),
      };
}

class PlacePrediction {
  final String? placeId;
  final PlaceName? text;

  final List<String>? types;

  PlacePrediction({
    this.placeId,
    this.text,
    this.types,
  });

  factory PlacePrediction.fromJson(String str) =>
      PlacePrediction.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlacePrediction.fromMap(Map<String, dynamic> json) => PlacePrediction(
        placeId: json["placeId"],
        text: json["text"] == null ? null : PlaceName.fromMap(json["text"]),
        types: json["types"] == null
            ? []
            : List<String>.from(json["types"]!.map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "placeId": placeId,
        "text": text?.toMap(),
        "types": types == null ? [] : List<dynamic>.from(types!.map((x) => x)),
      };
}

class PlaceName {
  final String? text;

  PlaceName({
    this.text,
  });

  factory PlaceName.fromJson(String str) => PlaceName.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlaceName.fromMap(Map<String, dynamic> json) => PlaceName(
        text: json["text"],
      );

  Map<String, dynamic> toMap() => {
        "text": text,
      };
}
