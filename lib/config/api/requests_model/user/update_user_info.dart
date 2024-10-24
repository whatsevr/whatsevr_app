import 'dart:convert';

class UpdateUserInfoRequest {
  final String? userUid;
  final UserInfo? userInfo;

  UpdateUserInfoRequest({
    this.userUid,
    this.userInfo,
  });

  factory UpdateUserInfoRequest.fromJson(String str) =>
      UpdateUserInfoRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UpdateUserInfoRequest.fromMap(Map<String, dynamic> json) =>
      UpdateUserInfoRequest(
        userUid: json['user_uid'],
        userInfo: json['user_info'] == null
            ? null
            : UserInfo.fromMap(json['user_info']),
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'user_uid': userUid,
        'user_info': userInfo?.toMap(),
      };
}

class UserInfo {
  final String? publicEmailId;
  final String? name;
  final String? bio;
  final String? address;
  final DateTime? dob;

  final String? gender;

  UserInfo({
    this.publicEmailId,
    this.name,
    this.bio,
    this.address,
    this.dob,
    this.gender,
  });

  factory UserInfo.fromJson(String str) => UserInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserInfo.fromMap(Map<String, dynamic> json) => UserInfo(
        publicEmailId: json['public_email_id'],
        name: json['name'],
        bio: json['bio'],
        address: json['address'],
        dob: json['dob'] == null ? null : DateTime.parse(json['dob']),
        gender: json['gender'],
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'public_email_id': publicEmailId,
        'name': name,
        'bio': bio,
        'address': address,
        'dob': dob?.toIso8601String(),
        'gender': gender,
      };
}
