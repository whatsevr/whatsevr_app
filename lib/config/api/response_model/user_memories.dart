import 'dart:convert';

class UserMemoriesResponse {
  final String? message;
  final int? page;
  final bool? lastPage;
  final List<Memory>? memories;

  UserMemoriesResponse({
    this.message,
    this.page,
    this.lastPage,
    this.memories,
  });

  UserMemoriesResponse copyWith({
    String? message,
    int? page,
    bool? lastPage,
    List<Memory>? memories,
  }) =>
      UserMemoriesResponse(
        message: message ?? this.message,
        page: page ?? this.page,
        lastPage: lastPage ?? this.lastPage,
        memories: memories ?? this.memories,
      );

  factory UserMemoriesResponse.fromJson(String str) =>
      UserMemoriesResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserMemoriesResponse.fromMap(Map<String, dynamic> json) =>
      UserMemoriesResponse(
        message: json['message'],
        page: json['page'],
        lastPage: json['last_page'],
        memories: json['memories'] == null
            ? []
            : List<Memory>.from(
                json['memories']!.map((x) => Memory.fromMap(x)),
              ),
      );

  Map<String, dynamic> toMap() => {
        'message': message,
        'page': page,
        'last_page': lastPage,
        'memories': memories == null
            ? []
            : List<dynamic>.from(memories!.map((x) => x.toMap())),
      };
}

class Memory {
  final int? id;
  final DateTime? createdAt;
  final String? uid;
  final String? caption;
  final List<dynamic>? hashtags;
  final List<String>? taggedUserUids;
  final bool? isDeleted;
  final bool? isArchived;
  final bool? isActive;
  final String? postCreatorType;
  final DateTime? expiresAt;
  final String? userUid;
  final String? imageUrl;
  final String? videoUrl;
  final bool? isVideo;
  final String? location;
  final int? totalViews;
  final int? totalLikes;
  final int? totalComments;
  final String? internalAiDescription;
  final String? addressLatLongWkb;
  final String? creatorLatLongWkb;
  final List<dynamic>? taggedCommunityUids;
  final int? totalShares;
  final int? cumulativeScore;
  final String? ctaAction;
  final String? ctaActionUrl;
  final bool? isImage;
  final dynamic isText;
  final int? videoDurationMs;

  Memory({
    this.id,
    this.createdAt,
    this.uid,
    this.caption,
    this.hashtags,
    this.taggedUserUids,
    this.isDeleted,
    this.isArchived,
    this.isActive,
    this.postCreatorType,
    this.expiresAt,
    this.userUid,
    this.imageUrl,
    this.videoUrl,
    this.isVideo,
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
    this.ctaAction,
    this.ctaActionUrl,
    this.isImage,
    this.isText,
    this.videoDurationMs,
  });

  Memory copyWith({
    int? id,
    DateTime? createdAt,
    String? uid,
    String? caption,
    List<dynamic>? hashtags,
    List<String>? taggedUserUids,
    bool? isDeleted,
    bool? isArchived,
    bool? isActive,
    String? postCreatorType,
    DateTime? expiresAt,
    String? userUid,
    String? imageUrl,
    String? videoUrl,
    bool? isVideo,
    String? location,
    int? totalViews,
    int? totalLikes,
    int? totalComments,
    String? internalAiDescription,
    String? addressLatLongWkb,
    String? creatorLatLongWkb,
    List<dynamic>? taggedCommunityUids,
    int? totalShares,
    int? cumulativeScore,
    String? ctaAction,
    String? ctaActionUrl,
    bool? isImage,
    dynamic isText,
    int? videoDurationMs,
  }) =>
      Memory(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        uid: uid ?? this.uid,
        caption: caption ?? this.caption,
        hashtags: hashtags ?? this.hashtags,
        taggedUserUids: taggedUserUids ?? this.taggedUserUids,
        isDeleted: isDeleted ?? this.isDeleted,
        isArchived: isArchived ?? this.isArchived,
        isActive: isActive ?? this.isActive,
        postCreatorType: postCreatorType ?? this.postCreatorType,
        expiresAt: expiresAt ?? this.expiresAt,
        userUid: userUid ?? this.userUid,
        imageUrl: imageUrl ?? this.imageUrl,
        videoUrl: videoUrl ?? this.videoUrl,
        isVideo: isVideo ?? this.isVideo,
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
        ctaAction: ctaAction ?? this.ctaAction,
        ctaActionUrl: ctaActionUrl ?? this.ctaActionUrl,
        isImage: isImage ?? this.isImage,
        isText: isText ?? this.isText,
        videoDurationMs: videoDurationMs ?? this.videoDurationMs,
      );

  factory Memory.fromJson(String str) => Memory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Memory.fromMap(Map<String, dynamic> json) => Memory(
        id: json['id'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        uid: json['uid'],
        caption: json['caption'],
        hashtags: json['hashtags'] == null
            ? []
            : List<dynamic>.from(json['hashtags']!.map((x) => x)),
        taggedUserUids: json['tagged_user_uids'] == null
            ? []
            : List<String>.from(json['tagged_user_uids']!.map((x) => x)),
        isDeleted: json['is_deleted'],
        isArchived: json['is_archived'],
        isActive: json['is_active'],
        postCreatorType: json['post_creator_type'],
        expiresAt: json['expires_at'] == null
            ? null
            : DateTime.parse(json['expires_at']),
        userUid: json['user_uid'],
        imageUrl: json['image_url'],
        videoUrl: json['video_url'],
        isVideo: json['is_video'],
        location: json['location'],
        totalViews: json['total_views'],
        totalLikes: json['total_likes'],
        totalComments: json['total_comments'],
        internalAiDescription: json['internal_ai_description'],
        addressLatLongWkb: json['address_lat_long_wkb'],
        creatorLatLongWkb: json['creator_lat_long_wkb'],
        taggedCommunityUids: json['tagged_community_uids'] == null
            ? []
            : List<dynamic>.from(json['tagged_community_uids']!.map((x) => x)),
        totalShares: json['total_shares'],
        cumulativeScore: json['cumulative_score'],
        ctaAction: json['cta_action'],
        ctaActionUrl: json['cta_action_url'],
        isImage: json['is_image'],
        isText: json['is_text'],
        videoDurationMs: json['video_duration_ms'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'created_at': createdAt?.toIso8601String(),
        'uid': uid,
        'caption': caption,
        'hashtags':
            hashtags == null ? [] : List<dynamic>.from(hashtags!.map((x) => x)),
        'tagged_user_uids': taggedUserUids == null
            ? []
            : List<dynamic>.from(taggedUserUids!.map((x) => x)),
        'is_deleted': isDeleted,
        'is_archived': isArchived,
        'is_active': isActive,
        'post_creator_type': postCreatorType,
        'expires_at': expiresAt?.toIso8601String(),
        'user_uid': userUid,
        'image_url': imageUrl,
        'video_url': videoUrl,
        'is_video': isVideo,
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
        'cta_action': ctaAction,
        'cta_action_url': ctaActionUrl,
        'is_image': isImage,
        'is_text': isText,
        'video_duration_ms': videoDurationMs,
      };
}
