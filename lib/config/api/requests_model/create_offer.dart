import 'dart:convert';

class CreateOfferRequest {
  final String? title;
  final String? description;
  final String? userUid;
  final String? location;
  final List<String>? hashtags;
  final String? postCreatorType;
  final String? addressLatLongWkb;
  final String? creatorLatLongWkb;
  final List<String>? taggedUserUids;
  final List<String>? taggedCommunityUids;
  final List<FilesDatum>? filesData;
  final String? ctaAction;
  final String? ctaActionUrl;

  CreateOfferRequest({
    this.title,
    this.description,
    this.userUid,
    this.location,
    this.hashtags,
    this.postCreatorType,
    this.addressLatLongWkb,
    this.creatorLatLongWkb,
    this.taggedUserUids,
    this.taggedCommunityUids,
    this.filesData,
    this.ctaAction,
    this.ctaActionUrl,
  });

  CreateOfferRequest copyWith({
    String? title,
    String? description,
    String? userUid,
    String? location,
    List<String>? hashtags,
    String? postCreatorType,
    String? addressLatLongWkb,
    String? creatorLatLongWkb,
    List<String>? taggedUserUids,
    List<String>? taggedCommunityUids,
    List<FilesDatum>? filesData,
    String? ctaAction,
    String? ctaActionUrl,
  }) =>
      CreateOfferRequest(
        title: title ?? this.title,
        description: description ?? this.description,
        userUid: userUid ?? this.userUid,
        location: location ?? this.location,
        hashtags: hashtags ?? this.hashtags,
        postCreatorType: postCreatorType ?? this.postCreatorType,
        addressLatLongWkb: addressLatLongWkb ?? this.addressLatLongWkb,
        creatorLatLongWkb: creatorLatLongWkb ?? this.creatorLatLongWkb,
        taggedUserUids: taggedUserUids ?? this.taggedUserUids,
        taggedCommunityUids: taggedCommunityUids ?? this.taggedCommunityUids,
        filesData: filesData ?? this.filesData,
        ctaAction: ctaAction ?? this.ctaAction,
        ctaActionUrl: ctaActionUrl ?? this.ctaActionUrl,
      );

  factory CreateOfferRequest.fromJson(String str) =>
      CreateOfferRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreateOfferRequest.fromMap(Map<String, dynamic> json) =>
      CreateOfferRequest(
        title: json["title"],
        description: json["description"],
        userUid: json["user_uid"],
        location: json["location"],
        hashtags: json["hashtags"] == null
            ? []
            : List<String>.from(json["hashtags"]!.map((x) => x)),
        postCreatorType: json["post_creator_type"],
        addressLatLongWkb: json["address_lat_long_wkb"],
        creatorLatLongWkb: json["creator_lat_long_wkb"],
        taggedUserUids: json["tagged_user_uids"] == null
            ? []
            : List<String>.from(json["tagged_user_uids"]!.map((x) => x)),
        taggedCommunityUids: json["tagged_community_uids"] == null
            ? []
            : List<String>.from(json["tagged_community_uids"]!.map((x) => x)),
        filesData: json["files_data"] == null
            ? []
            : List<FilesDatum>.from(
                json["files_data"]!.map((x) => FilesDatum.fromMap(x))),
        ctaAction: json["cta_action"],
        ctaActionUrl: json["cta_action_url"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "description": description,
        "user_uid": userUid,
        "location": location,
        "hashtags":
            hashtags == null ? [] : List<dynamic>.from(hashtags!.map((x) => x)),
        "post_creator_type": postCreatorType,
        "address_lat_long_wkb": addressLatLongWkb,
        "creator_lat_long_wkb": creatorLatLongWkb,
        "tagged_user_uids": taggedUserUids == null
            ? []
            : List<dynamic>.from(taggedUserUids!.map((x) => x)),
        "tagged_community_uids": taggedCommunityUids == null
            ? []
            : List<dynamic>.from(taggedCommunityUids!.map((x) => x)),
        "files_data": filesData == null
            ? []
            : List<dynamic>.from(filesData!.map((x) => x.toMap())),
        "cta_action": ctaAction,
        "cta_action_url": ctaActionUrl,
      };
}

// Base class for handling common behavior
abstract class FilesDatum {
  final String type;

  FilesDatum(this.type);

  factory FilesDatum.fromMap(Map<String, dynamic> json) {
    if (json["type"] == "image") {
      return ImageFileDatum.fromMap(json);
    } else if (json["type"] == "video") {
      return VideoFileDatum.fromMap(json);
    } else {
      throw Exception("Unknown file type");
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
        type: json["type"],
        imageUrl: json["image_url"],
      );

  @override
  Map<String, dynamic> toMap() => {
        "type": type,
        "image_url": imageUrl,
      };
}

// Handles video data
class VideoFileDatum extends FilesDatum {
  final String? videoUrl;
  final String? thumbnailUrl;
  final int? videoDurationMs;

  VideoFileDatum({
    required String type,
    this.videoUrl,
    this.thumbnailUrl,
    this.videoDurationMs,
  }) : super(type);

  factory VideoFileDatum.fromJson(String str) =>
      VideoFileDatum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoFileDatum.fromMap(Map<String, dynamic> json) => VideoFileDatum(
        type: json["type"],
        videoUrl: json["video_url"],
        thumbnailUrl: json["thumbnail_url"],
        videoDurationMs: json["video_duration_ms"],
      );

  @override
  Map<String, dynamic> toMap() => {
        "type": type,
        "video_url": videoUrl,
        "thumbnail_url": thumbnailUrl,
        "video_duration_ms": videoDurationMs,
      };
}
