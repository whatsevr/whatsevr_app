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
  final String? emailId;
  final String? name;
  final String? bio;
  final String? address;
  final DateTime? dob;
  final String? portfolioStatus;
  final String? portfolioDescription;
  final String? portfolioTitle;
  final String? gender;

  UserInfo({
    this.emailId,
    this.name,
    this.bio,
    this.address,
    this.dob,
    this.portfolioStatus,
    this.portfolioDescription,
    this.portfolioTitle,
    this.gender,
  });

  factory UserInfo.fromJson(String str) => UserInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserInfo.fromMap(Map<String, dynamic> json) => UserInfo(
        emailId: json['email_id'],
        name: json['name'],
        bio: json['bio'],
        address: json['address'],
        dob: json['dob'] == null ? null : DateTime.parse(json['dob']),
        portfolioStatus: json['portfolio_status'],
        portfolioDescription: json['portfolio_description'],
        portfolioTitle: json['portfolio_title'],
        gender: json['gender'],
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'email_id': emailId,
        'name': name,
        'bio': bio,
        'address': address,
        'dob':
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        'portfolio_status': portfolioStatus,
        'portfolio_description': portfolioDescription,
        'portfolio_title': portfolioTitle,
        'gender': gender,
      };
}
