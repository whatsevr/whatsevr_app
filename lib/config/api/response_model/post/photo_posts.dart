import 'dart:convert';

class UserAndCommunityPhotoPostsResponse {
  final String? message;
  final int? page;
  final bool? lastPage;
  final List<PhotoPost>? photoPosts;

  UserAndCommunityPhotoPostsResponse({
    this.message,
    this.page,
    this.lastPage,
    this.photoPosts,
  });

  UserAndCommunityPhotoPostsResponse copyWith({
    String? message,
    int? page,
    bool? lastPage,
    List<PhotoPost>? photoPosts,
  }) =>
      UserAndCommunityPhotoPostsResponse(
        message: message ?? this.message,
        page: page ?? this.page,
        lastPage: lastPage ?? this.lastPage,
        photoPosts: photoPosts ?? this.photoPosts,
      );

  factory UserAndCommunityPhotoPostsResponse.fromJson(String str) =>
      UserAndCommunityPhotoPostsResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserAndCommunityPhotoPostsResponse.fromMap(
          Map<String, dynamic> json) =>
      UserAndCommunityPhotoPostsResponse(
        message: json['message'],
        page: json['page'],
        lastPage: json['last_page'],
        photoPosts: json['photo_posts'] == null
            ? []
            : List<PhotoPost>.from(
                json['photo_posts']!.map((x) => PhotoPost.fromMap(x)),
              ),
      );

  Map<String, dynamic> toMap() => {
        'message': message,
        'page': page,
        'last_page': lastPage,
        'photo_posts': photoPosts == null
            ? []
            : List<dynamic>.from(photoPosts!.map((x) => x.toMap())),
      };
}

class PhotoPost {
  final int? id;
  final DateTime? createdAt;
  final String? uid;
  final String? title;
  final String? description;
  final List<String>? hashtags;
  final List<String>? taggedUserUids;
  final bool? isDeleted;
  final bool? isArchived;
  final bool? isActive;
  final String? postCreatorType;
  final DateTime? updatedAt;
  final String? userUid;
  final String? location;
  final int? totalImpressions;
  final int? totalLikes;
  final int? totalComments;
  final String? internalAiDescription;
  final String? addressLatLongWkb;
  final String? creatorLatLongWkb;
  final List<String>? taggedCommunityUids;
  final int? totalShares;
  final int? cumulativeScore;
  final List<FilesDatum>? filesData;

  PhotoPost({
    this.id,
    this.createdAt,
    this.uid,
    this.title,
    this.description,
    this.hashtags,
    this.taggedUserUids,
    this.isDeleted,
    this.isArchived,
    this.isActive,
    this.postCreatorType,
    this.updatedAt,
    this.userUid,
    this.location,
    this.totalImpressions,
    this.totalLikes,
    this.totalComments,
    this.internalAiDescription,
    this.addressLatLongWkb,
    this.creatorLatLongWkb,
    this.taggedCommunityUids,
    this.totalShares,
    this.cumulativeScore,
    this.filesData,
  });

  PhotoPost copyWith({
    int? id,
    DateTime? createdAt,
    String? uid,
    String? title,
    String? description,
    List<String>? hashtags,
    List<String>? taggedUserUids,
    bool? isDeleted,
    bool? isArchived,
    bool? isActive,
    String? postCreatorType,
    DateTime? updatedAt,
    String? userUid,
    String? location,
    int? totalImpressions,
    int? totalLikes,
    int? totalComments,
    String? internalAiDescription,
    String? addressLatLongWkb,
    String? creatorLatLongWkb,
    List<String>? taggedCommunityUids,
    int? totalShares,
    int? cumulativeScore,
    List<FilesDatum>? filesData,
  }) =>
      PhotoPost(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        uid: uid ?? this.uid,
        title: title ?? this.title,
        description: description ?? this.description,
        hashtags: hashtags ?? this.hashtags,
        taggedUserUids: taggedUserUids ?? this.taggedUserUids,
        isDeleted: isDeleted ?? this.isDeleted,
        isArchived: isArchived ?? this.isArchived,
        isActive: isActive ?? this.isActive,
        postCreatorType: postCreatorType ?? this.postCreatorType,
        updatedAt: updatedAt ?? this.updatedAt,
        userUid: userUid ?? this.userUid,
        location: location ?? this.location,
        totalImpressions: totalImpressions ?? this.totalImpressions,
        totalLikes: totalLikes ?? this.totalLikes,
        totalComments: totalComments ?? this.totalComments,
        internalAiDescription:
            internalAiDescription ?? this.internalAiDescription,
        addressLatLongWkb: addressLatLongWkb ?? this.addressLatLongWkb,
        creatorLatLongWkb: creatorLatLongWkb ?? this.creatorLatLongWkb,
        taggedCommunityUids: taggedCommunityUids ?? this.taggedCommunityUids,
        totalShares: totalShares ?? this.totalShares,
        cumulativeScore: cumulativeScore ?? this.cumulativeScore,
        filesData: filesData ?? this.filesData,
      );

