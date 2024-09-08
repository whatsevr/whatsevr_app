import 'dart:convert';

class ProfileUpdateRequest {
  final String? userUid;
  final UserInfo? userInfo;
  final List<UserEducation>? userEducations;
  final List<UserCoverMedia>? userCoverMedia;
  final List<UserService>? userServices;

  ProfileUpdateRequest({
    this.userUid,
    this.userInfo,
    this.userEducations,
    this.userCoverMedia,
    this.userServices,
  });

  factory ProfileUpdateRequest.fromJson(String str) =>
      ProfileUpdateRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProfileUpdateRequest.fromMap(Map<String, dynamic> json) =>
      ProfileUpdateRequest(
        userUid: json["user_uid"],
        userInfo: json["user_info"] == null
            ? null
            : UserInfo.fromMap(json["user_info"]),
        userEducations: json["user_educations"] == null
            ? []
            : List<UserEducation>.from(
                json["user_educations"]!.map((x) => UserEducation.fromMap(x))),
        userCoverMedia: json["user_cover_media"] == null
            ? []
            : List<UserCoverMedia>.from(json["user_cover_media"]!
                .map((x) => UserCoverMedia.fromMap(x))),
        userServices: json["user_services"] == null
            ? []
            : List<UserService>.from(
                json["user_services"]!.map((x) => UserService.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "user_uid": userUid,
        "user_info": userInfo?.toMap(),
        "user_educations": userEducations == null
            ? []
            : List<dynamic>.from(userEducations!.map((x) => x.toMap())),
        "user_cover_media": userCoverMedia == null
            ? []
            : List<dynamic>.from(userCoverMedia!.map((x) => x.toMap())),
        "user_services": userServices == null
            ? []
            : List<dynamic>.from(userServices!.map((x) => x.toMap())),
      };
}

class UserCoverMedia {
  final DateTime? createdAt;
  final String? imageUrl;
  final bool? isVideo;
  final String? userUid;
  final String? videoUrl;

  UserCoverMedia({
    this.createdAt,
    this.imageUrl,
    this.isVideo,
    this.userUid,
    this.videoUrl,
  });

  factory UserCoverMedia.fromJson(String str) =>
      UserCoverMedia.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserCoverMedia.fromMap(Map<String, dynamic> json) => UserCoverMedia(
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        imageUrl: json["image_url"],
        isVideo: json["is_video"],
        userUid: json["user_uid"],
        videoUrl: json["video_url"],
      );

  Map<String, dynamic> toMap() => {
        "created_at": createdAt?.toIso8601String(),
        "image_url": imageUrl,
        "is_video": isVideo,
        "user_uid": userUid,
        "video_url": videoUrl,
      };
}

class UserEducation {
  final DateTime? createdAt;
  final String? userUid;
  final String? name;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? type;

  UserEducation({
    this.createdAt,
    this.userUid,
    this.name,
    this.startDate,
    this.endDate,
    this.type,
  });

  factory UserEducation.fromJson(String str) =>
      UserEducation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserEducation.fromMap(Map<String, dynamic> json) => UserEducation(
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        userUid: json["user_uid"],
        name: json["name"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        type: json["type"],
      );

  Map<String, dynamic> toMap() => {
        "created_at": createdAt?.toIso8601String(),
        "user_uid": userUid,
        "name": name,
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "type": type,
      };
}

class UserInfo {
  final String? emailId;
  final String? name;
  final String? bio;
  final String? address;
  final DateTime? dob;
  final String? profilePicture;
  final String? portfolioStatus;
  final String? portfolioDescription;
  final String? portfolioTitle;

  UserInfo({
    this.emailId,
    this.name,
    this.bio,
    this.address,
    this.dob,
    this.profilePicture,
    this.portfolioStatus,
    this.portfolioDescription,
    this.portfolioTitle,
  });

  factory UserInfo.fromJson(String str) => UserInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserInfo.fromMap(Map<String, dynamic> json) => UserInfo(
        emailId: json["email_id"],
        name: json["name"],
        bio: json["bio"],
        address: json["address"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        profilePicture: json["profile_picture"],
        portfolioStatus: json["portfolio_status"],
        portfolioDescription: json["portfolio_description"],
        portfolioTitle: json["portfolio_title"],
      );

  Map<String, dynamic> toMap() => {
        "email_id": emailId,
        "name": name,
        "bio": bio,
        "address": address,
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "profile_picture": profilePicture,
        "portfolio_status": portfolioStatus,
        "portfolio_description": portfolioDescription,
        "portfolio_title": portfolioTitle,
      };
}

class UserService {
  final DateTime? createdAt;
  final String? title;
  final String? userUid;
  final String? description;

  UserService({
    this.createdAt,
    this.title,
    this.userUid,
    this.description,
  });

  factory UserService.fromJson(String str) =>
      UserService.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserService.fromMap(Map<String, dynamic> json) => UserService(
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        title: json["title"],
        userUid: json["user_uid"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "created_at": createdAt?.toIso8601String(),
        "title": title,
        "user_uid": userUid,
        "description": description,
      };
}
