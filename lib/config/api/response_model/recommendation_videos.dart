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
            ? <String>[]
            : List<dynamic>.from(
                recommendedVideos!.map((RecommendedVideo x) => x.toMap())),
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
        taggedUsersUid: json['tagged_users_uid'] == null
            ? <String>[]
            : List<String>.from(json['tagged_users_uid']!.map((x) => x)),
        taggedPortfolios: json['tagged_portfolios'] == null
            ? <String>[]
            : List<String>.from(json['tagged_portfolios']!.map((x) => x)),
        taggedCommunitiesUid: json['tagged_communities_uid'] == null
            ? <String>[]
            : List<String>.from(json['tagged_communities_uid']!.map((x) => x)),
        likesCount: json['likes_count'],
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
        user: json['user'] == null ? null : User.fromMap(json['user']),
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'created_at': createdAt?.toIso8601String(),
        'uid': uid,
        'title': title,
        'description': description,
        'hashtags': hashtags == null
            ? <String>[]
            : List<dynamic>.from(hashtags!.map((String x) => x)),
        'tagged_users_uid': taggedUsersUid == null
            ? <String>[]
            : List<dynamic>.from(taggedUsersUid!.map((String x) => x)),
        'tagged_portfolios': taggedPortfolios == null
            ? <String>[]
            : List<dynamic>.from(taggedPortfolios!.map((String x) => x)),
        'tagged_communities_uid': taggedCommunitiesUid == null
            ? <String>[]
            : List<dynamic>.from(taggedCommunitiesUid!.map((String x) => x)),
        'likes_count': likesCount,
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
        'user': user?.toMap(),
      };
}

class User {
  final int? id;
  final String? bio;
  final String? dob;
  final String? uid;
  final String? address;
  final String? emailId;
  final String? fullName;
  final bool? isActive;
  final String? userName;
  final DateTime? createdAt;
  final String? mobileNumber;
  final String? profilePicture;

  User({
    this.id,
    this.bio,
    this.dob,
    this.uid,
    this.address,
    this.emailId,
    this.fullName,
    this.isActive,
    this.userName,
    this.createdAt,
    this.mobileNumber,
    this.profilePicture,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json['id'],
        bio: json['bio'],
        dob: json['dob'],
        uid: json['uid'],
        address: json['address'],
        emailId: json['email_id'],
        fullName: json['full_name'],
        isActive: json['is_active'],
        userName: json['user_name'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        mobileNumber: json['mobile_number'],
        profilePicture: json['profile_picture'],
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'bio': bio,
        'dob': dob,
        'uid': uid,
        'address': address,
        'email_id': emailId,
        'full_name': fullName,
        'is_active': isActive,
        'user_name': userName,
        'created_at': createdAt?.toIso8601String(),
        'mobile_number': mobileNumber,
        'profile_picture': profilePicture,
      };
}
