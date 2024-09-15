import 'dart:convert';

class ProfileDetailsResponse {
  final String? message;
  final UserInfo? userInfo;
  final List<UserVideoPost>? userVideoPosts;
  final List<UserEducation>? userEducations;
  final List<UserCoverMedia>? userCoverMedia;
  final List<UserPdf>? userPdfs;
  final List<UserService>? userServices;
  final List<UserWorkExperience>? userWorkExperiences;

  ProfileDetailsResponse({
    this.message,
    this.userInfo,
    this.userVideoPosts,
    this.userEducations,
    this.userCoverMedia,
    this.userPdfs,
    this.userServices,
    this.userWorkExperiences,
  });

  factory ProfileDetailsResponse.fromJson(String str) =>
      ProfileDetailsResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProfileDetailsResponse.fromMap(Map<String, dynamic> json) =>
      ProfileDetailsResponse(
        message: json['message'],
        userInfo: json['user_info'] == null
            ? null
            : UserInfo.fromMap(json['user_info']),
        userVideoPosts: json['user_video_posts'] == null
            ? <UserVideoPost>[]
            : List<UserVideoPost>.from(
                json['user_video_posts']!.map((x) => UserVideoPost.fromMap(x)),
              ),
        userEducations: json['user_educations'] == null
            ? <UserEducation>[]
            : List<UserEducation>.from(
                json['user_educations']!.map((x) => UserEducation.fromMap(x)),
              ),
        userCoverMedia: json['user_cover_media'] == null
            ? <UserCoverMedia>[]
            : List<UserCoverMedia>.from(
                json['user_cover_media']!.map((x) => UserCoverMedia.fromMap(x)),
              ),
        userPdfs: json['user_pdfs'] == null
            ? <UserPdf>[]
            : List<UserPdf>.from(
                json['user_pdfs']!.map((x) => UserPdf.fromMap(x)),
              ),
        userServices: json['user_services'] == null
            ? <UserService>[]
            : List<UserService>.from(
                json['user_services']!.map((x) => UserService.fromMap(x)),
              ),
        userWorkExperiences: json['user_work_experiences'] == null
            ? <UserWorkExperience>[]
            : List<UserWorkExperience>.from(
                json['user_work_experiences']!
                    .map((x) => UserWorkExperience.fromMap(x)),
              ),
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'message': message,
        'user_info': userInfo?.toMap(),
        'user_video_posts': userVideoPosts == null
            ? <dynamic>[]
            : List<dynamic>.from(
                userVideoPosts!.map((UserVideoPost x) => x.toMap()),),
        'user_educations': userEducations == null
            ? <dynamic>[]
            : List<dynamic>.from(
                userEducations!.map((UserEducation x) => x.toMap()),),
        'user_cover_media': userCoverMedia == null
            ? <dynamic>[]
            : List<dynamic>.from(
                userCoverMedia!.map((UserCoverMedia x) => x.toMap()),),
        'user_pdfs': userPdfs == null
            ? <dynamic>[]
            : List<dynamic>.from(userPdfs!.map((UserPdf x) => x.toMap())),
        'user_services': userServices == null
            ? <dynamic>[]
            : List<dynamic>.from(
                userServices!.map((UserService x) => x.toMap()),),
        'user_work_experiences': userWorkExperiences == null
            ? <dynamic>[]
            : List<dynamic>.from(
                userWorkExperiences!.map((UserWorkExperience x) => x.toMap()),),
      };
}

class UserCoverMedia {
  final int? id;
  final DateTime? createdAt;
  final String? imageUrl;
  final bool? isVideo;
  final String? userUid;
  final String? videoUrl;

