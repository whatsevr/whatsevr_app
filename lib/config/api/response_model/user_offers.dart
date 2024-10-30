import 'dart:convert';

class UserOffersResponse {
  final String? message;
  final int? page;
  final bool? lastPage;
  final List<OfferPost>? offerPosts;

  UserOffersResponse({
    this.message,
    this.page,
    this.lastPage,
    this.offerPosts,
  });

  UserOffersResponse copyWith({
    String? message,
    int? page,
    bool? lastPage,
    List<OfferPost>? offerPosts,
  }) =>
      UserOffersResponse(
        message: message ?? this.message,
        page: page ?? this.page,
        lastPage: lastPage ?? this.lastPage,
        offerPosts: offerPosts ?? this.offerPosts,
      );

  factory UserOffersResponse.fromJson(String str) =>
      UserOffersResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserOffersResponse.fromMap(Map<String, dynamic> json) =>
      UserOffersResponse(
        message: json['message'],
        page: json['page'],
        lastPage: json['last_page'],
        offerPosts: json['offer_posts'] == null
            ? []
            : List<OfferPost>.from(
                json['offer_posts']!.map((x) => OfferPost.fromMap(x)),),
      );

  Map<String, dynamic> toMap() => {
        'message': message,
        'page': page,
        'last_page': lastPage,
        'offer_posts': offerPosts == null
            ? []
            : List<dynamic>.from(offerPosts!.map((x) => x.toMap())),
      };
}

class OfferPost {
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
  final String? userUid;
  final int? totalImpressions;
  final int? totalLikes;
  final int? totalComments;
  final String? internalAiDescription;
  final String? creatorLatLongWkb;
  final List<String>? taggedCommunityUids;
  final int? totalShares;
  final int? cumulativeScore;
  final String? ctaAction;
  final String? ctaActionUrl;
  final List<FilesDatum>? filesData;
  final String? status;
  final String? targetGender;
  final List<String>? targetAreas;

  OfferPost({
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
    this.userUid,
    this.totalImpressions,
    this.totalLikes,
    this.totalComments,
    this.internalAiDescription,
    this.creatorLatLongWkb,
    this.taggedCommunityUids,
    this.totalShares,
    this.cumulativeScore,
    this.ctaAction,
    this.ctaActionUrl,
    this.filesData,
    this.status,
    this.targetGender,
    this.targetAreas,
  });

  OfferPost copyWith({
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
    String? userUid,
    int? totalImpressions,
    int? totalLikes,
    int? totalComments,
    String? internalAiDescription,
    String? creatorLatLongWkb,
    List<String>? taggedCommunityUids,
    int? totalShares,
    int? cumulativeScore,
    String? ctaAction,
    String? ctaActionUrl,
    List<FilesDatum>? filesData,
    String? status,
    String? targetGender,
    List<String>? targetAreas,
  }) =>
      OfferPost(
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
        userUid: userUid ?? this.userUid,
        totalImpressions: totalImpressions ?? this.totalImpressions,
        totalLikes: totalLikes ?? this.totalLikes,
        totalComments: totalComments ?? this.totalComments,
        internalAiDescription:
            internalAiDescription ?? this.internalAiDescription,
        creatorLatLongWkb: creatorLatLongWkb ?? this.creatorLatLongWkb,
        taggedCommunityUids: taggedCommunityUids ?? this.taggedCommunityUids,
        totalShares: totalShares ?? this.totalShares,
        cumulativeScore: cumulativeScore ?? this.cumulativeScore,
        ctaAction: ctaAction ?? this.ctaAction,
        ctaActionUrl: ctaActionUrl ?? this.ctaActionUrl,
        filesData: filesData ?? this.filesData,
        status: status ?? this.status,
        targetGender: targetGender ?? this.targetGender,
        targetAreas: targetAreas ?? this.targetAreas,
      );

  factory OfferPost.fromJson(String str) => OfferPost.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OfferPost.fromMap(Map<String, dynamic> json) => OfferPost(
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
        userUid: json['user_uid'],
        totalImpressions: json['total_impressions'],
        totalLikes: json['total_likes'],
        totalComments: json['total_comments'],
        internalAiDescription: json['internal_ai_description'],
        creatorLatLongWkb: json['creator_lat_long_wkb'],
        taggedCommunityUids: json['tagged_community_uids'] == null
            ? []
            : List<String>.from(json['tagged_community_uids']!.map((x) => x)),
        totalShares: json['total_shares'],
        cumulativeScore: json['cumulative_score'],
        ctaAction: json['cta_action'],
        ctaActionUrl: json['cta_action_url'],
        filesData: json['files_data'] == null
            ? []
            : List<FilesDatum>.from(
                json['files_data']!.map((x) => FilesDatum.fromMap(x)),),
        status: json['status'],
        targetGender: json['target_gender'],
        targetAreas: json['target_areas'] == null
            ? []
            : List<String>.from(json['target_areas']!.map((x) => x)),
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
        'user_uid': userUid,
        'total_impressions': totalImpressions,
        'total_likes': totalLikes,
        'total_comments': totalComments,
        'internal_ai_description': internalAiDescription,
        'creator_lat_long_wkb': creatorLatLongWkb,
        'tagged_community_uids': taggedCommunityUids == null
            ? []
            : List<dynamic>.from(taggedCommunityUids!.map((x) => x)),
        'total_shares': totalShares,
        'cumulative_score': cumulativeScore,
        'cta_action': ctaAction,
        'cta_action_url': ctaActionUrl,
        'files_data': filesData == null
            ? []
            : List<dynamic>.from(filesData!.map((x) => x.toMap())),
        'status': status,
        'target_gender': targetGender,
        'target_areas': targetAreas == null
            ? []
            : List<dynamic>.from(targetAreas!.map((x) => x)),
      };
}

class FilesDatum {
  final String? type;
  final String? videoUrl;
  final int? videoDurationMs;
  final String? videoThumbnailUrl;
  final String? imageUrl;

  FilesDatum({
    this.type,
    this.videoUrl,
    this.videoDurationMs,
    this.videoThumbnailUrl,
    this.imageUrl,
  });

  FilesDatum copyWith({
    String? type,
    String? videoUrl,
    int? videoDurationMs,
    String? videoThumbnailUrl,
    String? imageUrl,
  }) =>
      FilesDatum(
        type: type ?? this.type,
        videoUrl: videoUrl ?? this.videoUrl,
        videoDurationMs: videoDurationMs ?? this.videoDurationMs,
        videoThumbnailUrl: videoThumbnailUrl ?? this.videoThumbnailUrl,
        imageUrl: imageUrl ?? this.imageUrl,
      );

  factory FilesDatum.fromJson(String str) =>
      FilesDatum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FilesDatum.fromMap(Map<String, dynamic> json) => FilesDatum(
        type: json['type'],
        videoUrl: json['video_url'],
        videoDurationMs: json['video_duration_ms'],
        videoThumbnailUrl: json['video_thumbnail_url'],
        imageUrl: json['image_url'],
      );

  Map<String, dynamic> toMap() => {
        'type': type,
        'video_url': videoUrl,
        'video_duration_ms': videoDurationMs,
        'video_thumbnail_url': videoThumbnailUrl,
        'image_url': imageUrl,
      };
}
