import 'dart:convert';

class CommonDataResponse {
  final String? message;
  final List<EducationDegree>? educationDegrees;

  CommonDataResponse({
    this.message,
    this.educationDegrees,
  });

  factory CommonDataResponse.fromJson(String str) =>
      CommonDataResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CommonDataResponse.fromMap(Map<String, dynamic> json) =>
      CommonDataResponse(
        message: json["message"],
        educationDegrees: json["education_degrees"] == null
            ? []
            : List<EducationDegree>.from(json["education_degrees"]!
                .map((x) => EducationDegree.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "education_degrees": educationDegrees == null
            ? []
            : List<dynamic>.from(educationDegrees!.map((x) => x.toMap())),
      };
}

class EducationDegree {
  final int? id;
  final DateTime? createdAt;
  final String? type;
  final String? name;

  EducationDegree({
    this.id,
    this.createdAt,
    this.type,
    this.name,
  });

  factory EducationDegree.fromJson(String str) =>
      EducationDegree.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EducationDegree.fromMap(Map<String, dynamic> json) => EducationDegree(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        type: json["type"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "type": type,
        "name": name,
      };
}
