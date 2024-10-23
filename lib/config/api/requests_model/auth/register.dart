import 'dart:convert';

class UserRegistrationRequest {
  final String? userUid;
  final String? name;
  final String? emailId;
  final String? mobileNumber;

  UserRegistrationRequest({
    this.userUid,
    this.name,
    this.emailId,
    this.mobileNumber,
  });

  UserRegistrationRequest copyWith({
    String? userUid,
    String? name,
    String? emailId,
    String? mobileNumber,
  }) =>
      UserRegistrationRequest(
        userUid: userUid ?? this.userUid,
        name: name ?? this.name,
        emailId: emailId ?? this.emailId,
        mobileNumber: mobileNumber ?? this.mobileNumber,
      );

  factory UserRegistrationRequest.fromJson(String str) =>
      UserRegistrationRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserRegistrationRequest.fromMap(Map<String, dynamic> json) =>
      UserRegistrationRequest(
        userUid: json["user_uid"],
        name: json["name"],
        emailId: json["email_id"],
        mobileNumber: json["mobile_number"],
      );

  Map<String, dynamic> toMap() => {
        "user_uid": userUid,
        "name": name,
        "email_id": emailId,
        "mobile_number": mobileNumber,
      };
}
