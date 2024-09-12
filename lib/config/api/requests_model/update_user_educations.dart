import 'dart:convert';

class UpdateUserEducationsRequest {
  final String? userUid;
  final List<UserEducation>? userEducations;

  UpdateUserEducationsRequest({
    this.userUid,
    this.userEducations,
  });

  factory UpdateUserEducationsRequest.fromJson(String str) =>
      UpdateUserEducationsRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UpdateUserEducationsRequest.fromMap(Map<String, dynamic> json) =>
      UpdateUserEducationsRequest(
        userUid: json["user_uid"],
        userEducations: json["user_educations"] == null
            ? []
            : List<UserEducation>.from(
                json["user_educations"]!.map((x) => UserEducation.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "user_uid": userUid,
        "user_educations": userEducations == null
            ? []
            : List<dynamic>.from(userEducations!.map((x) => x.toMap())),
      };
}

class UserEducation {
  final String? userUid;
  final String? title;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? type;
  final String? institute;
  final bool? isOngoingEducation;

  UserEducation({
    this.userUid,
    this.title,
    this.startDate,
    this.endDate,
    this.type,
    this.institute,
    this.isOngoingEducation,
  });

  factory UserEducation.fromJson(String str) =>
      UserEducation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserEducation.fromMap(Map<String, dynamic> json) => UserEducation(
        userUid: json["user_uid"],
        title: json["title"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        type: json["type"],
        institute: json["institute"],
        isOngoingEducation: json["is_ongoing_education"],
      );

  Map<String, dynamic> toMap() => {
        "user_uid": userUid,
        "title": title,
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "type": type,
        "institute": institute,
        "is_ongoing_education": isOngoingEducation,
      };
}
