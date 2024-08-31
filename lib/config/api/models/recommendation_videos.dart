import 'dart:convert';

class RecommendationVideos {
  final String? message;
  final List<RecommendationVideo>? recommendationVideos;

  RecommendationVideos({
    this.message,
    this.recommendationVideos,
  });

  factory RecommendationVideos.fromJson(String str) =>
      RecommendationVideos.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RecommendationVideos.fromMap(Map<String, dynamic> json) =>
      RecommendationVideos(
        message: json["message"],
        recommendationVideos: json["recommendation_videos"] == null
            ? []
            : List<RecommendationVideo>.from(json["recommendation_videos"]!
                .map((x) => RecommendationVideo.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "recommendation_videos": recommendationVideos == null
            ? []
            : List<dynamic>.from(recommendationVideos!.map((x) => x.toMap())),
      };
}

class RecommendationVideo {
  final int? id;
  final DateTime? createdAt;
  final String? uid;
  final String? title;
  final String? description;
  final dynamic hastags;
  final dynamic taggedUsersUid;
  final dynamic taggedPortfolios;
  final dynamic taggedCommunitiesUid;
  final dynamic likesCount;
  final bool? isDeleted;
  final bool? isArchived;
  final bool? isActive;
  final String? postType;
  final String? postCreatorType;
  final DateTime? updatedAt;
  final dynamic photosUid;
  final String? videoUid;
  final dynamic flickUid;
  final String? userUid;
  final dynamic offerUid;
  final int? userInfoId;
  final UserInfo? userInfo;
  final Video? video;

  RecommendationVideo({
    this.id,
    this.createdAt,
    this.uid,
    this.title,
    this.description,
    this.hastags,
    this.taggedUsersUid,
    this.taggedPortfolios,
    this.taggedCommunitiesUid,
    this.likesCount,
    this.isDeleted,
    this.isArchived,
    this.isActive,
    this.postType,
    this.postCreatorType,
    this.updatedAt,
    this.photosUid,
    this.videoUid,
    this.flickUid,
    this.userUid,
    this.offerUid,
    this.userInfoId,
    this.userInfo,
    this.video,
  });

  factory RecommendationVideo.fromJson(String str) =>
      RecommendationVideo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RecommendationVideo.fromMap(Map<String, dynamic> json) =>
      RecommendationVideo(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        uid: json["uid"],
        title: json["title"],
        description: json["description"],
        hastags: json["hastags"],
        taggedUsersUid: json["tagged_users_uid"],
        taggedPortfolios: json["tagged_portfolios"],
        taggedCommunitiesUid: json["tagged_communities_uid"],
        likesCount: json["likes_count"],
        isDeleted: json["is_deleted"],
        isArchived: json["is_archived"],
        isActive: json["is_active"],
        postType: json["post_type"],
        postCreatorType: json["post_creator_type"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        photosUid: json["photos_uid"],
        videoUid: json["video_uid"],
        flickUid: json["flick_uid"],
        userUid: json["user_uid"],
        offerUid: json["offer_uid"],
        userInfoId: json["user_info_id"],
        userInfo: json["user_info"] == null
            ? null
            : UserInfo.fromMap(json["user_info"]),
        video: json["video"] == null ? null : Video.fromMap(json["video"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "uid": uid,
        "title": title,
        "description": description,
        "hastags": hastags,
        "tagged_users_uid": taggedUsersUid,
        "tagged_portfolios": taggedPortfolios,
        "tagged_communities_uid": taggedCommunitiesUid,
        "likes_count": likesCount,
        "is_deleted": isDeleted,
        "is_archived": isArchived,
        "is_active": isActive,
        "post_type": postType,
        "post_creator_type": postCreatorType,
        "updated_at": updatedAt?.toIso8601String(),
        "photos_uid": photosUid,
        "video_uid": videoUid,
        "flick_uid": flickUid,
        "user_uid": userUid,
        "offer_uid": offerUid,
        "user_info_id": userInfoId,
        "user_info": userInfo?.toMap(),
        "video": video?.toMap(),
      };
}

class UserInfo {
  final int? id;
  final dynamic bio;
  final dynamic dob;
  final dynamic address;
  final String? userId;
  final String? emailId;
  final String? fullName;
  final String? userName;
  final DateTime? createdAt;
  final String? mobileNumber;
  final String? profilePicture;

  UserInfo({
    this.id,
    this.bio,
    this.dob,
    this.address,
    this.userId,
    this.emailId,
    this.fullName,
    this.userName,
    this.createdAt,
    this.mobileNumber,
    this.profilePicture,
  });

  factory UserInfo.fromJson(String str) => UserInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserInfo.fromMap(Map<String, dynamic> json) => UserInfo(
        id: json["id"],
        bio: json["bio"],
        dob: json["dob"],
        address: json["address"],
        userId: json["user_id"],
        emailId: json["email_id"],
        fullName: json["full_name"],
        userName: json["user_name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        mobileNumber: json["mobile_number"],
        profilePicture: json["profile_picture"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "bio": bio,
        "dob": dob,
        "address": address,
        "user_id": userId,
        "email_id": emailId,
        "full_name": fullName,
        "user_name": userName,
        "created_at": createdAt?.toIso8601String(),
        "mobile_number": mobileNumber,
        "profile_picture": profilePicture,
      };
}

class Video {
  final int? id;
  final String? uid;
  final String? userUid;
  final String? mediaUrl;
  final String? thumbnail;
  final DateTime? createdAt;

  Video({
    this.id,
    this.uid,
    this.userUid,
    this.mediaUrl,
    this.thumbnail,
    this.createdAt,
  });

  factory Video.fromJson(String str) => Video.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Video.fromMap(Map<String, dynamic> json) => Video(
        id: json["id"],
        uid: json["uid"],
        userUid: json["user_uid"],
        mediaUrl: json["media_url"],
        thumbnail: json["thumbnail"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "uid": uid,
        "user_uid": userUid,
        "media_url": mediaUrl,
        "thumbnail": thumbnail,
        "created_at": createdAt?.toIso8601String(),
      };
}
