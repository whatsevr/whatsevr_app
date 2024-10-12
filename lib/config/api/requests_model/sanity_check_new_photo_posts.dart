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
  final int? imageSizeBytes;

  MediaMetaDatum({
    this.imageSizeBytes,
  });

  MediaMetaDatum copyWith({
    int? imageSizeBytes,
  }) =>
      MediaMetaDatum(
        imageSizeBytes: imageSizeBytes ?? this.imageSizeBytes,
      );

  factory MediaMetaDatum.fromJson(String str) =>
      MediaMetaDatum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MediaMetaDatum.fromMap(Map<String, dynamic> json) => MediaMetaDatum(
        imageSizeBytes: json["image_size_bytes"],
      );

  Map<String, dynamic> toMap() => {
        "image_size_bytes": imageSizeBytes,
      };
}

class PostData {
  final String? postCreatorType;
  final String? userUid;
  final String? communityUid;

  PostData({
    this.postCreatorType,
    this.userUid,
    this.communityUid,
  });

  PostData copyWith({
    String? postCreatorType,
    String? userUid,
    String? communityUid,
  }) =>
      PostData(
        postCreatorType: postCreatorType ?? this.postCreatorType,
        userUid: userUid ?? this.userUid,
        communityUid: communityUid ?? this.communityUid,
      );

  factory PostData.fromJson(String str) => PostData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PostData.fromMap(Map<String, dynamic> json) => PostData(
        postCreatorType: json["post_creator_type"],
        userUid: json["user_uid"],
        communityUid: json["community_uid"],
      );

  Map<String, dynamic> toMap() => {
        "post_creator_type": postCreatorType,
        "user_uid": userUid,
        "community_uid": communityUid,
      };
}
