import 'dart:convert';

class ProfilePictureUpdateRequest {
  final String? userUid;
  final String? profilePictureUrl;

  ProfilePictureUpdateRequest({
    this.userUid,
    this.profilePictureUrl,
  });

  factory ProfilePictureUpdateRequest.fromJson(String str) =>
      ProfilePictureUpdateRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProfilePictureUpdateRequest.fromMap(Map<String, dynamic> json) =>
      ProfilePictureUpdateRequest(
        userUid: json['user_uid'],
        profilePictureUrl: json['profile_picture_url'],
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'user_uid': userUid,
        'profile_picture_url': profilePictureUrl,
      };
}
