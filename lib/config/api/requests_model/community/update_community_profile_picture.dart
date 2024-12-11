import 'dart:convert';

class CommunityProfilePictureUpdateRequest {
  final String? communityUid;
  final String? userUid;
  final String? profilePictureUrl;

  CommunityProfilePictureUpdateRequest({
    this.communityUid,
    this.userUid,
    this.profilePictureUrl,
  });

  CommunityProfilePictureUpdateRequest copyWith({
    String? communityUid,
    String? userUid,
    String? profilePictureUrl,
  }) =>
      CommunityProfilePictureUpdateRequest(
        communityUid: communityUid ?? this.communityUid,
        userUid: userUid ?? this.userUid,
        profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      );

  factory CommunityProfilePictureUpdateRequest.fromJson(String str) =>
      CommunityProfilePictureUpdateRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CommunityProfilePictureUpdateRequest.fromMap(
          Map<String, dynamic> json) =>
      CommunityProfilePictureUpdateRequest(
        communityUid: json["community_uid"],
        userUid: json["user_uid"],
        profilePictureUrl: json["profile_picture_url"],
      );

  Map<String, dynamic> toMap() => {
        "community_uid": communityUid,
        "user_uid": userUid,
        "profile_picture_url": profilePictureUrl,
      };
}
