import 'dart:convert';

class CommonDataResponse {
  final String? message;
  final List<EducationDegree>? educationDegrees;
  final List<Gender>? genders;
  final List<WorkingMode>? workingModes;
  final List<Interest>? interests;

  CommonDataResponse({
    this.message,
    this.educationDegrees,
    this.genders,
    this.workingModes,
    this.interests,
  });

  factory CommonDataResponse.fromJson(String str) =>
      CommonDataResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CommonDataResponse.fromMap(Map<String, dynamic> json) =>
      CommonDataResponse(
        message: json['message'],
        educationDegrees: json['education_degrees'] == null
            ? <EducationDegree>[]
            : List<EducationDegree>.from(
                json['education_degrees']!
                    .map((x) => EducationDegree.fromMap(x)),
              ),
        genders: json['genders'] == null
            ? <Gender>[]
            : List<Gender>.from(json['genders']!.map((x) => Gender.fromMap(x))),
        workingModes: json['working_modes'] == null
            ? <WorkingMode>[]
            : List<WorkingMode>.from(
                json['working_modes']!.map((x) => WorkingMode.fromMap(x)),
              ),
        interests: json['interests'] == null
            ? <Interest>[]
            : List<Interest>.from(
                json['interests']!.map((x) => Interest.fromMap(x)),
              ),
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'message': message,
        'education_degrees': educationDegrees == null
            ? <dynamic>[]
            : List<dynamic>.from(
                educationDegrees!.map((EducationDegree x) => x.toMap())),
        'genders': genders == null
            ? <dynamic>[]
            : List<dynamic>.from(genders!.map((Gender x) => x.toMap())),
        'working_modes': workingModes == null
            ? <dynamic>[]
            : List<dynamic>.from(
                workingModes!.map((WorkingMode x) => x.toMap())),
        'interests': interests == null
            ? <dynamic>[]
            : List<dynamic>.from(interests!.map((Interest x) => x.toMap())),
      };
}

class EducationDegree {
  final int? id;
  final DateTime? createdAt;
  final String? type;
  final String? title;

  EducationDegree({
    this.id,
    this.createdAt,
    this.type,
    this.title,
  });

  factory EducationDegree.fromJson(String str) =>
      EducationDegree.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EducationDegree.fromMap(Map<String, dynamic> json) => EducationDegree(
        id: json['id'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        type: json['type'],
        title: json['title'],
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'created_at': createdAt?.toIso8601String(),
        'type': type,
        'title': title,
      };
}

class Gender {
  final int? id;
  final DateTime? createdAt;
  final String? gender;

  Gender({
    this.id,
    this.createdAt,
    this.gender,
  });

  factory Gender.fromJson(String str) => Gender.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Gender.fromMap(Map<String, dynamic> json) => Gender(
        id: json['id'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        gender: json['gender'],
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'created_at': createdAt?.toIso8601String(),
        'gender': gender,
      };
}

class Interest {
  final int? id;
  final DateTime? createdAt;
  final String? name;

  Interest({
    this.id,
    this.createdAt,
    this.name,
  });

  factory Interest.fromJson(String str) => Interest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Interest.fromMap(Map<String, dynamic> json) => Interest(
        id: json['id'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        name: json['name'],
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'created_at': createdAt?.toIso8601String(),
        'name': name,
      };
}

class WorkingMode {
  final int? id;
  final DateTime? createdAt;
  final String? mode;

  WorkingMode({
    this.id,
    this.createdAt,
    this.mode,
  });

  factory WorkingMode.fromJson(String str) =>
      WorkingMode.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WorkingMode.fromMap(Map<String, dynamic> json) => WorkingMode(
        id: json['id'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        mode: json['mode'],
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'created_at': createdAt?.toIso8601String(),
        'mode': mode,
      };
}
