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
        message: json['message'],
        recommendedVideos: json['recommended_videos'] == null
            ? <RecommendedVideo>[]
            : List<RecommendedVideo>.from(
                json['recommended_videos']!
                    .map((x) => RecommendedVideo.fromMap(x)),
              ),
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'message': message,
        'recommended_videos': recommendedVideos == null
            ? <dynamic>[]
            : List<dynamic>.from(
                recommendedVideos!.map((RecommendedVideo x) => x.toMap()),),
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
  final dynamic locationLatitude;
  final dynamic locationLongitude;
  final String? videoDuration;
  final int? totalViews;
  final int? totalLikes;
  final int? totalComments;
  final dynamic internalAiPostDescription;
  final dynamic internalAiPostTags;
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
    this.locationLatitude,
    this.locationLongitude,
    this.videoDuration,
    this.totalViews,
    this.totalLikes,
    this.totalComments,
    this.internalAiPostDescription,
    this.internalAiPostTags,
    this.user,
  });

  factory RecommendedVideo.fromJson(String str) =>
      RecommendedVideo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RecommendedVideo.fromMap(Map<String, dynamic> json) =>
      RecommendedVideo(
        id: json['id'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        uid: json['uid'],
        title: json['title'],
        description: json['description'],
        hashtags: json['hashtags'] == null
            ? <String>[]
            : List<String>.from(json['hashtags']!.map((x) => x)),
        taggedUserUids: json['tagged_user_uids'] == null
            ? <String>[]
            : List<String>.from(json['tagged_user_uids']!.map((x) => x)),
        isDeleted: json['is_deleted'],
        isArchived: json['is_archived'],
        isActive: json['is_active'],
        postCreatorType: json['post_creator_type'],
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at']),
        userUid: json['user_uid'],
        thumbnail: json['thumbnail'],
        videoUrl: json['video_url'],
        location: json['location'],
        locationLatitude: json['location_latitude'],
        locationLongitude: json['location_longitude'],
        videoDuration: json['video_duration'],
        totalViews: json['total_views'],
        totalLikes: json['total_likes'],
        totalComments: json['total_comments'],
        internalAiPostDescription: json['internal_ai_post_description'],
        internalAiPostTags: json['internal_ai_post_tags'],
        user: json['user'] == null ? null : User.fromMap(json['user']),
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'created_at': createdAt?.toIso8601String(),
        'uid': uid,
        'title': title,
        'description': description,
        'hashtags': hashtags == null
            ? <dynamic>[]
            : List<dynamic>.from(hashtags!.map((String x) => x)),
        'tagged_user_uids': taggedUserUids == null
            ? <dynamic>[]
            : List<dynamic>.from(taggedUserUids!.map((String x) => x)),
        'is_deleted': isDeleted,
        'is_archived': isArchived,
        'is_active': isActive,
        'post_creator_type': postCreatorType,
        'updated_at': updatedAt?.toIso8601String(),
        'user_uid': userUid,
        'thumbnail': thumbnail,
        'video_url': videoUrl,
        'location': location,
        'location_latitude': locationLatitude,
        'location_longitude': locationLongitude,
        'video_duration': videoDuration,
        'total_views': totalViews,
        'total_likes': totalLikes,
        'total_comments': totalComments,
        'internal_ai_post_description': internalAiPostDescription,
        'internal_ai_post_tags': internalAiPostTags,
        'user': user?.toMap(),
      };
}

class User {
  final int? id;
  final String? bio;
  final DateTime? dob;
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
  final String? portfolioTitle;
  final String? profilePicture;
  final int? totalFollowers;
  final String? portfolioStatus;
  final int? totalFollowings;
  final int? totalPostLikes;
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
    this.portfolioTitle,
    this.profilePicture,
    this.totalFollowers,
    this.portfolioStatus,
    this.totalFollowings,
    this.totalPostLikes,
    this.portfolioCreatedAt,
    this.portfolioDescription,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json['id'],
        bio: json['bio'],
        dob: json['dob'] == null ? null : DateTime.parse(json['dob']),
        uid: json['uid'],
        name: json['name'],
        address: json['address'],
        isSpam: json['is_spam'],
        emailId: json['email_id'],
        isActive: json['is_active'],
        isBanned: json['is_banned'],
        userName: json['user_name'],
        isPortfolio: json['is_portfolio'],
        mobileNumber: json['mobile_number'],
        registeredOn: json['registered_on'] == null
            ? null
            : DateTime.parse(json['registered_on']),
        isDiactivated: json['is_diactivated'],
        portfolioTitle: json['portfolio_title'],
        profilePicture: json['profile_picture'],
        totalFollowers: json['total_followers'],
        portfolioStatus: json['portfolio_status'],
        totalFollowings: json['total_followings'],
        totalPostLikes: json['total_post_likes'],
        portfolioCreatedAt: json['portfolio_created_at'] == null
            ? null
            : DateTime.parse(json['portfolio_created_at']),
        portfolioDescription: json['portfolio_description'],
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'bio': bio,
        'dob':
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        'uid': uid,
        'name': name,
        'address': address,
        'is_spam': isSpam,
        'email_id': emailId,
        'is_active': isActive,
        'is_banned': isBanned,
        'user_name': userName,
        'is_portfolio': isPortfolio,
        'mobile_number': mobileNumber,
        'registered_on': registeredOn?.toIso8601String(),
        'is_diactivated': isDiactivated,
        'portfolio_title': portfolioTitle,
        'profile_picture': profilePicture,
        'total_followers': totalFollowers,
        'portfolio_status': portfolioStatus,
        'total_followings': totalFollowings,
        'total_post_likes': totalPostLikes,
        'portfolio_created_at': portfolioCreatedAt?.toIso8601String(),
        'portfolio_description': portfolioDescription,
      };
}
