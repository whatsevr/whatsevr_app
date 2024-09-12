import 'dart:convert';

class UpdateUserCoverMediaRequest {
  final String? userUid;
  final List<UserCoverMedia>? userCoverMedia;

  UpdateUserCoverMediaRequest({
    this.userUid,
    this.userCoverMedia,
  });

  factory UpdateUserCoverMediaRequest.fromJson(String str) =>
      UpdateUserCoverMediaRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UpdateUserCoverMediaRequest.fromMap(Map<String, dynamic> json) =>
      UpdateUserCoverMediaRequest(
        userUid: json["user_uid"],
        userCoverMedia: json["user_cover_media"] == null
            ? []
            : List<UserCoverMedia>.from(json["user_cover_media"]!
                .map((x) => UserCoverMedia.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "user_uid": userUid,
        "user_cover_media": userCoverMedia == null
            ? []
            : List<dynamic>.from(userCoverMedia!.map((x) => x.toMap())),
      };
}

class UserCoverMedia {
  final String? imageUrl;
  final bool? isVideo;
  final String? userUid;
  final String? videoUrl;

  UserCoverMedia({
    this.imageUrl,
    this.isVideo,
    this.userUid,
    this.videoUrl,
  });

  factory UserCoverMedia.fromJson(String str) =>
      UserCoverMedia.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserCoverMedia.fromMap(Map<String, dynamic> json) => UserCoverMedia(
        imageUrl: json["image_url"],
        isVideo: json["is_video"],
        userUid: json["user_uid"],
        videoUrl: json["video_url"],
      );

  Map<String, dynamic> toMap() => {
        "image_url": imageUrl,
        "is_video": isVideo,
        "user_uid": userUid,
        "video_url": videoUrl,
      };
}
