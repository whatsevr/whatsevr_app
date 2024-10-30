import 'dart:convert';

class UploadPdfRequest {
  final String? title;
  final String? description;
  final String? userUid;
  final String? thumbnailUrl;
  final String? fileUrl;
  final String? postCreatorType;
  final dynamic communityUid;
  final String? creatorLatLongWkb;

  UploadPdfRequest({
    this.title,
    this.description,
    this.userUid,
    this.thumbnailUrl,
    this.fileUrl,
    this.postCreatorType,
    this.communityUid,
    this.creatorLatLongWkb,
  });

  UploadPdfRequest copyWith({
    String? title,
    String? description,
    String? userUid,
    String? thumbnailUrl,
    String? fileUrl,
    String? postCreatorType,
    dynamic communityUid,
    String? creatorLatLongWkb,
  }) =>
      UploadPdfRequest(
        title: title ?? this.title,
        description: description ?? this.description,
        userUid: userUid ?? this.userUid,
        thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
        fileUrl: fileUrl ?? this.fileUrl,
        postCreatorType: postCreatorType ?? this.postCreatorType,
        communityUid: communityUid ?? this.communityUid,
        creatorLatLongWkb: creatorLatLongWkb ?? this.creatorLatLongWkb,
      );

  factory UploadPdfRequest.fromJson(String str) => UploadPdfRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UploadPdfRequest.fromMap(Map<String, dynamic> json) => UploadPdfRequest(
    title: json['title'],
    description: json['description'],
    userUid: json['user_uid'],
    thumbnailUrl: json['thumbnail_url'],
    fileUrl: json['file_url'],
    postCreatorType: json['post_creator_type'],
    communityUid: json['community_uid'],
    creatorLatLongWkb: json['creator_lat_long_wkb'],
  );

  Map<String, dynamic> toMap() => {
    'title': title,
    'description': description,
    'user_uid': userUid,
    'thumbnail_url': thumbnailUrl,
    'file_url': fileUrl,
    'post_creator_type': postCreatorType,
    'community_uid': communityUid,
    'creator_lat_long_wkb': creatorLatLongWkb,
  };
}
