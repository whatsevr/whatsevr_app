import 'dart:convert';

class RecommendationVideosResponse {
  final String? message;
  final List<RecommendedVideo>? recommendedVideos;

  RecommendationVideosResponse({
    this.message,
    this.recommendedVideos,
  });

  factory RecommendationVideosResponse.fromJson(String str) =>
      RecommendationVideosResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RecommendationVideosResponse.fromMap(Map<String, dynamic> json) =>
      RecommendationVideosResponse(
        message: json["message"],
        recommendedVideos: json["recommended_videos"] == null
            ? []
            : List<RecommendedVideo>.from(json["recommended_videos"]!
                .map((x) => RecommendedVideo.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
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
  final List<String>? taggedUsersUid;
  final List<String>? taggedPortfolios;
  final List<String>? taggedCommunitiesUid;
  final int? likesCount;
  final bool? isDeleted;
  final bool? isArchived;
  final bool? isActive;
  final String? postCreatorType;
  final DateTime? updatedAt;
  final String? userUid;
  final String? thumbnail;
  final String? videoUrl;
  final String? location;
  final String? locationLatitude;
  final String? locationLongitude;
  final User? user;

  RecommendedVideo({
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
    this.user,
  });

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
        taggedUsersUid: json["tagged_users_uid"] == null
            ? []
            : List<String>.from(json["tagged_users_uid"]!.map((x) => x)),
        taggedPortfolios: json["tagged_portfolios"] == null
            ? []
            : List<String>.from(json["tagged_portfolios"]!.map((x) => x)),
        taggedCommunitiesUid: json["tagged_communities_uid"] == null
            ? []
            : List<String>.from(json["tagged_communities_uid"]!.map((x) => x)),
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
        "tagged_users_uid": taggedUsersUid == null
            ? []
            : List<dynamic>.from(taggedUsersUid!.map((x) => x)),
        "tagged_portfolios": taggedPortfolios == null
            ? []
            : List<dynamic>.from(taggedPortfolios!.map((x) => x)),
        "tagged_communities_uid": taggedCommunitiesUid == null
            ? []
            : List<dynamic>.from(taggedCommunitiesUid!.map((x) => x)),
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
        "user": user?.toMap(),
      };
}

class User {
  final int? id;
  final String? bio;
  final String? dob;
  final String? uid;
  final String? name;
  final String? address;
  final bool? isSpam;
  final String? emailId;
  final bool? isActive;
  final bool? isBanned;
  final String? userName;
  final bool? isPortfolio;
  final String? mobileNumber;
  final DateTime? registeredOn;
  final bool? isDiactivated;
  final String? profilePicture;
  final String? portfolioStatus;
  final List<String>? portfolioServices;
  final DateTime? portfolioCreatedAt;
  final String? portfolioDescription;

  User({
    this.id,
    this.bio,
    this.dob,
    this.uid,
    this.name,
    this.address,
    this.isSpam,
    this.emailId,
    this.isActive,
    this.isBanned,
    this.userName,
    this.isPortfolio,
    this.mobileNumber,
    this.registeredOn,
    this.isDiactivated,
    this.profilePicture,
    this.portfolioStatus,
    this.portfolioServices,
    this.portfolioCreatedAt,
    this.portfolioDescription,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        bio: json["bio"],
        dob: json["dob"],
        uid: json["uid"],
        name: json["name"],
        address: json["address"],
        isSpam: json["is_spam"],
        emailId: json["email_id"],
        isActive: json["is_active"],
        isBanned: json["is_banned"],
        userName: json["user_name"],
        isPortfolio: json["is_portfolio"],
        mobileNumber: json["mobile_number"],
        registeredOn: json["registered_on"] == null
            ? null
            : DateTime.parse(json["registered_on"]),
        isDiactivated: json["is_diactivated"],
        profilePicture: json["profile_picture"],
        portfolioStatus: json["portfolio_status"],
        portfolioServices: json["portfolio_services"] == null
            ? []
            : List<String>.from(json["portfolio_services"]!.map((x) => x)),
        portfolioCreatedAt: json["portfolio_created_at"] == null
            ? null
            : DateTime.parse(json["portfolio_created_at"]),
        portfolioDescription: json["portfolio_description"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "bio": bio,
        "dob": dob,
        "uid": uid,
        "name": name,
        "address": address,
        "is_spam": isSpam,
        "email_id": emailId,
        "is_active": isActive,
        "is_banned": isBanned,
        "user_name": userName,
        "is_portfolio": isPortfolio,
        "mobile_number": mobileNumber,
        "registered_on": registeredOn?.toIso8601String(),
        "is_diactivated": isDiactivated,
        "profile_picture": profilePicture,
        "portfolio_status": portfolioStatus,
        "portfolio_services": portfolioServices == null
            ? []
            : List<dynamic>.from(portfolioServices!.map((x) => x)),
        "portfolio_created_at": portfolioCreatedAt?.toIso8601String(),
        "portfolio_description": portfolioDescription,
      };
}
