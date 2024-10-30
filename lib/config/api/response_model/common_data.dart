import 'dart:convert';

class CommonDataResponse {
  final String? message;
  final List<EducationDegree>? educationDegrees;
  final List<Gender>? genders;
  final List<WorkingMode>? workingModes;
  final List<Interest>? interests;
  final List<CtaAction>? ctaActions;
  final List<ProfessionalStatus>? professionalStatus;

  CommonDataResponse({
    this.message,
    this.educationDegrees,
    this.genders,
    this.workingModes,
    this.interests,
    this.ctaActions,
    this.professionalStatus,
  });

  CommonDataResponse copyWith({
    String? message,
    List<EducationDegree>? educationDegrees,
    List<Gender>? genders,
    List<WorkingMode>? workingModes,
    List<Interest>? interests,
    List<CtaAction>? ctaActions,
    List<ProfessionalStatus>? professionalStatus,
  }) =>
      CommonDataResponse(
        message: message ?? this.message,
        educationDegrees: educationDegrees ?? this.educationDegrees,
        genders: genders ?? this.genders,
        workingModes: workingModes ?? this.workingModes,
        interests: interests ?? this.interests,
        ctaActions: ctaActions ?? this.ctaActions,
        professionalStatus: professionalStatus ?? this.professionalStatus,
      );

  factory CommonDataResponse.fromJson(String str) =>
      CommonDataResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CommonDataResponse.fromMap(Map<String, dynamic> json) =>
      CommonDataResponse(
        message: json['message'],
        educationDegrees: json['education_degrees'] == null
            ? []
            : List<EducationDegree>.from(json['education_degrees']!
                .map((x) => EducationDegree.fromMap(x)),),
        genders: json['genders'] == null
            ? []
            : List<Gender>.from(json['genders']!.map((x) => Gender.fromMap(x))),
        workingModes: json['working_modes'] == null
            ? []
            : List<WorkingMode>.from(
                json['working_modes']!.map((x) => WorkingMode.fromMap(x)),),
        interests: json['interests'] == null
            ? []
            : List<Interest>.from(
                json['interests']!.map((x) => Interest.fromMap(x)),),
        ctaActions: json['cta_actions'] == null
            ? []
            : List<CtaAction>.from(
                json['cta_actions']!.map((x) => CtaAction.fromMap(x)),),
        professionalStatus: json['professional_status'] == null
            ? []
            : List<ProfessionalStatus>.from(json['professional_status']!
                .map((x) => ProfessionalStatus.fromMap(x)),),
      );

  Map<String, dynamic> toMap() => {
        'message': message,
        'education_degrees': educationDegrees == null
            ? []
            : List<dynamic>.from(educationDegrees!.map((x) => x.toMap())),
        'genders': genders == null
            ? []
            : List<dynamic>.from(genders!.map((x) => x.toMap())),
        'working_modes': workingModes == null
            ? []
            : List<dynamic>.from(workingModes!.map((x) => x.toMap())),
        'interests': interests == null
            ? []
            : List<dynamic>.from(interests!.map((x) => x.toMap())),
        'cta_actions': ctaActions == null
            ? []
            : List<dynamic>.from(ctaActions!.map((x) => x.toMap())),
        'professional_status': professionalStatus == null
            ? []
            : List<dynamic>.from(professionalStatus!.map((x) => x.toMap())),
      };
}

class CtaAction {
  final int? id;
  final DateTime? createdAt;
  final String? action;
  final bool? isActive;

  CtaAction({
    this.id,
    this.createdAt,
    this.action,
    this.isActive,
  });

  CtaAction copyWith({
    int? id,
    DateTime? createdAt,
    String? action,
    bool? isActive,
  }) =>
      CtaAction(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        action: action ?? this.action,
        isActive: isActive ?? this.isActive,
      );

  factory CtaAction.fromJson(String str) => CtaAction.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CtaAction.fromMap(Map<String, dynamic> json) => CtaAction(
        id: json['id'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        action: json['action'],
        isActive: json['is_active'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'created_at': createdAt?.toIso8601String(),
        'action': action,
        'is_active': isActive,
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

  EducationDegree copyWith({
    int? id,
    DateTime? createdAt,
    String? type,
    String? title,
  }) =>
      EducationDegree(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        type: type ?? this.type,
        title: title ?? this.title,
      );

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

  Map<String, dynamic> toMap() => {
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

  Gender copyWith({
    int? id,
    DateTime? createdAt,
    String? gender,
  }) =>
      Gender(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        gender: gender ?? this.gender,
      );

  factory Gender.fromJson(String str) => Gender.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Gender.fromMap(Map<String, dynamic> json) => Gender(
        id: json['id'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        gender: json['gender'],
      );

  Map<String, dynamic> toMap() => {
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

  Interest copyWith({
    int? id,
    DateTime? createdAt,
    String? name,
  }) =>
      Interest(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        name: name ?? this.name,
      );

  factory Interest.fromJson(String str) => Interest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Interest.fromMap(Map<String, dynamic> json) => Interest(
        id: json['id'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        name: json['name'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'created_at': createdAt?.toIso8601String(),
        'name': name,
      };
}

class ProfessionalStatus {
  final int? id;
  final DateTime? createdAt;
  final String? title;

  ProfessionalStatus({
    this.id,
    this.createdAt,
    this.title,
  });

  ProfessionalStatus copyWith({
    int? id,
    DateTime? createdAt,
    String? title,
  }) =>
      ProfessionalStatus(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        title: title ?? this.title,
      );

  factory ProfessionalStatus.fromJson(String str) =>
      ProfessionalStatus.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProfessionalStatus.fromMap(Map<String, dynamic> json) =>
      ProfessionalStatus(
        id: json['id'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        title: json['title'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'created_at': createdAt?.toIso8601String(),
        'title': title,
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

  WorkingMode copyWith({
    int? id,
    DateTime? createdAt,
    String? mode,
  }) =>
      WorkingMode(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        mode: mode ?? this.mode,
      );

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

  Map<String, dynamic> toMap() => {
        'id': id,
        'created_at': createdAt?.toIso8601String(),
        'mode': mode,
      };
}
