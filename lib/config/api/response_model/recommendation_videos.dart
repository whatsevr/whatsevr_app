import 'dart:convert';

class RecommendationVideosResponse {
  final String? message;
  final int? page;
  final bool? lastPage;
  final List<RecommendedVideo>? recommendedVideos;

  RecommendationVideosResponse({
    this.message,
    this.page,
    this.lastPage,
    this.recommendedVideos,
  });

  RecommendationVideosResponse copyWith({
    String? message,
    int? page,
    bool? lastPage,
    List<RecommendedVideo>? recommendedVideos,
  }) =>
      RecommendationVideosResponse(
        message: message ?? this.message,
        page: page ?? this.page,
        lastPage: lastPage ?? this.lastPage,
        recommendedVideos: recommendedVideos ?? this.recommendedVideos,
      );

  factory RecommendationVideosResponse.fromJson(String str) =>
      RecommendationVideosResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RecommendationVideosResponse.fromMap(Map<String, dynamic> json) =>
      RecommendationVideosResponse(
        message: json["message"],
        page: json["page"],
        lastPage: json["last_page"],
        recommendedVideos: json["recommended_videos"] == null
            ? []
            : List<RecommendedVideo>.from(json["recommended_videos"]!
                .map((x) => RecommendedVideo.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "page": page,
        "last_page": lastPage,
        "recommended_videos": recommendedVideos == null
            ? []
            : List<dynamic>.from(recommendedVideos!.map((x) => x.toMap())),
      };
}

class RecommendedVideo {
  final int? id;
  final DateTime? createdAt;
  final String? uid;
  final String? title;
  final String? description;
  final List<String>? hashtags;
  final List<String>? taggedUserUids;
  final bool? isDeleted;
  final bool? isArchived;
  final bool? isActive;
  final String? postCreatorType;
  final DateTime? updatedAt;
  final String? userUid;
  final String? thumbnail;
  final String? videoUrl;
  final String? location;
  final int? totalViews;
  final int? totalLikes;
  final int? totalComments;
  final String? internalAiDescription;
  final String? addressLatLongWkb;
  final String? creatorLatLongWkb;
  final List<String>? taggedCommunityUids;
  final int? totalShares;
  final int? cumulativeScore;

  final int? videoDurationInSec;
  final User? user;

  RecommendedVideo({
    this.id,
    this.createdAt,
    this.uid,
    this.title,
    this.description,
    this.hashtags,
    this.taggedUserUids,
    this.isDeleted,
    this.isArchived,
    this.isActive,
    this.postCreatorType,
    this.updatedAt,
    this.userUid,
    this.thumbnail,
    this.videoUrl,
    this.location,
    this.totalViews,
    this.totalLikes,
    this.totalComments,
    this.internalAiDescription,
    this.addressLatLongWkb,
    this.creatorLatLongWkb,
    this.taggedCommunityUids,
    this.totalShares,
    this.cumulativeScore,
    this.videoDurationInSec,
    this.user,
  });

  RecommendedVideo copyWith({
    int? id,
    DateTime? createdAt,
    String? uid,
    String? title,
    String? description,
    List<String>? hashtags,
    List<String>? taggedUserUids,
    bool? isDeleted,
    bool? isArchived,
    bool? isActive,
    String? postCreatorType,
    DateTime? updatedAt,
    String? userUid,
    String? thumbnail,
    String? videoUrl,
    String? location,
    int? totalViews,
    int? totalLikes,
    int? totalComments,
    String? internalAiDescription,
    String? addressLatLongWkb,
    String? creatorLatLongWkb,
    List<String>? taggedCommunityUids,
    int? totalShares,
    int? cumulativeScore,
    double? thumbnailAspectRatio,
    int? videoDurationInSec,
    User? user,
  }) =>
      RecommendedVideo(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        uid: uid ?? this.uid,
        title: title ?? this.title,
        description: description ?? this.description,
        hashtags: hashtags ?? this.hashtags,
        taggedUserUids: taggedUserUids ?? this.taggedUserUids,
        isDeleted: isDeleted ?? this.isDeleted,
        isArchived: isArchived ?? this.isArchived,
        isActive: isActive ?? this.isActive,
        postCreatorType: postCreatorType ?? this.postCreatorType,
        updatedAt: updatedAt ?? this.updatedAt,
        userUid: userUid ?? this.userUid,
        thumbnail: thumbnail ?? this.thumbnail,
        videoUrl: videoUrl ?? this.videoUrl,
        location: location ?? this.location,
        totalViews: totalViews ?? this.totalViews,
        totalLikes: totalLikes ?? this.totalLikes,
        totalComments: totalComments ?? this.totalComments,
        internalAiDescription:
            internalAiDescription ?? this.internalAiDescription,
        addressLatLongWkb: addressLatLongWkb ?? this.addressLatLongWkb,
        creatorLatLongWkb: creatorLatLongWkb ?? this.creatorLatLongWkb,
        taggedCommunityUids: taggedCommunityUids ?? this.taggedCommunityUids,
        totalShares: totalShares ?? this.totalShares,
        cumulativeScore: cumulativeScore ?? this.cumulativeScore,
        videoDurationInSec: videoDurationInSec ?? this.videoDurationInSec,
        user: user ?? this.user,
      );

  factory RecommendedVideo.fromJson(String str) =>
      RecommendedVideo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RecommendedVideo.fromMap(Map<String, dynamic> json) =>
      RecommendedVideo(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        uid: json["uid"],
        title: json["title"],
        description: json["description"],
        hashtags: json["hashtags"] == null
            ? []
            : List<String>.from(json["hashtags"]!.map((x) => x)),
        taggedUserUids: json["tagged_user_uids"] == null
            ? []
            : List<String>.from(json["tagged_user_uids"]!.map((x) => x)),
        isDeleted: json["is_deleted"],
        isArchived: json["is_archived"],
        isActive: json["is_active"],
        postCreatorType: json["post_creator_type"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        userUid: json["user_uid"],
        thumbnail: json["thumbnail"],
        videoUrl: json["video_url"],
        location: json["location"],
        totalViews: json["total_views"],
        totalLikes: json["total_likes"],
        totalComments: json["total_comments"],
        internalAiDescription: json["internal_ai_description"],
        addressLatLongWkb: json["address_lat_long_wkb"],
        creatorLatLongWkb: json["creator_lat_long_wkb"],
        taggedCommunityUids: json["tagged_community_uids"] == null
            ? []
            : List<String>.from(json["tagged_community_uids"]!.map((x) => x)),
        totalShares: json["total_shares"],
        cumulativeScore: json["cumulative_score"],
        videoDurationInSec: json["video_duration_in_sec"],
        user: json["user"] == null ? null : User.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "uid": uid,
        "title": title,
        "description": description,
        "hashtags":
            hashtags == null ? [] : List<dynamic>.from(hashtags!.map((x) => x)),
        "tagged_user_uids": taggedUserUids == null
            ? []
            : List<dynamic>.from(taggedUserUids!.map((x) => x)),
        "is_deleted": isDeleted,
        "is_archived": isArchived,
        "is_active": isActive,
        "post_creator_type": postCreatorType,
        "updated_at": updatedAt?.toIso8601String(),
        "user_uid": userUid,
        "thumbnail": thumbnail,
        "video_url": videoUrl,
        "location": location,
        "total_views": totalViews,
        "total_likes": totalLikes,
        "total_comments": totalComments,
        "internal_ai_description": internalAiDescription,
        "address_lat_long_wkb": addressLatLongWkb,
        "creator_lat_long_wkb": creatorLatLongWkb,
        "tagged_community_uids": taggedCommunityUids == null
            ? []
            : List<dynamic>.from(taggedCommunityUids!.map((x) => x)),
        "total_shares": totalShares,
        "cumulative_score": cumulativeScore,
        "video_duration_in_sec": videoDurationInSec,
        "user": user?.toMap(),
      };
}

class User {
  final int? id;
  final String? bio;
  final DateTime? dob;
  final String? uid;
  final String? name;
  final String? gender;
  final String? address;
  final bool? isSpam;
  final String? emailId;
  final String? username;
  final bool? isActive;
  final bool? isBanned;
  final bool? isOnline;
  final bool? isPortfolio;
  final String? mobileNumber;
  final DateTime? registeredOn;
  final bool? isDeactivated;
  final DateTime? lastActiveAt;
  final String? portfolioTitle;
  final String? profilePicture;
  final int? totalFollowers;
  final String? portfolioStatus;
  final int? totalFollowings;
  final int? totalPostLikes;
  final DateTime? portfolioCreatedAt;
  final String? portfolioDescription;
  final String? userLastLatLongWkb;

  User({
    this.id,
    this.bio,
    this.dob,
    this.uid,
    this.name,
    this.gender,
    this.address,
    this.isSpam,
    this.emailId,
    this.username,
    this.isActive,
    this.isBanned,
    this.isOnline,
    this.isPortfolio,
    this.mobileNumber,
    this.registeredOn,
    this.isDeactivated,
    this.lastActiveAt,
    this.portfolioTitle,
    this.profilePicture,
    this.totalFollowers,
    this.portfolioStatus,
    this.totalFollowings,
    this.totalPostLikes,
    this.portfolioCreatedAt,
    this.portfolioDescription,
    this.userLastLatLongWkb,
  });

  User copyWith({
    int? id,
    String? bio,
    DateTime? dob,
    String? uid,
    String? name,
    String? gender,
    String? address,
    bool? isSpam,
    String? emailId,
    String? username,
    bool? isActive,
    bool? isBanned,
    bool? isOnline,
    bool? isPortfolio,
    String? mobileNumber,
    DateTime? registeredOn,
    bool? isDeactivated,
    DateTime? lastActiveAt,
    String? portfolioTitle,
    String? profilePicture,
    int? totalFollowers,
    String? portfolioStatus,
    int? totalFollowings,
    int? totalPostLikes,
    DateTime? portfolioCreatedAt,
    String? portfolioDescription,
    String? userLastLatLongWkb,
  }) =>
      User(
        id: id ?? this.id,
        bio: bio ?? this.bio,
        dob: dob ?? this.dob,
        uid: uid ?? this.uid,
        name: name ?? this.name,
        gender: gender ?? this.gender,
        address: address ?? this.address,
        isSpam: isSpam ?? this.isSpam,
        emailId: emailId ?? this.emailId,
        username: username ?? this.username,
        isActive: isActive ?? this.isActive,
        isBanned: isBanned ?? this.isBanned,
        isOnline: isOnline ?? this.isOnline,
        isPortfolio: isPortfolio ?? this.isPortfolio,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        registeredOn: registeredOn ?? this.registeredOn,
        isDeactivated: isDeactivated ?? this.isDeactivated,
        lastActiveAt: lastActiveAt ?? this.lastActiveAt,
        portfolioTitle: portfolioTitle ?? this.portfolioTitle,
        profilePicture: profilePicture ?? this.profilePicture,
        totalFollowers: totalFollowers ?? this.totalFollowers,
        portfolioStatus: portfolioStatus ?? this.portfolioStatus,
        totalFollowings: totalFollowings ?? this.totalFollowings,
        totalPostLikes: totalPostLikes ?? this.totalPostLikes,
        portfolioCreatedAt: portfolioCreatedAt ?? this.portfolioCreatedAt,
        portfolioDescription: portfolioDescription ?? this.portfolioDescription,
        userLastLatLongWkb: userLastLatLongWkb ?? this.userLastLatLongWkb,
      );

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        bio: json["bio"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        uid: json["uid"],
        name: json["name"],
        gender: json["gender"],
        address: json["address"],
        isSpam: json["is_spam"],
        emailId: json["email_id"],
        username: json["username"],
        isActive: json["is_active"],
        isBanned: json["is_banned"],
        isOnline: json["is_online"],
        isPortfolio: json["is_portfolio"],
        mobileNumber: json["mobile_number"],
        registeredOn: json["registered_on"] == null
            ? null
            : DateTime.parse(json["registered_on"]),
        isDeactivated: json["is_deactivated"],
        lastActiveAt: json["last_active_at"] == null
            ? null
            : DateTime.parse(json["last_active_at"]),
        portfolioTitle: json["portfolio_title"],
        profilePicture: json["profile_picture"],
        totalFollowers: json["total_followers"],
        portfolioStatus: json["portfolio_status"],
        totalFollowings: json["total_followings"],
        totalPostLikes: json["total_post_likes"],
        portfolioCreatedAt: json["portfolio_created_at"] == null
            ? null
            : DateTime.parse(json["portfolio_created_at"]),
        portfolioDescription: json["portfolio_description"],
        userLastLatLongWkb: json["user_last_lat_long_wkb"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "bio": bio,
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "uid": uid,
        "name": name,
        "gender": gender,
        "address": address,
        "is_spam": isSpam,
        "email_id": emailId,
        "username": username,
        "is_active": isActive,
        "is_banned": isBanned,
        "is_online": isOnline,
        "is_portfolio": isPortfolio,
        "mobile_number": mobileNumber,
        "registered_on": registeredOn?.toIso8601String(),
        "is_deactivated": isDeactivated,
        "last_active_at": lastActiveAt?.toIso8601String(),
        "portfolio_title": portfolioTitle,
        "profile_picture": profilePicture,
        "total_followers": totalFollowers,
        "portfolio_status": portfolioStatus,
        "total_followings": totalFollowings,
        "total_post_likes": totalPostLikes,
        "portfolio_created_at": portfolioCreatedAt?.toIso8601String(),
        "portfolio_description": portfolioDescription,
        "user_last_lat_long_wkb": userLastLatLongWkb,
      };
}
