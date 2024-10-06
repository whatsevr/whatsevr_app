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
  final dynamic videoDurationSec;
  final int? sizeBytes;

  MediaMetaData({
    this.videoDurationSec,
    this.sizeBytes,
  });

  MediaMetaData copyWith({
    dynamic videoDurationSec,
    int? sizeBytes,
  }) =>
      MediaMetaData(
        videoDurationSec: videoDurationSec ?? this.videoDurationSec,
        sizeBytes: sizeBytes ?? this.sizeBytes,
      );

  factory MediaMetaData.fromJson(String str) =>
      MediaMetaData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MediaMetaData.fromMap(Map<String, dynamic> json) => MediaMetaData(
        videoDurationSec: json["video_duration_sec"],
        sizeBytes: json["size_bytes"],
      );

  Map<String, dynamic> toMap() => {
        "video_duration_sec": videoDurationSec,
        "size_bytes": sizeBytes,
      };
}

class PostData {
  final dynamic isVideo;
  final bool? isImage;
  final String? userUid;
  final String? caption;
  final String? postCreatorType;

  PostData({
    this.isVideo,
    this.isImage,
    this.userUid,
    this.caption,
    this.postCreatorType,
  });

  PostData copyWith({
    dynamic isVideo,
    bool? isImage,
    String? userUid,
    String? caption,
    String? postCreatorType,
  }) =>
      PostData(
        isVideo: isVideo ?? this.isVideo,
        isImage: isImage ?? this.isImage,
        userUid: userUid ?? this.userUid,
        caption: caption ?? this.caption,
        postCreatorType: postCreatorType ?? this.postCreatorType,
      );

  factory PostData.fromJson(String str) => PostData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PostData.fromMap(Map<String, dynamic> json) => PostData(
        isVideo: json["is_video"],
        isImage: json["is_image"],
        userUid: json["user_uid"],
        caption: json["caption"],
        postCreatorType: json["post_creator_type"],
      );

  Map<String, dynamic> toMap() => {
        "is_video": isVideo,
        "is_image": isImage,
        "user_uid": userUid,
        "caption": caption,
        "post_creator_type": postCreatorType,
      };
}