  UserCoverMedia({
    this.id,
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
        id: json['id'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        imageUrl: json['image_url'],
        isVideo: json['is_video'],
        userUid: json['user_uid'],
        videoUrl: json['video_url'],
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'created_at': createdAt?.toIso8601String(),
        'image_url': imageUrl,
        'is_video': isVideo,
        'user_uid': userUid,
        'video_url': videoUrl,
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
  final dynamic institute;
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

  factory UserEducation.fromJson(String str) =>
      UserEducation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserEducation.fromMap(Map<String, dynamic> json) => UserEducation(
        id: json['id'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        userUid: json['user_uid'],
        title: json['title'],
        startDate: json['start_date'] == null
            ? null
            : DateTime.parse(json['start_date']),
        endDate:
            json['end_date'] == null ? null : DateTime.parse(json['end_date']),
        type: json['type'],
        institute: json['institute'],
        isOngoingEducation: json['is_ongoing_education'],
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'created_at': createdAt?.toIso8601String(),
        'user_uid': userUid,
        'title': title,
        'start_date':
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        'end_date':
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        'type': type,
        'institute': institute,
        'is_ongoing_education': isOngoingEducation,
      };
}

class UserInfo {
  final int? id;
  final DateTime? registeredOn;
  final bool? isActive;
  final String? uid;
  final String? userName;
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
  final bool? isDiactivated;
  final DateTime? portfolioCreatedAt;
  final String? portfolioTitle;
  final int? totalFollowers;
  final int? totalFollowings;
  final int? totalPostLikes;
  final String? gender;

  UserInfo({
    this.id,
    this.registeredOn,
    this.isActive,
    this.uid,
    this.userName,
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
    this.isDiactivated,
    this.portfolioCreatedAt,
    this.portfolioTitle,
    this.totalFollowers,
    this.totalFollowings,
    this.totalPostLikes,
    this.gender,
  });

  factory UserInfo.fromJson(String str) => UserInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserInfo.fromMap(Map<String, dynamic> json) => UserInfo(
        id: json['id'],
        registeredOn: json['registered_on'] == null
            ? null
            : DateTime.parse(json['registered_on']),
        isActive: json['is_active'],
        uid: json['uid'],
        userName: json['user_name'],
        mobileNumber: json['mobile_number'],
        emailId: json['email_id'],
        name: json['name'],
        bio: json['bio'],
        address: json['address'],
        dob: json['dob'] == null ? null : DateTime.parse(json['dob']),
        profilePicture: json['profile_picture'],
        isPortfolio: json['is_portfolio'],
        portfolioStatus: json['portfolio_status'],
        portfolioDescription: json['portfolio_description'],
        isBanned: json['is_banned'],
        isSpam: json['is_spam'],
        isDiactivated: json['is_diactivated'],
        portfolioCreatedAt: json['portfolio_created_at'] == null
            ? null
            : DateTime.parse(json['portfolio_created_at']),
        portfolioTitle: json['portfolio_title'],
        totalFollowers: json['total_followers'],
        totalFollowings: json['total_followings'],
        totalPostLikes: json['total_post_likes'],
        gender: json['gender'],
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'registered_on': registeredOn?.toIso8601String(),
        'is_active': isActive,
        'uid': uid,
        'user_name': userName,
        'mobile_number': mobileNumber,
        'email_id': emailId,
        'name': name,
        'bio': bio,
        'address': address,
        'dob':
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        'profile_picture': profilePicture,
        'is_portfolio': isPortfolio,
        'portfolio_status': portfolioStatus,
        'portfolio_description': portfolioDescription,
        'is_banned': isBanned,
        'is_spam': isSpam,
        'is_diactivated': isDiactivated,
        'portfolio_created_at': portfolioCreatedAt?.toIso8601String(),
        'portfolio_title': portfolioTitle,
        'total_followers': totalFollowers,
        'total_followings': totalFollowings,
        'total_post_likes': totalPostLikes,
        'gender': gender,
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

  factory UserPdf.fromJson(String str) => UserPdf.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserPdf.fromMap(Map<String, dynamic> json) => UserPdf(
        id: json['id'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        fileUrl: json['file_url'],
        userUid: json['user_uid'],
        title: json['title'],
        thumbnailUrl: json['thumbnail_url'],
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'created_at': createdAt?.toIso8601String(),
        'file_url': fileUrl,
        'user_uid': userUid,
        'title': title,
        'thumbnail_url': thumbnailUrl,
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

  factory UserService.fromJson(String str) =>
      UserService.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserService.fromMap(Map<String, dynamic> json) => UserService(
        id: json['id'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        title: json['title'],
        userUid: json['user_uid'],
        description: json['description'],
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'created_at': createdAt?.toIso8601String(),
        'title': title,
        'user_uid': userUid,
        'description': description,
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
  final dynamic locationLatitude;
  final dynamic locationLongitude;
  final String? videoDuration;
  final int? totalViews;
  final int? totalLikes;
  final int? totalComments;
  final dynamic internalAiPostDescription;
  final dynamic internalAiPostTags;

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
    this.locationLatitude,
    this.locationLongitude,
    this.videoDuration,
    this.totalViews,
    this.totalLikes,
    this.totalComments,
    this.internalAiPostDescription,
    this.internalAiPostTags,
  });

  factory UserVideoPost.fromJson(String str) =>
      UserVideoPost.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserVideoPost.fromMap(Map<String, dynamic> json) => UserVideoPost(
        id: json['id'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        uid: json['uid'],
        title: json['title'],
        description: json['description'],
        hashtags: json['hashtags'] == null
            ? <String>[]
            : List<String>.from(json['hashtags']!.map((x) => x)),
        taggedUserUids: json['tagged_user_uids'] == null
            ? <String>[]
            : List<String>.from(json['tagged_user_uids']!.map((x) => x)),
        isDeleted: json['is_deleted'],
        isArchived: json['is_archived'],
        isActive: json['is_active'],
        postCreatorType: json['post_creator_type'],
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at']),
        userUid: json['user_uid'],
        thumbnail: json['thumbnail'],
        videoUrl: json['video_url'],
        location: json['location'],
        locationLatitude: json['location_latitude'],
        locationLongitude: json['location_longitude'],
        videoDuration: json['video_duration'],
        totalViews: json['total_views'],
        totalLikes: json['total_likes'],
        totalComments: json['total_comments'],
        internalAiPostDescription: json['internal_ai_post_description'],
        internalAiPostTags: json['internal_ai_post_tags'],
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'created_at': createdAt?.toIso8601String(),
        'uid': uid,
        'title': title,
        'description': description,
        'hashtags': hashtags == null
            ? <dynamic>[]
            : List<dynamic>.from(hashtags!.map((String x) => x)),
        'tagged_user_uids': taggedUserUids == null
            ? <dynamic>[]
            : List<dynamic>.from(taggedUserUids!.map((String x) => x)),
        'is_deleted': isDeleted,
        'is_archived': isArchived,
        'is_active': isActive,
        'post_creator_type': postCreatorType,
        'updated_at': updatedAt?.toIso8601String(),
        'user_uid': userUid,
        'thumbnail': thumbnail,
        'video_url': videoUrl,
        'location': location,
        'location_latitude': locationLatitude,
        'location_longitude': locationLongitude,
        'video_duration': videoDuration,
        'total_views': totalViews,
        'total_likes': totalLikes,
        'total_comments': totalComments,
        'internal_ai_post_description': internalAiPostDescription,
        'internal_ai_post_tags': internalAiPostTags,
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

  factory UserWorkExperience.fromJson(String str) =>
      UserWorkExperience.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserWorkExperience.fromMap(Map<String, dynamic> json) =>
      UserWorkExperience(
        id: json['id'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        designation: json['designation'],
        startDate: json['start_date'] == null
            ? null
            : DateTime.parse(json['start_date']),
        endDate:
            json['end_date'] == null ? null : DateTime.parse(json['end_date']),
        userUid: json['user_uid'],
        workingMode: json['working_mode'],
        isCurrentlyWorking: json['is_currently_working'],
        companyName: json['company_name'],
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'created_at': createdAt?.toIso8601String(),
        'designation': designation,
        'start_date':
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        'end_date':
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        'user_uid': userUid,
        'working_mode': workingMode,
        'is_currently_working': isCurrentlyWorking,
        'company_name': companyName,
      };
}
