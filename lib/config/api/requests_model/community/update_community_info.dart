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
    final String? status;
    final String? bio;
    final String? description;
    final String? location;
    final bool? requireJoiningApproval;
    
    CommunityInfo({
        this.title,
        this.status,

        this.bio,
        this.description,
        this.location,
        this.requireJoiningApproval,
    });

    CommunityInfo copyWith({
        String? title,
        String? status,
        String? bio,
        String? description,
        String? location,
        bool? requireJoiningApproval,
    }) => 
        CommunityInfo(
            title: title ?? this.title,
            status: status ?? this.status,
            bio: bio ?? this.bio,
            description:  description ?? this.description,
            location: location ?? this.location,
            requireJoiningApproval: requireJoiningApproval ?? this.requireJoiningApproval,
        );

    factory CommunityInfo.fromJson(String str) => CommunityInfo.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CommunityInfo.fromMap(Map<String, dynamic> json) => CommunityInfo(
        title: json["title"],
        status: json["status"],
        bio: json["bio"],
        description:  json["description"],
        location: json["location"],
        requireJoiningApproval: json["require_joining_approval"],
    );

    Map<String, dynamic> toMap() => {
        "title": title,
        "status": status,
        "bio": bio,
        "description": description,
        "location": location,
        "require_joining_approval": requireJoiningApproval,
    };
}
