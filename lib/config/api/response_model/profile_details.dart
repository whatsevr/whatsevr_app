import 'dart:convert';

class ProfileDetailsResponse {
  final String? message;
  final UserInfo? userInfo;

  final List<UserEducation>? userEducations;
  final List<UserCoverMedia>? userCoverMedia;
  final List<UserPdf>? userPdfs;
  final List<UserService>? userServices;
  final List<UserWorkExperience>? userWorkExperiences;

  ProfileDetailsResponse({
    this.message,
    this.userInfo,
    this.userEducations,
    this.userCoverMedia,
    this.userPdfs,
    this.userServices,
    this.userWorkExperiences,
  });

  ProfileDetailsResponse copyWith({
    String? message,
    UserInfo? userInfo,
    List<UserEducation>? userEducations,
    List<UserCoverMedia>? userCoverMedia,
    List<UserPdf>? userPdfs,
    List<UserService>? userServices,
    List<UserWorkExperience>? userWorkExperiences,
  }) =>
      ProfileDetailsResponse(
        message: message ?? this.message,
        userInfo: userInfo ?? this.userInfo,
        userEducations: userEducations ?? this.userEducations,
        userCoverMedia: userCoverMedia ?? this.userCoverMedia,
        userPdfs: userPdfs ?? this.userPdfs,
        userServices: userServices ?? this.userServices,
        userWorkExperiences: userWorkExperiences ?? this.userWorkExperiences,
      );

