import 'dart:convert';

class ProfileDetailsResponse {
  final String? message;
  final UserInfo? userInfo;
  final List<UserVideoPost>? userVideoPosts;

  ProfileDetailsResponse({
    this.message,
    this.userInfo,
    this.userVideoPosts,
  });

  factory ProfileDetailsResponse.fromJson(String str) =>
      ProfileDetailsResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProfileDetailsResponse.fromMap(Map<String, dynamic> json) =>
      ProfileDetailsResponse(
        message: json["message"],
        userInfo: json["user_info"] == null
            ? null
            : UserInfo.fromMap(json["user_info"]),
        userVideoPosts: json["user_video_posts"] == null
            ? []
            : List<UserVideoPost>.from(
                json["user_video_posts"]!.map((x) => UserVideoPost.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "user_info": userInfo?.toMap(),
        "user_video_posts": userVideoPosts == null
            ? []
            : List<dynamic>.from(userVideoPosts!.map((x) => x.toMap())),
      };
}

class UserInfo {
  final int? id;
  final DateTime? registeredOn;
  final bool? isActive;
  final String? uid;
  final String? userName;
  final String? mobileNumber;
  final String? emailId;
  final String? name;
  final String? bio;
  final String? address;
  final DateTime? dob;
  final String? profilePicture;
  final bool? isPortfolio;
  final String? portfolioStatus;
  final String? portfolioDescription;
  final bool? isBanned;
  final bool? isSpam;
  final bool? isDiactivated;
  final DateTime? portfolioCreatedAt;
  final String? portfolioTitle;

  UserInfo({
    this.id,
    this.registeredOn,
    this.isActive,
    this.uid,
    this.userName,
    this.mobileNumber,
    this.emailId,
    this.name,
    this.bio,
    this.address,
    this.dob,
    this.profilePicture,
    this.isPortfolio,
    this.portfolioStatus,
    this.portfolioDescription,
    this.isBanned,
    this.isSpam,
    this.isDiactivated,
    this.portfolioCreatedAt,
    this.portfolioTitle,
  });

  factory UserInfo.fromJson(String str) => UserInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserInfo.fromMap(Map<String, dynamic> json) => UserInfo(
        id: json["id"],
        registeredOn: json["registered_on"] == null
            ? null
            : DateTime.parse(json["registered_on"]),
        isActive: json["is_active"],
        uid: json["uid"],
        userName: json["user_name"],
        mobileNumber: json["mobile_number"],
        emailId: json["email_id"],
        name: json["name"],
        bio: json["bio"],
        address: json["address"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        profilePicture: json["profile_picture"],
        isPortfolio: json["is_portfolio"],
        portfolioStatus: json["portfolio_status"],
        portfolioDescription: json["portfolio_description"],
        isBanned: json["is_banned"],
        isSpam: json["is_spam"],
        isDiactivated: json["is_diactivated"],
        portfolioCreatedAt: json["portfolio_created_at"] == null
            ? null
            : DateTime.parse(json["portfolio_created_at"]),
        portfolioTitle: json["portfolio_title"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "registered_on": registeredOn?.toIso8601String(),
        "is_active": isActive,
        "uid": uid,
        "user_name": userName,
        "mobile_number": mobileNumber,
        "email_id": emailId,
        "name": name,
        "bio": bio,
        "address": address,
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "profile_picture": profilePicture,
        "is_portfolio": isPortfolio,
        "portfolio_status": portfolioStatus,
        "portfolio_description": portfolioDescription,
        "is_banned": isBanned,
        "is_spam": isSpam,
        "is_diactivated": isDiactivated,
        "portfolio_created_at": portfolioCreatedAt?.toIso8601String(),
        "portfolio_title": portfolioTitle,
      };
}

class UserVideoPost {
  final int? id;
  final DateTime? createdAt;
  final String? uid;
  final String? title;
  final String? description;
  final List<String>? hashtags;
  final dynamic taggedUsersUid;
  final dynamic taggedPortfolios;
  final dynamic taggedCommunitiesUid;
  final dynamic likesCount;
  final bool? isDeleted;
  final bool? isArchived;
  final bool? isActive;
  final String? postCreatorType;
  final DateTime? updatedAt;
  final String? userUid;
  final String? thumbnail;
  final String? videoUrl;
  final String? location;
  final dynamic locationLatitude;
  final dynamic locationLongitude;

  UserVideoPost({
    this.id,
    this.createdAt,
    this.uid,
    this.title,
    this.description,
    this.hashtags,
    this.taggedUsersUid,
    this.taggedPortfolios,
    this.taggedCommunitiesUid,
    this.likesCount,
    this.isDeleted,
    this.isArchived,
    this.isActive,
    this.postCreatorType,
    this.updatedAt,
    this.userUid,
    this.thumbnail,
    this.videoUrl,
    this.location,
    this.locationLatitude,
    this.locationLongitude,
  });

  factory UserVideoPost.fromJson(String str) =>
      UserVideoPost.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserVideoPost.fromMap(Map<String, dynamic> json) => UserVideoPost(
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
        taggedUsersUid: json["tagged_users_uid"],
        taggedPortfolios: json["tagged_portfolios"],
        taggedCommunitiesUid: json["tagged_communities_uid"],
        likesCount: json["likes_count"],
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
        locationLatitude: json["location_latitude"],
        locationLongitude: json["location_longitude"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "uid": uid,
        "title": title,
        "description": description,
        "hashtags":
            hashtags == null ? [] : List<dynamic>.from(hashtags!.map((x) => x)),
        "tagged_users_uid": taggedUsersUid,
        "tagged_portfolios": taggedPortfolios,
        "tagged_communities_uid": taggedCommunitiesUid,
        "likes_count": likesCount,
        "is_deleted": isDeleted,
        "is_archived": isArchived,
        "is_active": isActive,
        "post_creator_type": postCreatorType,
        "updated_at": updatedAt?.toIso8601String(),
        "user_uid": userUid,
        "thumbnail": thumbnail,
        "video_url": videoUrl,
        "location": location,
        "location_latitude": locationLatitude,
        "location_longitude": locationLongitude,
      };
}
