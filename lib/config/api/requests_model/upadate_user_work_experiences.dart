import 'dart:convert';

class UpdateUserWorkExperiencesRequest {
  final String? userUid;
  final List<UserWorkExperience>? userWorkExperiences;

  UpdateUserWorkExperiencesRequest({
    this.userUid,
    this.userWorkExperiences,
  });

  factory UpdateUserWorkExperiencesRequest.fromJson(String str) =>
      UpdateUserWorkExperiencesRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UpdateUserWorkExperiencesRequest.fromMap(Map<String, dynamic> json) =>
      UpdateUserWorkExperiencesRequest(
        userUid: json["user_uid"],
        userWorkExperiences: json["user-work-experiences"] == null
            ? []
            : List<UserWorkExperience>.from(json["user-work-experiences"]!
                .map((x) => UserWorkExperience.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "user_uid": userUid,
        "user-work-experiences": userWorkExperiences == null
            ? []
            : List<dynamic>.from(userWorkExperiences!.map((x) => x.toMap())),
      };
}

class UserWorkExperience {
  final String? designation;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? userUid;
  final String? workingMode;
  final bool? isCurrentlyWorking;
  final String? companyName;

  UserWorkExperience({
    this.designation,
    this.startDate,
    this.endDate,
    this.userUid,
    this.workingMode,
    this.isCurrentlyWorking,
    this.companyName,
  });

  factory UserWorkExperience.fromJson(String str) =>
      UserWorkExperience.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserWorkExperience.fromMap(Map<String, dynamic> json) =>
      UserWorkExperience(
        designation: json["designation"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        userUid: json["user_uid"],
        workingMode: json["working_mode"],
        isCurrentlyWorking: json["is_currently_working"],
        companyName: json["company_name"],
      );

  Map<String, dynamic> toMap() => {
        "designation": designation,
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "user_uid": userUid,
        "working_mode": workingMode,
        "is_currently_working": isCurrentlyWorking,
        "company_name": companyName,
      };
}
