import 'dart:convert';

class SanityCheckNewFlickPostRequest {
  final MediaMetaData? mediaMetaData;
  final PostData? postData;

  SanityCheckNewFlickPostRequest({
    this.mediaMetaData,
    this.postData,
  });

  SanityCheckNewFlickPostRequest copyWith({
    MediaMetaData? mediaMetaData,
    PostData? postData,
  }) =>
      SanityCheckNewFlickPostRequest(
        mediaMetaData: mediaMetaData ?? this.mediaMetaData,
        postData: postData ?? this.postData,
      );

  factory SanityCheckNewFlickPostRequest.fromJson(String str) =>
      SanityCheckNewFlickPostRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SanityCheckNewFlickPostRequest.fromMap(Map<String, dynamic> json) =>
      SanityCheckNewFlickPostRequest(
        mediaMetaData: json['media_meta_data'] == null
            ? null
            : MediaMetaData.fromMap(json['media_meta_data']),
        postData: json['post_data'] == null
            ? null
            : PostData.fromMap(json['post_data']),
      );

  Map<String, dynamic> toMap() => {
        'media_meta_data': mediaMetaData?.toMap(),
        'post_data': postData?.toMap(),
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
        durationSec: json['duration_sec'],
        sizeBytes: json['size_bytes'],
        aspectRatio: json['aspect_ratio']?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        'duration_sec': durationSec,
        'size_bytes': sizeBytes,
        'aspect_ratio': aspectRatio,
      };
}

class PostData {
  final String? postCreatorType;
  final String? userUid;

  PostData({
    this.postCreatorType,
    this.userUid,
  });

  PostData copyWith({
    String? postCreatorType,
    String? userUid,
  }) =>
      PostData(
        postCreatorType: postCreatorType ?? this.postCreatorType,
        userUid: userUid ?? this.userUid,
      );

  factory PostData.fromJson(String str) => PostData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PostData.fromMap(Map<String, dynamic> json) => PostData(
        postCreatorType: json['post_creator_type'],
        userUid: json['user_uid'],
      );

  Map<String, dynamic> toMap() => {
        'post_creator_type': postCreatorType,
        'user_uid': userUid,
      };
}
