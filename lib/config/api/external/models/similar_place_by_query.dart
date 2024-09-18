import 'dart:convert';

class SimilarPlacesByQueryResponse {
  final List<Suggestion>? suggestions;

  SimilarPlacesByQueryResponse({
    this.suggestions,
  });

  factory SimilarPlacesByQueryResponse.fromJson(String str) =>
      SimilarPlacesByQueryResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SimilarPlacesByQueryResponse.fromMap(Map<String, dynamic> json) =>
      SimilarPlacesByQueryResponse(
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
  final StructuredFormat? structuredFormat;
  final List<String>? types;

  PlacePrediction({
    this.placeId,
    this.structuredFormat,
    this.types,
  });

  factory PlacePrediction.fromJson(String str) =>
      PlacePrediction.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlacePrediction.fromMap(Map<String, dynamic> json) => PlacePrediction(
        placeId: json["placeId"],
        structuredFormat: json["structuredFormat"] == null
            ? null
            : StructuredFormat.fromMap(json["structuredFormat"]),
        types: json["types"] == null
            ? []
            : List<String>.from(json["types"]!.map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "placeId": placeId,
        "structuredFormat": structuredFormat?.toMap(),
        "types": types == null ? [] : List<dynamic>.from(types!.map((x) => x)),
      };
}

class StructuredFormat {
  final MainText? mainText;
  final MainText? secondaryText;

  StructuredFormat({
    this.mainText,
    this.secondaryText,
  });

  factory StructuredFormat.fromJson(String str) =>
      StructuredFormat.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StructuredFormat.fromMap(Map<String, dynamic> json) =>
      StructuredFormat(
        mainText: json["mainText"] == null
            ? null
            : MainText.fromMap(json["mainText"]),
        secondaryText: json["secondaryText"] == null
            ? null
            : MainText.fromMap(json["secondaryText"]),
      );

  Map<String, dynamic> toMap() => {
        "mainText": mainText?.toMap(),
        "secondaryText": secondaryText?.toMap(),
      };
}

class MainText {
  final String? text;

  MainText({
    this.text,
  });

  factory MainText.fromJson(String str) => MainText.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MainText.fromMap(Map<String, dynamic> json) => MainText(
        text: json["text"],
      );

  Map<String, dynamic> toMap() => {
        "text": text,
      };
}
