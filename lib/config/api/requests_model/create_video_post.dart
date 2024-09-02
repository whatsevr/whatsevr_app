import 'dart:convert';

class CreateVideoPostRequest {
  final String? title;
  final String? description;
  final String? userUid;
  final String? thumbnail;
  final String? location;
  final List<String>? hashtags;
  final String? postCreatorType;
  final String? videoUrl;

  CreateVideoPostRequest({
    this.title,
    this.description,
    this.userUid,
    this.thumbnail,
    this.location,
    this.hashtags,
    this.postCreatorType,
    this.videoUrl,
  });

  factory CreateVideoPostRequest.fromJson(String str) =>
      CreateVideoPostRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreateVideoPostRequest.fromMap(Map<String, dynamic> json) =>
      CreateVideoPostRequest(
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
      };
}
