import 'dart:convert';

class SanityCheckNewMemoryRequest {
  final MediaMetaData? mediaMetaData;
  final PostData? postData;

  SanityCheckNewMemoryRequest({
    this.mediaMetaData,
    this.postData,
  });

  SanityCheckNewMemoryRequest copyWith({
    MediaMetaData? mediaMetaData,
    PostData? postData,
  }) =>
      SanityCheckNewMemoryRequest(
        mediaMetaData: mediaMetaData ?? this.mediaMetaData,
        postData: postData ?? this.postData,
      );

  factory SanityCheckNewMemoryRequest.fromJson(String str) =>
      SanityCheckNewMemoryRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SanityCheckNewMemoryRequest.fromMap(Map<String, dynamic> json) =>
      SanityCheckNewMemoryRequest(
        mediaMetaData: json["media_meta_data"] == null
            ? null
            : MediaMetaData.fromMap(json["media_meta_data"]),
        postData: json["post_data"] == null
            ? null
            : PostData.fromMap(json["post_data"]),
      );

  Map<String, dynamic> toMap() => {
        "media_meta_data": mediaMetaData?.toMap(),
        "post_data": postData?.toMap(),
      };
}

class MediaMetaData {
  final int? durationSec;
  final int? sizeBytes;
  final double? aspectRatio;

  MediaMetaData({
    this.durationSec,
    this.sizeBytes,
    this.aspectRatio,
  });

  MediaMetaData copyWith({
    int? durationSec,
    int? sizeBytes,
    double? aspectRatio,
  }) =>
      MediaMetaData(
        durationSec: durationSec ?? this.durationSec,
        sizeBytes: sizeBytes ?? this.sizeBytes,
        aspectRatio: aspectRatio ?? this.aspectRatio,
      );

  factory MediaMetaData.fromJson(String str) =>
      MediaMetaData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MediaMetaData.fromMap(Map<String, dynamic> json) => MediaMetaData(
        durationSec: json["duration_sec"],
        sizeBytes: json["size_bytes"],
        aspectRatio: json["aspect_ratio"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "duration_sec": durationSec,
        "size_bytes": sizeBytes,
        "aspect_ratio": aspectRatio,
      };
}

class PostData {
  final bool? isVideo;
  final String? userUid;
  final String? caption;
  final String? postCreatorType;

  PostData({
    this.isVideo,
    this.userUid,
    this.caption,
    this.postCreatorType,
  });

  PostData copyWith({
    bool? isVideo,
    String? userUid,
    String? caption,
    String? postCreatorType,
  }) =>
      PostData(
        isVideo: isVideo ?? this.isVideo,
        userUid: userUid ?? this.userUid,
        caption: caption ?? this.caption,
        postCreatorType: postCreatorType ?? this.postCreatorType,
      );

  factory PostData.fromJson(String str) => PostData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PostData.fromMap(Map<String, dynamic> json) => PostData(
        isVideo: json["is_video"],
        userUid: json["user_uid"],
        caption: json["caption"],
        postCreatorType: json["post_creator_type"],
      );

  Map<String, dynamic> toMap() => {
        "is_video": isVideo,
        "user_uid": userUid,
        "caption": caption,
        "post_creator_type": postCreatorType,
      };
}
