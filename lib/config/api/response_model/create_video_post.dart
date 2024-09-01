import 'dart:convert';

class CreateVideoPostResponse {
  final String? message;
  final List<Datum>? data;

  CreateVideoPostResponse({
    this.message,
    this.data,
  });

  factory CreateVideoPostResponse.fromJson(String str) =>
      CreateVideoPostResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreateVideoPostResponse.fromMap(Map<String, dynamic> json) =>
      CreateVideoPostResponse(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Datum {
  final int? id;
  final DateTime? createdAt;
  final String? uid;
  final String? title;
  final String? description;
  final dynamic hashtags;
  final dynamic taggedUsersUid;
  final dynamic taggedPortfolios;
  final dynamic taggedCommunitiesUid;
  final dynamic likesCount;
  final bool? isDeleted;
  final bool? isArchived;
  final bool? isActive;
  final dynamic postCreatorType;
  final DateTime? updatedAt;
  final String? userUid;
  final dynamic thumbnail;
  final dynamic videoUrl;
  final dynamic location;
  final dynamic locationLatitude;
  final dynamic locationLongitude;

  Datum({
    this.id,
    this.createdAt,
    this.uid,
    this.title,
    this.description,
    this.hashtags,
    this.taggedUsersUid,
    this.taggedPortfolios,
    this.taggedCommunitiesUid,
    this.likesCount,
    this.isDeleted,
    this.isArchived,
    this.isActive,
    this.postCreatorType,
    this.updatedAt,
    this.userUid,
    this.thumbnail,
    this.videoUrl,
    this.location,
    this.locationLatitude,
    this.locationLongitude,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        uid: json["uid"],
        title: json["title"],
        description: json["description"],
        hashtags: json["hashtags"],
        taggedUsersUid: json["tagged_users_uid"],
        taggedPortfolios: json["tagged_portfolios"],
        taggedCommunitiesUid: json["tagged_communities_uid"],
        likesCount: json["likes_count"],
        isDeleted: json["is_deleted"],
        isArchived: json["is_archived"],
        isActive: json["is_active"],
        postCreatorType: json["post_creator_type"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        userUid: json["user_uid"],
        thumbnail: json["thumbnail"],
        videoUrl: json["video_url"],
        location: json["location"],
        locationLatitude: json["location_latitude"],
        locationLongitude: json["location_longitude"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "uid": uid,
        "title": title,
        "description": description,
        "hashtags": hashtags,
        "tagged_users_uid": taggedUsersUid,
        "tagged_portfolios": taggedPortfolios,
        "tagged_communities_uid": taggedCommunitiesUid,
        "likes_count": likesCount,
        "is_deleted": isDeleted,
        "is_archived": isArchived,
        "is_active": isActive,
        "post_creator_type": postCreatorType,
        "updated_at": updatedAt?.toIso8601String(),
        "user_uid": userUid,
        "thumbnail": thumbnail,
        "video_url": videoUrl,
        "location": location,
        "location_latitude": locationLatitude,
        "location_longitude": locationLongitude,
      };
}