  factory ProfileDetailsResponse.fromJson(String str) =>
      ProfileDetailsResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProfileDetailsResponse.fromMap(Map<String, dynamic> json) =>
      ProfileDetailsResponse(
        message: json["message"],
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
        userPdfs: json["user_pdfs"] == null
            ? []
            : List<UserPdf>.from(
                json["user_pdfs"]!.map((x) => UserPdf.fromMap(x))),
        userServices: json["user_services"] == null
            ? []
            : List<UserService>.from(
                json["user_services"]!.map((x) => UserService.fromMap(x))),
        userWorkExperiences: json["user_work_experiences"] == null
            ? []
            : List<UserWorkExperience>.from(json["user_work_experiences"]!
                .map((x) => UserWorkExperience.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "user_info": userInfo?.toMap(),
        "user_educations": userEducations == null
            ? []
            : List<dynamic>.from(userEducations!.map((x) => x.toMap())),
        "user_cover_media": userCoverMedia == null
            ? []
            : List<dynamic>.from(userCoverMedia!.map((x) => x.toMap())),
        "user_pdfs": userPdfs == null
            ? []
            : List<dynamic>.from(userPdfs!.map((x) => x.toMap())),
        "user_services": userServices == null
            ? []
            : List<dynamic>.from(userServices!.map((x) => x.toMap())),
        "user_work_experiences": userWorkExperiences == null
            ? []
            : List<dynamic>.from(userWorkExperiences!.map((x) => x.toMap())),
      };
}

class UserCoverMedia {
  final int? id;
  final DateTime? createdAt;
  final String? imageUrl;
  final bool? isVideo;
  final String? userUid;
  final dynamic videoUrl;

  UserCoverMedia({
    this.id,
    this.createdAt,
    this.imageUrl,
    this.isVideo,
    this.userUid,
    this.videoUrl,
  });

  UserCoverMedia copyWith({
    int? id,
    DateTime? createdAt,
    String? imageUrl,
    bool? isVideo,
    String? userUid,
    dynamic videoUrl,
  }) =>
      UserCoverMedia(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        imageUrl: imageUrl ?? this.imageUrl,
        isVideo: isVideo ?? this.isVideo,
        userUid: userUid ?? this.userUid,
        videoUrl: videoUrl ?? this.videoUrl,
      );

  factory UserCoverMedia.fromJson(String str) =>
      UserCoverMedia.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserCoverMedia.fromMap(Map<String, dynamic> json) => UserCoverMedia(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        imageUrl: json["image_url"],
        isVideo: json["is_video"],
        userUid: json["user_uid"],
        videoUrl: json["video_url"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "image_url": imageUrl,
        "is_video": isVideo,
        "user_uid": userUid,
        "video_url": videoUrl,
      };
}

class UserEducation {
  final int? id;
  final DateTime? createdAt;
  final String? userUid;
  final String? title;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? type;
  final String? institute;
  final bool? isOngoingEducation;

  UserEducation({
    this.id,
    this.createdAt,
    this.userUid,
    this.title,
    this.startDate,
    this.endDate,
    this.type,
    this.institute,
    this.isOngoingEducation,
  });

  UserEducation copyWith({
    int? id,
    DateTime? createdAt,
    String? userUid,
    String? title,
    DateTime? startDate,
    DateTime? endDate,
    String? type,
    String? institute,
    bool? isOngoingEducation,
  }) =>
      UserEducation(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        userUid: userUid ?? this.userUid,
        title: title ?? this.title,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        type: type ?? this.type,
        institute: institute ?? this.institute,
        isOngoingEducation: isOngoingEducation ?? this.isOngoingEducation,
      );

  factory UserEducation.fromJson(String str) =>
      UserEducation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserEducation.fromMap(Map<String, dynamic> json) => UserEducation(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        userUid: json["user_uid"],
        title: json["title"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        type: json["type"],
        institute: json["institute"],
        isOngoingEducation: json["is_ongoing_education"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "user_uid": userUid,
        "title": title,
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "type": type,
        "institute": institute,
        "is_ongoing_education": isOngoingEducation,
      };
}

class UserInfo {
  final int? id;
  final DateTime? registeredOn;
  final bool? isActive;
  final String? uid;
  final String? username;
  final String? mobileNumber;
  final String? emailId;
  final String? name;
  final String? bio;
  final String? address;
  final DateTime? dob;
  final String? profilePicture;
  final bool? isPortfolio;
  final String? portfolioStatus;
  final String? portfolioDescription;
  final bool? isBanned;
  final bool? isSpam;
  final bool? isDeactivated;
  final DateTime? portfolioCreatedAt;
  final String? portfolioTitle;
  final int? totalFollowers;
  final int? totalFollowings;
  final int? totalPostLikes;
  final String? gender;
  final bool? isOnline;
  final DateTime? lastActiveAt;
  final String? userLastLatLongWkb;

  UserInfo({
    this.id,
    this.registeredOn,
    this.isActive,
    this.uid,
    this.username,
    this.mobileNumber,
    this.emailId,
    this.name,
    this.bio,
    this.address,
    this.dob,
    this.profilePicture,
    this.isPortfolio,
    this.portfolioStatus,
    this.portfolioDescription,
    this.isBanned,
    this.isSpam,
    this.isDeactivated,
    this.portfolioCreatedAt,
    this.portfolioTitle,
    this.totalFollowers,
    this.totalFollowings,
    this.totalPostLikes,
    this.gender,
    this.isOnline,
    this.lastActiveAt,
    this.userLastLatLongWkb,
  });

  UserInfo copyWith({
    int? id,
    DateTime? registeredOn,
    bool? isActive,
    String? uid,
    String? username,
    String? mobileNumber,
    String? emailId,
    String? name,
    String? bio,
    String? address,
    DateTime? dob,
    String? profilePicture,
    bool? isPortfolio,
    String? portfolioStatus,
    String? portfolioDescription,
    bool? isBanned,
    bool? isSpam,
    bool? isDeactivated,
    DateTime? portfolioCreatedAt,
    String? portfolioTitle,
    int? totalFollowers,
    int? totalFollowings,
    int? totalPostLikes,
    String? gender,
    bool? isOnline,
    DateTime? lastActiveAt,
    String? userLastLatLongWkb,
  }) =>
      UserInfo(
        id: id ?? this.id,
        registeredOn: registeredOn ?? this.registeredOn,
        isActive: isActive ?? this.isActive,
        uid: uid ?? this.uid,
        username: username ?? this.username,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        emailId: emailId ?? this.emailId,
        name: name ?? this.name,
        bio: bio ?? this.bio,
        address: address ?? this.address,
        dob: dob ?? this.dob,
        profilePicture: profilePicture ?? this.profilePicture,
        isPortfolio: isPortfolio ?? this.isPortfolio,
        portfolioStatus: portfolioStatus ?? this.portfolioStatus,
        portfolioDescription: portfolioDescription ?? this.portfolioDescription,
        isBanned: isBanned ?? this.isBanned,
        isSpam: isSpam ?? this.isSpam,
        isDeactivated: isDeactivated ?? this.isDeactivated,
        portfolioCreatedAt: portfolioCreatedAt ?? this.portfolioCreatedAt,
        portfolioTitle: portfolioTitle ?? this.portfolioTitle,
        totalFollowers: totalFollowers ?? this.totalFollowers,
        totalFollowings: totalFollowings ?? this.totalFollowings,
        totalPostLikes: totalPostLikes ?? this.totalPostLikes,
        gender: gender ?? this.gender,
        isOnline: isOnline ?? this.isOnline,
        lastActiveAt: lastActiveAt ?? this.lastActiveAt,
        userLastLatLongWkb: userLastLatLongWkb ?? this.userLastLatLongWkb,
      );

  factory UserInfo.fromJson(String str) => UserInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserInfo.fromMap(Map<String, dynamic> json) => UserInfo(
        id: json["id"],
        registeredOn: json["registered_on"] == null
            ? null
            : DateTime.parse(json["registered_on"]),
        isActive: json["is_active"],
        uid: json["uid"],
        username: json["username"],
        mobileNumber: json["mobile_number"],
        emailId: json["email_id"],
        name: json["name"],
        bio: json["bio"],
        address: json["address"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        profilePicture: json["profile_picture"],
        isPortfolio: json["is_portfolio"],
        portfolioStatus: json["portfolio_status"],
        portfolioDescription: json["portfolio_description"],
        isBanned: json["is_banned"],
        isSpam: json["is_spam"],
        isDeactivated: json["is_deactivated"],
        portfolioCreatedAt: json["portfolio_created_at"] == null
            ? null
            : DateTime.parse(json["portfolio_created_at"]),
        portfolioTitle: json["portfolio_title"],
        totalFollowers: json["total_followers"],
        totalFollowings: json["total_followings"],
        totalPostLikes: json["total_post_likes"],
        gender: json["gender"],
        isOnline: json["is_online"],
        lastActiveAt: json["last_active_at"] == null
            ? null
            : DateTime.parse(json["last_active_at"]),
        userLastLatLongWkb: json["user_last_lat_long_wkb"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "registered_on": registeredOn?.toIso8601String(),
        "is_active": isActive,
        "uid": uid,
        "username": username,
        "mobile_number": mobileNumber,
        "email_id": emailId,
        "name": name,
        "bio": bio,
        "address": address,
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "profile_picture": profilePicture,
        "is_portfolio": isPortfolio,
        "portfolio_status": portfolioStatus,
        "portfolio_description": portfolioDescription,
        "is_banned": isBanned,
        "is_spam": isSpam,
        "is_deactivated": isDeactivated,
        "portfolio_created_at": portfolioCreatedAt?.toIso8601String(),
        "portfolio_title": portfolioTitle,
        "total_followers": totalFollowers,
        "total_followings": totalFollowings,
        "total_post_likes": totalPostLikes,
        "gender": gender,
        "is_online": isOnline,
        "last_active_at": lastActiveAt?.toIso8601String(),
        "user_last_lat_long_wkb": userLastLatLongWkb,
      };
}

class UserPdf {
  final int? id;
  final DateTime? createdAt;
  final String? fileUrl;
  final String? userUid;
  final String? title;
  final String? thumbnailUrl;

  UserPdf({
    this.id,
    this.createdAt,
    this.fileUrl,
    this.userUid,
    this.title,
    this.thumbnailUrl,
  });

  UserPdf copyWith({
    int? id,
    DateTime? createdAt,
    String? fileUrl,
    String? userUid,
    String? title,
    String? thumbnailUrl,
  }) =>
      UserPdf(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        fileUrl: fileUrl ?? this.fileUrl,
        userUid: userUid ?? this.userUid,
        title: title ?? this.title,
        thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      );

  factory UserPdf.fromJson(String str) => UserPdf.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserPdf.fromMap(Map<String, dynamic> json) => UserPdf(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        fileUrl: json["file_url"],
        userUid: json["user_uid"],
        title: json["title"],
        thumbnailUrl: json["thumbnail_url"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "file_url": fileUrl,
        "user_uid": userUid,
        "title": title,
        "thumbnail_url": thumbnailUrl,
      };
}

class UserService {
  final int? id;
  final DateTime? createdAt;
  final String? title;
  final String? userUid;
  final String? description;

  UserService({
    this.id,
    this.createdAt,
    this.title,
    this.userUid,
    this.description,
  });

  UserService copyWith({
    int? id,
    DateTime? createdAt,
    String? title,
    String? userUid,
    String? description,
  }) =>
      UserService(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        title: title ?? this.title,
        userUid: userUid ?? this.userUid,
        description: description ?? this.description,
      );

  factory UserService.fromJson(String str) =>
      UserService.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserService.fromMap(Map<String, dynamic> json) => UserService(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        title: json["title"],
        userUid: json["user_uid"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "title": title,
        "user_uid": userUid,
        "description": description,
      };
}

class UserVideoPost {
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
  final String? thumbnail;
  final String? videoUrl;
  final String? location;
  final String? videoDuration;
  final int? totalViews;
  final int? totalLikes;
  final int? totalComments;
  final String? internalAiDescription;
  final String? addressLatLongWkb;
  final String? creatorLatLongWkb;
  final List<String>? taggedCommunityUids;
  final int? totalShares;
  final int? retentionPercent;

  UserVideoPost({
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
    this.thumbnail,
    this.videoUrl,
    this.location,
    this.videoDuration,
    this.totalViews,
    this.totalLikes,
    this.totalComments,
    this.internalAiDescription,
    this.addressLatLongWkb,
    this.creatorLatLongWkb,
    this.taggedCommunityUids,
    this.totalShares,
    this.retentionPercent,
  });

  UserVideoPost copyWith({
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
    String? thumbnail,
    String? videoUrl,
    String? location,
    String? videoDuration,
    int? totalViews,
    int? totalLikes,
    int? totalComments,
    String? internalAiDescription,
    String? addressLatLongWkb,
    String? creatorLatLongWkb,
    List<String>? taggedCommunityUids,
    int? totalShares,
    int? retentionPercent,
  }) =>
      UserVideoPost(
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
        thumbnail: thumbnail ?? this.thumbnail,
        videoUrl: videoUrl ?? this.videoUrl,
        location: location ?? this.location,
        videoDuration: videoDuration ?? this.videoDuration,
        totalViews: totalViews ?? this.totalViews,
        totalLikes: totalLikes ?? this.totalLikes,
        totalComments: totalComments ?? this.totalComments,
        internalAiDescription:
            internalAiDescription ?? this.internalAiDescription,
        addressLatLongWkb: addressLatLongWkb ?? this.addressLatLongWkb,
        creatorLatLongWkb: creatorLatLongWkb ?? this.creatorLatLongWkb,
        taggedCommunityUids: taggedCommunityUids ?? this.taggedCommunityUids,
        totalShares: totalShares ?? this.totalShares,
        retentionPercent: retentionPercent ?? this.retentionPercent,
      );

  factory UserVideoPost.fromJson(String str) =>
      UserVideoPost.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserVideoPost.fromMap(Map<String, dynamic> json) => UserVideoPost(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        uid: json["uid"],
        title: json["title"],
        description: json["description"],
        hashtags: json["hashtags"] == null
            ? []
            : List<String>.from(json["hashtags"]!.map((x) => x)),
        taggedUserUids: json["tagged_user_uids"] == null
            ? []
            : List<String>.from(json["tagged_user_uids"]!.map((x) => x)),
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
        videoDuration: json["video_duration"],
        totalViews: json["total_views"],
        totalLikes: json["total_likes"],
        totalComments: json["total_comments"],
        internalAiDescription: json["internal_ai_description"],
        addressLatLongWkb: json["address_lat_long_wkb"],
        creatorLatLongWkb: json["creator_lat_long_wkb"],
        taggedCommunityUids: json["tagged_community_uids"] == null
            ? []
            : List<String>.from(json["tagged_community_uids"]!.map((x) => x)),
        totalShares: json["total_shares"],
        retentionPercent: json["retention_percent"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "uid": uid,
        "title": title,
        "description": description,
        "hashtags":
            hashtags == null ? [] : List<dynamic>.from(hashtags!.map((x) => x)),
        "tagged_user_uids": taggedUserUids == null
            ? []
            : List<dynamic>.from(taggedUserUids!.map((x) => x)),
        "is_deleted": isDeleted,
        "is_archived": isArchived,
        "is_active": isActive,
        "post_creator_type": postCreatorType,
        "updated_at": updatedAt?.toIso8601String(),
        "user_uid": userUid,
        "thumbnail": thumbnail,
        "video_url": videoUrl,
        "location": location,
        "video_duration": videoDuration,
        "total_views": totalViews,
        "total_likes": totalLikes,
        "total_comments": totalComments,
        "internal_ai_description": internalAiDescription,
        "address_lat_long_wkb": addressLatLongWkb,
        "creator_lat_long_wkb": creatorLatLongWkb,
        "tagged_community_uids": taggedCommunityUids == null
            ? []
            : List<dynamic>.from(taggedCommunityUids!.map((x) => x)),
        "total_shares": totalShares,
        "retention_percent": retentionPercent,
      };
}

class UserWorkExperience {
  final int? id;
  final DateTime? createdAt;
  final String? designation;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? userUid;
  final String? workingMode;
  final bool? isCurrentlyWorking;
  final String? companyName;

  UserWorkExperience({
    this.id,
    this.createdAt,
    this.designation,
    this.startDate,
    this.endDate,
    this.userUid,
    this.workingMode,
    this.isCurrentlyWorking,
    this.companyName,
  });

  UserWorkExperience copyWith({
    int? id,
    DateTime? createdAt,
    String? designation,
    DateTime? startDate,
    DateTime? endDate,
    String? userUid,
    String? workingMode,
    bool? isCurrentlyWorking,
    String? companyName,
  }) =>
      UserWorkExperience(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        designation: designation ?? this.designation,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        userUid: userUid ?? this.userUid,
        workingMode: workingMode ?? this.workingMode,
        isCurrentlyWorking: isCurrentlyWorking ?? this.isCurrentlyWorking,
        companyName: companyName ?? this.companyName,
      );

  factory UserWorkExperience.fromJson(String str) =>
      UserWorkExperience.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserWorkExperience.fromMap(Map<String, dynamic> json) =>
      UserWorkExperience(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        designation: json["designation"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        userUid: json["user_uid"],
        workingMode: json["working_mode"],
        isCurrentlyWorking: json["is_currently_working"],
        companyName: json["company_name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "designation": designation,
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "user_uid": userUid,
        "working_mode": workingMode,
        "is_currently_working": isCurrentlyWorking,
        "company_name": companyName,
      };
}