  factory PhotoPost.fromJson(String str) => PhotoPost.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PhotoPost.fromMap(Map<String, dynamic> json) => PhotoPost(
        id: json['id'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        uid: json['uid'],
        title: json['title'],
        description: json['description'],
        hashtags: json['hashtags'] == null
            ? []
            : List<String>.from(json['hashtags']!.map((x) => x)),
        taggedUserUids: json['tagged_user_uids'] == null
            ? []
            : List<String>.from(json['tagged_user_uids']!.map((x) => x)),
        isDeleted: json['is_deleted'],
        isArchived: json['is_archived'],
        isActive: json['is_active'],
        postCreatorType: json['post_creator_type'],
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at']),
        userUid: json['user_uid'],
        location: json['location'],
        totalImpressions: json['total_impressions'],
        totalLikes: json['total_likes'],
        totalComments: json['total_comments'],
        internalAiDescription: json['internal_ai_description'],
        addressLatLongWkb: json['address_lat_long_wkb'],
        creatorLatLongWkb: json['creator_lat_long_wkb'],
        taggedCommunityUids: json['tagged_community_uids'] == null
            ? []
            : List<String>.from(json['tagged_community_uids']!.map((x) => x)),
        totalShares: json['total_shares'],
        cumulativeScore: json['cumulative_score'],
        filesData: json['files_data'] == null
            ? []
            : List<FilesDatum>.from(
                json['files_data']!.map((x) => FilesDatum.fromMap(x)),
              ),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'created_at': createdAt?.toIso8601String(),
        'uid': uid,
        'title': title,
        'description': description,
        'hashtags':
            hashtags == null ? [] : List<dynamic>.from(hashtags!.map((x) => x)),
        'tagged_user_uids': taggedUserUids == null
            ? []
            : List<dynamic>.from(taggedUserUids!.map((x) => x)),
        'is_deleted': isDeleted,
        'is_archived': isArchived,
        'is_active': isActive,
        'post_creator_type': postCreatorType,
        'updated_at': updatedAt?.toIso8601String(),
        'user_uid': userUid,
        'location': location,
        'total_impressions': totalImpressions,
        'total_likes': totalLikes,
        'total_comments': totalComments,
        'internal_ai_description': internalAiDescription,
        'address_lat_long_wkb': addressLatLongWkb,
        'creator_lat_long_wkb': creatorLatLongWkb,
        'tagged_community_uids': taggedCommunityUids == null
            ? []
            : List<dynamic>.from(taggedCommunityUids!.map((x) => x)),
        'total_shares': totalShares,
        'cumulative_score': cumulativeScore,
        'files_data': filesData == null
            ? []
            : List<dynamic>.from(filesData!.map((x) => x.toMap())),
      };
}

class FilesDatum {
  final String? type;
  final String? imageUrl;

  FilesDatum({
    this.type,
    this.imageUrl,
  });

  FilesDatum copyWith({
    String? type,
    String? imageUrl,
  }) =>
      FilesDatum(
        type: type ?? this.type,
        imageUrl: imageUrl ?? this.imageUrl,
      );

  factory FilesDatum.fromJson(String str) =>
      FilesDatum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FilesDatum.fromMap(Map<String, dynamic> json) => FilesDatum(
        type: json['type'],
        imageUrl: json['image_url'],
      );

  Map<String, dynamic> toMap() => {
        'type': type,
        'image_url': imageUrl,
      };
}
