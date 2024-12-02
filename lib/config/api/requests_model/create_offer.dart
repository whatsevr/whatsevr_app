import 'dart:convert';

class CreateOfferRequest {
  final String? title;
  final String? description;
  final String? status;
  final String? userUid;
  final List<String>? targetAreas;
  final String? targetGender;
  final List<String>? hashtags;
  final String? postCreatorType;

  final String? creatorLatLongWkb;
  final List<String>? taggedUserUids;
  final List<String>? taggedCommunityUids;
  final List<FilesDatum>? filesData;
  final String? ctaAction;
  final String? ctaActionUrl;
 final String? communityUid;
  CreateOfferRequest({
    this.title,
    this.description,
    this.status,
    this.userUid,
    this.targetAreas,
    this.targetGender,
    this.hashtags,
    this.postCreatorType,
    this.creatorLatLongWkb,
    this.taggedUserUids,
    this.taggedCommunityUids,
    this.filesData,
    this.ctaAction,
    this.ctaActionUrl,
    this.communityUid,
  });

  CreateOfferRequest copyWith({
    String? title,
    String? description,
    String? status,
    String? userUid,
    List<String>? targetAreas,
    String? targetGender,
    List<String>? hashtags,
    String? postCreatorType,
    String? creatorLatLongWkb,
    List<String>? taggedUserUids,
    List<String>? taggedCommunityUids,
    List<FilesDatum>? filesData,
    String? ctaAction,
    String? ctaActionUrl,
    String? communityUid,
  }) =>
      CreateOfferRequest(
        title: title ?? this.title,
        description: description ?? this.description,
        status: status ?? this.status,
        userUid: userUid ?? this.userUid,
        targetAreas: targetAreas ?? this.targetAreas,
        targetGender: targetGender ?? this.targetGender,
        hashtags: hashtags ?? this.hashtags,
        postCreatorType: postCreatorType ?? this.postCreatorType,
        creatorLatLongWkb: creatorLatLongWkb ?? this.creatorLatLongWkb,
        taggedUserUids: taggedUserUids ?? this.taggedUserUids,
        taggedCommunityUids: taggedCommunityUids ?? this.taggedCommunityUids,
        filesData: filesData ?? this.filesData,
        ctaAction: ctaAction ?? this.ctaAction,
        ctaActionUrl: ctaActionUrl ?? this.ctaActionUrl,
        communityUid: communityUid ?? this.communityUid,
      );

  factory CreateOfferRequest.fromJson(String str) =>
      CreateOfferRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreateOfferRequest.fromMap(Map<String, dynamic> json) =>
      CreateOfferRequest(
        title: json['title'],
        description: json['description'],
        status: json['status'],
        userUid: json['user_uid'],
        targetAreas: json['target_areas'] == null
            ? []
            : List<String>.from(json['target_areas']!.map((x) => x)),
        targetGender: json['target_gender'],
        hashtags: json['hashtags'] == null
            ? []
            : List<String>.from(json['hashtags']!.map((x) => x)),
        postCreatorType: json['post_creator_type'],
        creatorLatLongWkb: json['creator_lat_long_wkb'],
        taggedUserUids: json['tagged_user_uids'] == null
            ? []
            : List<String>.from(json['tagged_user_uids']!.map((x) => x)),
        taggedCommunityUids: json['tagged_community_uids'] == null
            ? []
            : List<String>.from(json['tagged_community_uids']!.map((x) => x)),
        filesData: json['files_data'] == null
            ? []
            : List<FilesDatum>.from(
                json['files_data']!.map((x) => FilesDatum.fromMap(x)),
              ),
        ctaAction: json['cta_action'],
        ctaActionUrl: json['cta_action_url'],
        communityUid: json['community_uid'],
      );

  Map<String, dynamic> toMap() => {
        'title': title,
        'description': description,
        'status': status,
        'user_uid': userUid,
        'target_areas': targetAreas == null
            ? []
            : List<dynamic>.from(targetAreas!.map((x) => x)),
        'target_gender': targetGender,
        'hashtags':
            hashtags == null ? [] : List<dynamic>.from(hashtags!.map((x) => x)),
        'post_creator_type': postCreatorType,
        'creator_lat_long_wkb': creatorLatLongWkb,
        'tagged_user_uids': taggedUserUids == null
            ? []
            : List<dynamic>.from(taggedUserUids!.map((x) => x)),
        'tagged_community_uids': taggedCommunityUids == null
            ? []
            : List<dynamic>.from(taggedCommunityUids!.map((x) => x)),
        'files_data': filesData == null
            ? []
            : List<dynamic>.from(filesData!.map((x) => x.toMap())),
        'cta_action': ctaAction,
        'cta_action_url': ctaActionUrl,
        'community_uid': communityUid,
      };
}

// Base class for handling common behavior
abstract class FilesDatum {
  final String type;

  FilesDatum(this.type);

  factory FilesDatum.fromMap(Map<String, dynamic> json) {
    if (json['type'] == 'image') {
      return ImageFileDatum.fromMap(json);
    } else if (json['type'] == 'video') {
      return VideoFileDatum.fromMap(json);
    } else {
      throw Exception('Unknown file type');
    }
  }

  Map<String, dynamic> toMap();
}

// Handles image data
class ImageFileDatum extends FilesDatum {
  final String? imageUrl;

  ImageFileDatum({
    required String type,
    this.imageUrl,
  }) : super(type);

  factory ImageFileDatum.fromJson(String str) =>
      ImageFileDatum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ImageFileDatum.fromMap(Map<String, dynamic> json) => ImageFileDatum(
        type: json['type'],
        imageUrl: json['image_url'],
      );

  @override
  Map<String, dynamic> toMap() => {
        'type': type,
        'image_url': imageUrl,
      };
}

// Handles video data
class VideoFileDatum extends FilesDatum {
  final String? videoUrl;
  final String? videoThumbnailUrl;
  final int? videoDurationMs;

  VideoFileDatum({
    required String type,
    this.videoUrl,
    this.videoThumbnailUrl,
    this.videoDurationMs,
  }) : super(type);

  factory VideoFileDatum.fromJson(String str) =>
      VideoFileDatum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoFileDatum.fromMap(Map<String, dynamic> json) => VideoFileDatum(
        type: json['type'],
        videoUrl: json['video_url'],
        videoThumbnailUrl: json['video_thumbnail_url'],
        videoDurationMs: json['video_duration_ms'],
      );

  @override
  Map<String, dynamic> toMap() => {
        'type': type,
        'video_url': videoUrl,
        'video_thumbnail_url': videoThumbnailUrl,
        'video_duration_ms': videoDurationMs,
      };
}
