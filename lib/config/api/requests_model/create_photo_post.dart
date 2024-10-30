import 'dart:convert';

class CreatePhotoPostRequest {
  final String? title;
  final String? description;
  final String? userUid;
  final String? location;
  final List<String>? hashtags;
  final String? postCreatorType;
  final String? addressLatLongWkb;
  final String? creatorLatLongWkb;
  final List<String>? taggedUserUids;
  final List<String>? taggedCommunityUids;
  final List<FilesDatum>? filesData;

  CreatePhotoPostRequest({
    this.title,
    this.description,
    this.userUid,
    this.location,
    this.hashtags,
    this.postCreatorType,
    this.addressLatLongWkb,
    this.creatorLatLongWkb,
    this.taggedUserUids,
    this.taggedCommunityUids,
    this.filesData,
  });

  CreatePhotoPostRequest copyWith({
    String? title,
    String? description,
    String? userUid,
    String? location,
    List<String>? hashtags,
    String? postCreatorType,
    String? addressLatLongWkb,
    String? creatorLatLongWkb,
    List<String>? taggedUserUids,
    List<String>? taggedCommunityUids,
    List<FilesDatum>? filesData,
  }) =>
      CreatePhotoPostRequest(
        title: title ?? this.title,
        description: description ?? this.description,
        userUid: userUid ?? this.userUid,
        location: location ?? this.location,
        hashtags: hashtags ?? this.hashtags,
        postCreatorType: postCreatorType ?? this.postCreatorType,
        addressLatLongWkb: addressLatLongWkb ?? this.addressLatLongWkb,
        creatorLatLongWkb: creatorLatLongWkb ?? this.creatorLatLongWkb,
        taggedUserUids: taggedUserUids ?? this.taggedUserUids,
        taggedCommunityUids: taggedCommunityUids ?? this.taggedCommunityUids,
        filesData: filesData ?? this.filesData,
      );

  factory CreatePhotoPostRequest.fromJson(String str) =>
      CreatePhotoPostRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreatePhotoPostRequest.fromMap(Map<String, dynamic> json) =>
      CreatePhotoPostRequest(
        title: json['title'],
        description: json['description'],
        userUid: json['user_uid'],
        location: json['location'],
        hashtags: json['hashtags'] == null
            ? []
            : List<String>.from(json['hashtags']!.map((x) => x)),
        postCreatorType: json['post_creator_type'],
        addressLatLongWkb: json['address_lat_long_wkb'],
        creatorLatLongWkb: json['creator_lat_long_wkb'],
        taggedUserUids: json['tagged_user_uids'] == null
            ? []
            : List<String>.from(json['tagged_user_uids']!.map((x) => x)),
        taggedCommunityUids: json['tagged_community_uids'] == null
            ? []
            : List<String>.from(json['tagged_community_uids']!.map((x) => x)),
        filesData: json['files_data'] == null
            ? []
            : List<FilesDatum>.from(
                json['files_data']!.map((x) => FilesDatum.fromMap(x)),),
      );

  Map<String, dynamic> toMap() => {
        'title': title,
        'description': description,
        'user_uid': userUid,
        'location': location,
        'hashtags':
            hashtags == null ? [] : List<dynamic>.from(hashtags!.map((x) => x)),
        'post_creator_type': postCreatorType,
        'address_lat_long_wkb': addressLatLongWkb,
        'creator_lat_long_wkb': creatorLatLongWkb,
        'tagged_user_uids': taggedUserUids == null
            ? []
            : List<dynamic>.from(taggedUserUids!.map((x) => x)),
        'tagged_community_uids': taggedCommunityUids == null
            ? []
            : List<dynamic>.from(taggedCommunityUids!.map((x) => x)),
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
