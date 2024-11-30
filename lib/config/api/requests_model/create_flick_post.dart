import 'dart:convert';

class CreateFlickPostRequest {
  final String? title;
  final String? description;
  final String? userUid;
  final String? thumbnail;
  final String? location;
  final List<String>? hashtags;
  final List<String>? taggedUserUids;
  final List<String>? taggedCommunityUids;
  final String? postCreatorType;
  final String? videoUrl;

  final String? addressLatLongWkb;
  final String? creatorLatLongWkb;
  final int? videoDurationInSec;
  final String? communityUid;
  CreateFlickPostRequest({
    this.title,
    this.description,
    this.userUid,
    this.thumbnail,
    this.location,
    this.hashtags,
    this.postCreatorType,
    this.videoUrl,
    this.addressLatLongWkb,
    this.creatorLatLongWkb,
    this.taggedUserUids,
    this.taggedCommunityUids,
    this.videoDurationInSec,
    this.communityUid,
  });

  factory CreateFlickPostRequest.fromJson(String str) =>
      CreateFlickPostRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreateFlickPostRequest.fromMap(Map<String, dynamic> json) =>
      CreateFlickPostRequest(
        title: json['title'],
        description: json['description'],
        userUid: json['user_uid'],
        thumbnail: json['thumbnail'],
        location: json['location'],
        hashtags: json['hashtags'] == null
            ? <String>[]
            : List<String>.from(json['hashtags']!.map((x) => x)),
        postCreatorType: json['post_creator_type'],
        videoUrl: json['video_url'],
        addressLatLongWkb: json['address_lat_long_wkb'],
        creatorLatLongWkb: json['creator_lat_long_wkb'],
        taggedUserUids: json['tagged_user_uids'] == null
            ? <String>[]
            : List<String>.from(json['tagged_user_uids']!.map((x) => x)),
        taggedCommunityUids: json['tagged_community_uids'] == null
            ? <String>[]
            : List<String>.from(json['tagged_community_uids']!.map((x) => x)),
        videoDurationInSec: json['video_duration_in_sec'],
        communityUid: json['community_uid'],
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'title': title,
        'description': description,
        'user_uid': userUid,
        'thumbnail': thumbnail,
        'location': location,
        'hashtags': hashtags == null
            ? <String>[]
            : List<dynamic>.from(hashtags!.map((String x) => x)),
        'post_creator_type': postCreatorType,
        'video_url': videoUrl,
        'address_lat_long_wkb': addressLatLongWkb,
        'creator_lat_long_wkb': creatorLatLongWkb,
        'tagged_user_uids': taggedUserUids == null
            ? <String>[]
            : List<dynamic>.from(taggedUserUids!.map((String x) => x)),
        'tagged_community_uids': taggedCommunityUids == null
            ? <String>[]
            : List<dynamic>.from(taggedCommunityUids!.map((String x) => x)),
        'video_duration_in_sec': videoDurationInSec,
        'community_uid': communityUid,
      };
}
