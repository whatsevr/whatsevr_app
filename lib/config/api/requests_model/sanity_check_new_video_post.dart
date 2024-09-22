import 'dart:convert';

class SanityCheckNewVideoPostRequest {
  final MediaMetaData? mediaMetaData;
  final PostData? postData;

  SanityCheckNewVideoPostRequest({
    this.mediaMetaData,
    this.postData,
  });

  SanityCheckNewVideoPostRequest copyWith({
    MediaMetaData? mediaMetaData,
    PostData? postData,
  }) =>
      SanityCheckNewVideoPostRequest(
        mediaMetaData: mediaMetaData ?? this.mediaMetaData,
        postData: postData ?? this.postData,
      );

  factory SanityCheckNewVideoPostRequest.fromJson(String str) =>
      SanityCheckNewVideoPostRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SanityCheckNewVideoPostRequest.fromMap(Map<String, dynamic> json) =>
      SanityCheckNewVideoPostRequest(
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
  final String? postCreatorType;
  final String? userUid;
  final String? title;

  PostData({
    this.postCreatorType,
    this.userUid,
    this.title,
  });

  PostData copyWith({
    String? postCreatorType,
    String? userUid,
    String? title,
  }) =>
      PostData(
        postCreatorType: postCreatorType ?? this.postCreatorType,
        userUid: userUid ?? this.userUid,
        title: title ?? this.title,
      );

  factory PostData.fromJson(String str) => PostData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PostData.fromMap(Map<String, dynamic> json) => PostData(
        postCreatorType: json["post_creator_type"],
        userUid: json["user_uid"],
        title: json["title"],
      );

  Map<String, dynamic> toMap() => {
        "post_creator_type": postCreatorType,
        "user_uid": userUid,
        "title": title,
      };
}
