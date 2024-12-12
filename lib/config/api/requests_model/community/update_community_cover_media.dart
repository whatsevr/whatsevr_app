import 'dart:convert';

class UpdateCommunityCoverMediaRequest {
  final String? communityUid;
  final String? userUid;
  final List<CommunityCoverMedia>? communityCoverMedia;

  UpdateCommunityCoverMediaRequest({
    this.communityUid,
    this.userUid,
    this.communityCoverMedia,
  });

  UpdateCommunityCoverMediaRequest copyWith({
    String? communityUid,
    String? userUid,
    List<CommunityCoverMedia>? communityCoverMedia,
  }) =>
      UpdateCommunityCoverMediaRequest(
        communityUid: communityUid ?? this.communityUid,
        userUid: userUid ?? this.userUid,
        communityCoverMedia: communityCoverMedia ?? this.communityCoverMedia,
      );

  factory UpdateCommunityCoverMediaRequest.fromJson(String str) =>
      UpdateCommunityCoverMediaRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UpdateCommunityCoverMediaRequest.fromMap(Map<String, dynamic> json) =>
      UpdateCommunityCoverMediaRequest(
        communityUid: json['community_uid'],
        userUid: json['user_uid'],
        communityCoverMedia: json['community_cover_media'] == null
            ? []
            : List<CommunityCoverMedia>.from(
                json['community_cover_media']!
                    .map((x) => CommunityCoverMedia.fromMap(x)),
              ),
      );

  Map<String, dynamic> toMap() => {
        'community_uid': communityUid,
        'user_uid': userUid,
        'community_cover_media': communityCoverMedia == null
            ? []
            : List<dynamic>.from(communityCoverMedia!.map((x) => x.toMap())),
      };
}

class CommunityCoverMedia {
  final String? imageUrl;
  final bool? isVideo;
  final String? communityUid;
  final String? videoUrl;

  CommunityCoverMedia({
    this.imageUrl,
    this.isVideo,
    this.communityUid,
    this.videoUrl,
  });

  CommunityCoverMedia copyWith({
    String? imageUrl,
    bool? isVideo,
    String? communityUid,
    String? videoUrl,
  }) =>
      CommunityCoverMedia(
        imageUrl: imageUrl ?? this.imageUrl,
        isVideo: isVideo ?? this.isVideo,
        communityUid: communityUid ?? this.communityUid,
        videoUrl: videoUrl ?? this.videoUrl,
      );

  factory CommunityCoverMedia.fromJson(String str) =>
      CommunityCoverMedia.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CommunityCoverMedia.fromMap(Map<String, dynamic> json) =>
      CommunityCoverMedia(
        imageUrl: json['image_url'],
        isVideo: json['is_video'],
        communityUid: json['community_uid'],
        videoUrl: json['video_url'],
      );

  Map<String, dynamic> toMap() => {
        'image_url': imageUrl,
        'is_video': isVideo,
        'community_uid': communityUid,
        'video_url': videoUrl,
      };
}
