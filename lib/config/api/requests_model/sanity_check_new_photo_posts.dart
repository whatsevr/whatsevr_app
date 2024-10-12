import 'dart:convert';

class SanityCheckNewPhotoPostRequest {
  final List<MediaMetaDatum>? mediaMetaData;
  final PostData? postData;

  SanityCheckNewPhotoPostRequest({
    this.mediaMetaData,
    this.postData,
  });

  SanityCheckNewPhotoPostRequest copyWith({
    List<MediaMetaDatum>? mediaMetaData,
    PostData? postData,
  }) =>
      SanityCheckNewPhotoPostRequest(
        mediaMetaData: mediaMetaData ?? this.mediaMetaData,
        postData: postData ?? this.postData,
      );

  factory SanityCheckNewPhotoPostRequest.fromJson(String str) =>
      SanityCheckNewPhotoPostRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SanityCheckNewPhotoPostRequest.fromMap(Map<String, dynamic> json) =>
      SanityCheckNewPhotoPostRequest(
        mediaMetaData: json["media_meta_data"] == null
            ? []
            : List<MediaMetaDatum>.from(
                json["media_meta_data"]!.map((x) => MediaMetaDatum.fromMap(x))),
        postData: json["post_data"] == null
            ? null
            : PostData.fromMap(json["post_data"]),
      );

  Map<String, dynamic> toMap() => {
        "media_meta_data": mediaMetaData == null
            ? []
            : List<dynamic>.from(mediaMetaData!.map((x) => x.toMap())),
        "post_data": postData?.toMap(),
      };
}

class MediaMetaDatum {
  final int? videoDurationSec;
  final int? sizeBytes;

  MediaMetaDatum({
    this.videoDurationSec,
    this.sizeBytes,
  });

  MediaMetaDatum copyWith({
    int? videoDurationSec,
    int? sizeBytes,
  }) =>
      MediaMetaDatum(
        videoDurationSec: videoDurationSec ?? this.videoDurationSec,
        sizeBytes: sizeBytes ?? this.sizeBytes,
      );

  factory MediaMetaDatum.fromJson(String str) =>
      MediaMetaDatum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MediaMetaDatum.fromMap(Map<String, dynamic> json) => MediaMetaDatum(
        videoDurationSec: json["video_duration_sec"],
        sizeBytes: json["size_bytes"],
      );

  Map<String, dynamic> toMap() => {
        "video_duration_sec": videoDurationSec,
        "size_bytes": sizeBytes,
      };
}

class PostData {
  final String? userUid;
  final String? communityUid;
  final String? postCreatorType;

  PostData({
    this.userUid,
    this.communityUid,
    this.postCreatorType,
  });

  PostData copyWith({
    String? userUid,
    String? communityUid,
    String? postCreatorType,
  }) =>
      PostData(
        userUid: userUid ?? this.userUid,
        communityUid: communityUid ?? this.communityUid,
        postCreatorType: postCreatorType ?? this.postCreatorType,
      );

  factory PostData.fromJson(String str) => PostData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PostData.fromMap(Map<String, dynamic> json) => PostData(
        userUid: json["user_uid"],
        communityUid: json["community_uid"],
        postCreatorType: json["post_creator_type"],
      );

  Map<String, dynamic> toMap() => {
        "user_uid": userUid,
        "community_uid": communityUid,
        "post_creator_type": postCreatorType,
      };
}
