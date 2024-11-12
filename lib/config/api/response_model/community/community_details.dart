import 'dart:convert';

class CommunityProfileDataResponse {
  final String? message;
  final CommunityInfo? communityInfo;
  final List<CommunityCoverMedia>? communityCoverMedia;
  final List<CommunityService>? communityServices;

  CommunityProfileDataResponse({
    this.message,
    this.communityInfo,
    this.communityCoverMedia,
    this.communityServices,
  });

  CommunityProfileDataResponse copyWith({
    String? message,
    CommunityInfo? communityInfo,
    List<CommunityCoverMedia>? communityCoverMedia,
    List<CommunityService>? communityServices,
  }) =>
      CommunityProfileDataResponse(
        message: message ?? this.message,
        communityInfo: communityInfo ?? this.communityInfo,
        communityCoverMedia: communityCoverMedia ?? this.communityCoverMedia,
        communityServices: communityServices ?? this.communityServices,
      );

  factory CommunityProfileDataResponse.fromJson(String str) =>
      CommunityProfileDataResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CommunityProfileDataResponse.fromMap(Map<String, dynamic> json) =>
      CommunityProfileDataResponse(
        message: json["message"],
        communityInfo: json["community_info"] == null
            ? null
            : CommunityInfo.fromMap(json["community_info"]),
        communityCoverMedia: json["community_cover_media"] == null
            ? []
            : List<CommunityCoverMedia>.from(json["community_cover_media"]!
                .map((x) => CommunityCoverMedia.fromMap(x))),
        communityServices: json["community_services"] == null
            ? []
            : List<CommunityService>.from(json["community_services"]!
                .map((x) => CommunityService.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "community_info": communityInfo?.toMap(),
        "community_cover_media": communityCoverMedia == null
            ? []
            : List<dynamic>.from(communityCoverMedia!.map((x) => x.toMap())),
        "community_services": communityServices == null
            ? []
            : List<dynamic>.from(communityServices!.map((x) => x.toMap())),
      };
}

class CommunityCoverMedia {
  final int? id;
  final DateTime? createdAt;
  final String? imageUrl;
  final bool? isVideo;
  final String? userUid;
  final dynamic videoUrl;
  final String? communityUid;

  CommunityCoverMedia({
    this.id,
    this.createdAt,
    this.imageUrl,
    this.isVideo,
    this.userUid,
    this.videoUrl,
    this.communityUid,
  });

  CommunityCoverMedia copyWith({
    int? id,
    DateTime? createdAt,
    String? imageUrl,
    bool? isVideo,
    String? userUid,
    dynamic videoUrl,
    String? communityUid,
  }) =>
      CommunityCoverMedia(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        imageUrl: imageUrl ?? this.imageUrl,
        isVideo: isVideo ?? this.isVideo,
        userUid: userUid ?? this.userUid,
        videoUrl: videoUrl ?? this.videoUrl,
        communityUid: communityUid ?? this.communityUid,
      );

  factory CommunityCoverMedia.fromJson(String str) =>
      CommunityCoverMedia.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CommunityCoverMedia.fromMap(Map<String, dynamic> json) =>
      CommunityCoverMedia(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        imageUrl: json["image_url"],
        isVideo: json["is_video"],
        userUid: json["user_uid"],
        videoUrl: json["video_url"],
        communityUid: json["community_uid"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "image_url": imageUrl,
        "is_video": isVideo,
        "user_uid": userUid,
        "video_url": videoUrl,
        "community_uid": communityUid,
      };
}

class CommunityInfo {
  final DateTime? createdAt;
  final String? adminUserUid;
  final String? status;
  final String? bio;
  final String? location;
  final String? description;
  final String? title;
  final String? profilePicture;
  final String? uid;
  final String? username;
  final int? totalMembers;
  final bool? requireJoiningApproval;
  final String? seoDataWeighted;

  CommunityInfo({
    this.createdAt,
    this.adminUserUid,
    this.status,
    this.bio,
    this.location,
    this.description,
    this.title,
    this.profilePicture,
    this.uid,
    this.username,
    this.totalMembers,
    this.requireJoiningApproval,
    this.seoDataWeighted,
  });

  CommunityInfo copyWith({
    DateTime? createdAt,
    String? adminUserUid,
    String? status,
    String? bio,
    String? location,
    String? description,
    String? title,
    String? profilePicture,
    String? uid,
    String? username,
    int? totalMembers,
    bool? requireJoiningApproval,
    String? seoDataWeighted,
  }) =>
      CommunityInfo(
        createdAt: createdAt ?? this.createdAt,
        adminUserUid: adminUserUid ?? this.adminUserUid,
        status: status ?? this.status,
        bio: bio ?? this.bio,
        location: location ?? this.location,
        description: description ?? this.description,
        title: title ?? this.title,
        profilePicture: profilePicture ?? this.profilePicture,
        uid: uid ?? this.uid,
        username: username ?? this.username,
        totalMembers: totalMembers ?? this.totalMembers,
        requireJoiningApproval:
            requireJoiningApproval ?? this.requireJoiningApproval,
        seoDataWeighted: seoDataWeighted ?? this.seoDataWeighted,
      );

  factory CommunityInfo.fromJson(String str) =>
      CommunityInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CommunityInfo.fromMap(Map<String, dynamic> json) => CommunityInfo(
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        adminUserUid: json["admin_user_uid"],
        status: json["status"],
        bio: json["bio"],
        location: json["location"],
        description: json["description"],
        title: json["title"],
        profilePicture: json["profile_picture"],
        uid: json["uid"],
        username: json["username"],
        totalMembers: json["total_members"],
        requireJoiningApproval: json["require_joining_approval"],
        seoDataWeighted: json["seo_data_weighted"],
      );

  Map<String, dynamic> toMap() => {
        "created_at": createdAt?.toIso8601String(),
        "admin_user_uid": adminUserUid,
        "status": status,
        "bio": bio,
        "location": location,
        "description": description,
        "title": title,
        "profile_picture": profilePicture,
        "uid": uid,
        "username": username,
        "total_members": totalMembers,
        "require_joining_approval": requireJoiningApproval,
        "seo_data_weighted": seoDataWeighted,
      };
}

class CommunityService {
  final int? id;
  final DateTime? createdAt;
  final String? title;
  final dynamic userUid;
  final String? description;
  final String? communityUid;

  CommunityService({
    this.id,
    this.createdAt,
    this.title,
    this.userUid,
    this.description,
    this.communityUid,
  });

  CommunityService copyWith({
    int? id,
    DateTime? createdAt,
    String? title,
    dynamic userUid,
    String? description,
    String? communityUid,
  }) =>
      CommunityService(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        title: title ?? this.title,
        userUid: userUid ?? this.userUid,
        description: description ?? this.description,
        communityUid: communityUid ?? this.communityUid,
      );

  factory CommunityService.fromJson(String str) =>
      CommunityService.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CommunityService.fromMap(Map<String, dynamic> json) =>
      CommunityService(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        title: json["title"],
        userUid: json["user_uid"],
        description: json["description"],
        communityUid: json["community_uid"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "title": title,
        "user_uid": userUid,
        "description": description,
        "community_uid": communityUid,
      };
}
