import 'dart:convert';

class CreateMemoryRequest {
  final String? caption;
  final DateTime? expiresAt;
  final String? userUid;
  final String? imageUrl;
  final String? videoUrl;
  final bool? isVideo;
  final String? ctaAction;
  final String? ctaActionUrl;

  final bool? isImage;
  final bool? isText;
  final String? location;
  final List<String>? hashtags;
  final String? postCreatorType;
  final String? addressLatLongWkb;
  final String? creatorLatLongWkb;
  final List<String>? taggedUserUids;
  final List<String>? taggedCommunityUids;
  final int? videoDurationMs;
  final String? communityUid;

  CreateMemoryRequest({
    this.caption,
    this.expiresAt,
    this.userUid,
    this.imageUrl,
    this.videoUrl,
    this.isVideo,
    this.ctaAction,
    this.ctaActionUrl,
    this.isImage,
    this.isText,
    this.location,
    this.hashtags,
    this.postCreatorType,
    this.addressLatLongWkb,
    this.creatorLatLongWkb,
    this.taggedUserUids,
    this.taggedCommunityUids,
    this.videoDurationMs,
    this.communityUid,
  });

  CreateMemoryRequest copyWith({
    String? caption,
    DateTime? expiresAt,
    String? userUid,
    String? imageUrl,
    String? videoUrl,
    bool? isVideo,
    String? ctaAction,
    String? ctaActionUrl,
    bool? isImage,
    bool? isText,
    String? location,
    List<String>? hashtags,
    String? postCreatorType,
    String? addressLatLongWkb,
    String? creatorLatLongWkb,
    List<String>? taggedUserUids,
    List<String>? taggedCommunityUids,
    int? videoDurationMs,
    String? communityUid,
  }) =>
      CreateMemoryRequest(
        caption: caption ?? this.caption,
        expiresAt: expiresAt ?? this.expiresAt,
        userUid: userUid ?? this.userUid,
        imageUrl: imageUrl ?? this.imageUrl,
        videoUrl: videoUrl ?? this.videoUrl,
        isVideo: isVideo ?? this.isVideo,
        ctaAction: ctaAction ?? this.ctaAction,
        ctaActionUrl: ctaActionUrl ?? this.ctaActionUrl,
        isImage: isImage ?? this.isImage,
        isText: isText ?? this.isText,
        location: location ?? this.location,
        hashtags: hashtags ?? this.hashtags,
        postCreatorType: postCreatorType ?? this.postCreatorType,
        addressLatLongWkb: addressLatLongWkb ?? this.addressLatLongWkb,
        creatorLatLongWkb: creatorLatLongWkb ?? this.creatorLatLongWkb,
        taggedUserUids: taggedUserUids ?? this.taggedUserUids,
        taggedCommunityUids: taggedCommunityUids ?? this.taggedCommunityUids,
        videoDurationMs: videoDurationMs ?? this.videoDurationMs,
        communityUid: communityUid ?? this.communityUid,
      );

  factory CreateMemoryRequest.fromJson(String str) =>
      CreateMemoryRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreateMemoryRequest.fromMap(Map<String, dynamic> json) =>
      CreateMemoryRequest(
        caption: json['caption'],
        expiresAt: json['expires_at'] == null
            ? null
            : DateTime.parse(json['expires_at']),
        userUid: json['user_uid'],
        imageUrl: json['image_url'],
        videoUrl: json['video_url'],
        isVideo: json['is_video'],
        ctaAction: json['cta_action'],
        ctaActionUrl: json['cta_action_url'],
        isImage: json['is_image'],
        isText: json['is_text'],
        location: json['location'],
        hashtags: json['hashtags'] == null
            ? []
            : List<String>.from(json['hashtags']!.map((x) => x)),
        postCreatorType: json['post_creator_type'],
        addressLatLongWkb: json['address_lat_long_wkb'],
        creatorLatLongWkb: json['creator_lat_long_wkb'],
        taggedUserUids: json['tagged_user_uids'] == null
            ? []
            : List<String>.from(json['tagged_user_uids']!.map((x) => x)),
        taggedCommunityUids: json['tagged_community_uids'] == null
            ? []
            : List<String>.from(json['tagged_community_uids']!.map((x) => x)),
        videoDurationMs: json['video_duration_ms'],
        communityUid: json['community_uid'],
      );

  Map<String, dynamic> toMap() => {
        'caption': caption,
        'expires_at': expiresAt?.toIso8601String(),
        'user_uid': userUid,
        'image_url': imageUrl,
        'video_url': videoUrl,
        'is_video': isVideo,
        'cta_action': ctaAction,
        'cta_action_url': ctaActionUrl,
        'is_image': isImage,
        'is_text': isText,
        'location': location,
        'hashtags':
            hashtags == null ? [] : List<dynamic>.from(hashtags!.map((x) => x)),
        'post_creator_type': postCreatorType,
        'address_lat_long_wkb': addressLatLongWkb,
        'creator_lat_long_wkb': creatorLatLongWkb,
        'tagged_user_uids': taggedUserUids == null
            ? []
            : List<dynamic>.from(taggedUserUids!.map((x) => x)),
        'tagged_community_uids': taggedCommunityUids == null
            ? []
            : List<dynamic>.from(taggedCommunityUids!.map((x) => x)),
        'video_duration_ms': videoDurationMs,
        'community_uid': communityUid,
      };
}
