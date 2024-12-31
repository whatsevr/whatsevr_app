import 'dart:convert';

class UserAndCommunityVideoPostsResponse {
  final String? message;
  final int? page;
  final bool? lastPage;
  final List<VideoPost>? videoPosts;

  UserAndCommunityVideoPostsResponse({
    this.message,
    this.page,
    this.lastPage,
    this.videoPosts,
  });

  UserAndCommunityVideoPostsResponse copyWith({
    String? message,
    int? page,
    bool? lastPage,
    List<VideoPost>? videoPosts,
  }) =>
      UserAndCommunityVideoPostsResponse(
        message: message ?? this.message,
        page: page ?? this.page,
        lastPage: lastPage ?? this.lastPage,
        videoPosts: videoPosts ?? this.videoPosts,
      );

  factory UserAndCommunityVideoPostsResponse.fromJson(String str) =>
      UserAndCommunityVideoPostsResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserAndCommunityVideoPostsResponse.fromMap(
          Map<String, dynamic> json) =>
      UserAndCommunityVideoPostsResponse(
        message: json['message'],
        page: json['page'],
        lastPage: json['last_page'],
        videoPosts: json['video_posts'] == null
            ? []
            : List<VideoPost>.from(
                json['video_posts']!.map((x) => VideoPost.fromMap(x)),
              ),
      );

  Map<String, dynamic> toMap() => {
        'message': message,
        'page': page,
        'last_page': lastPage,
        'video_posts': videoPosts == null
            ? []
            : List<dynamic>.from(videoPosts!.map((x) => x.toMap())),
      };
}

class VideoPost {
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

  VideoPost({
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
  });

  VideoPost copyWith({
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
    int? videoDurationInSec,
  }) =>
      VideoPost(
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
      );

  factory VideoPost.fromJson(String str) => VideoPost.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoPost.fromMap(Map<String, dynamic> json) => VideoPost(
        id: json['id'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        uid: json['uid'],
        title: json['title'],
        description: json['description'],
        hashtags: json['hashtags'] == null
            ? []
            : List<String>.from(json['hashtags']!.map((x) => x)),
        taggedUserUids: json['tagged_user_uids'] == null
            ? []
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
        totalViews: json['total_views'],
        totalLikes: json['total_likes'],
        totalComments: json['total_comments'],
        internalAiDescription: json['internal_ai_description'],
        addressLatLongWkb: json['address_lat_long_wkb'],
        creatorLatLongWkb: json['creator_lat_long_wkb'],
        taggedCommunityUids: json['tagged_community_uids'] == null
            ? []
            : List<String>.from(json['tagged_community_uids']!.map((x) => x)),
        totalShares: json['total_shares'],
        cumulativeScore: json['cumulative_score'],
        videoDurationInSec: json['video_duration_in_sec'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'created_at': createdAt?.toIso8601String(),
        'uid': uid,
        'title': title,
        'description': description,
        'hashtags':
            hashtags == null ? [] : List<dynamic>.from(hashtags!.map((x) => x)),
        'tagged_user_uids': taggedUserUids == null
            ? []
            : List<dynamic>.from(taggedUserUids!.map((x) => x)),
        'is_deleted': isDeleted,
        'is_archived': isArchived,
        'is_active': isActive,
        'post_creator_type': postCreatorType,
        'updated_at': updatedAt?.toIso8601String(),
        'user_uid': userUid,
        'thumbnail': thumbnail,
        'video_url': videoUrl,
        'location': location,
        'total_views': totalViews,
        'total_likes': totalLikes,
        'total_comments': totalComments,
        'internal_ai_description': internalAiDescription,
        'address_lat_long_wkb': addressLatLongWkb,
        'creator_lat_long_wkb': creatorLatLongWkb,
        'tagged_community_uids': taggedCommunityUids == null
            ? []
            : List<dynamic>.from(taggedCommunityUids!.map((x) => x)),
        'total_shares': totalShares,
        'cumulative_score': cumulativeScore,
        'video_duration_in_sec': videoDurationInSec,
      };
}
