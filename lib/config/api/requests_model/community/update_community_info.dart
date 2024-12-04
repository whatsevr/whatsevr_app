import 'dart:convert';

class UpdateCommunityInfoRequest {
    final String? communityUid;
    final String? userUid;
    final CommunityInfo? communityInfo;

    UpdateCommunityInfoRequest({
        this.communityUid,
        this.userUid,
        this.communityInfo,
    });

    UpdateCommunityInfoRequest copyWith({
        String? communityUid,
        String? userUid,
        CommunityInfo? communityInfo,
    }) => 
        UpdateCommunityInfoRequest(
            communityUid: communityUid ?? this.communityUid,
            userUid: userUid ?? this.userUid,
            communityInfo: communityInfo ?? this.communityInfo,
        );

    factory UpdateCommunityInfoRequest.fromJson(String str) => UpdateCommunityInfoRequest.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UpdateCommunityInfoRequest.fromMap(Map<String, dynamic> json) => UpdateCommunityInfoRequest(
        communityUid: json["community_uid"],
        userUid: json["user_uid"],
        communityInfo: json["community_info"] == null ? null : CommunityInfo.fromMap(json["community_info"]),
    );

    Map<String, dynamic> toMap() => {
        "community_uid": communityUid,
        "user_uid": userUid,
        "community_info": communityInfo?.toMap(),
    };
}

class CommunityInfo {
    final String? title;
    final String? bio;
    final String? location;

    CommunityInfo({
        this.title,
        this.bio,
        this.location,
    });

    CommunityInfo copyWith({
        String? title,
        String? bio,
        String? location,
    }) => 
        CommunityInfo(
            title: title ?? this.title,
            bio: bio ?? this.bio,
            location: location ?? this.location,
        );

    factory CommunityInfo.fromJson(String str) => CommunityInfo.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CommunityInfo.fromMap(Map<String, dynamic> json) => CommunityInfo(
        title: json["title"],
        bio: json["bio"],
        location: json["location"],
    );

    Map<String, dynamic> toMap() => {
        "title": title,
        "bio": bio,
        "location": location,
    };
}
