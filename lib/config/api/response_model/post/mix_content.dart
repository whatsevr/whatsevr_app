import 'dart:convert';

class UserAndCommunityMixContentResponse {
  String? message;
  List<MixContent>? mixContent;
  bool? lastPage;
  int? page;
  int? totalItems;
  ContentCounts? contentCounts;

  UserAndCommunityMixContentResponse({
    this.message,
    this.mixContent,
    this.lastPage,
    this.page,
    this.totalItems,
    this.contentCounts,
  });

  UserAndCommunityMixContentResponse copyWith({
    String? message,
    List<MixContent>? mixContent,
    bool? lastPage,
    int? page,
    int? totalItems,
    ContentCounts? contentCounts,
  }) =>
      UserAndCommunityMixContentResponse(
        message: message ?? this.message,
        mixContent: mixContent ?? this.mixContent,
        lastPage: lastPage ?? this.lastPage,
        page: page ?? this.page,
        totalItems: totalItems ?? this.totalItems,
        contentCounts: contentCounts ?? this.contentCounts,
      );

  factory UserAndCommunityMixContentResponse.fromJson(String str) =>
      UserAndCommunityMixContentResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserAndCommunityMixContentResponse.fromMap(
    Map<String, dynamic> json,
  ) =>
      UserAndCommunityMixContentResponse(
        message: json['message'],
        mixContent: json['mix_content'] == null
            ? []
            : List<MixContent>.from(
                json['mix_content']!.map((x) => MixContent.fromMap(x)),
              ),
        lastPage: json['last_page'],
        page: json['page'],
        totalItems: json['total_items'],
        contentCounts: json['contentCounts'] == null
            ? null
            : ContentCounts.fromMap(json['contentCounts']),
      );

  Map<String, dynamic> toMap() => {
        'message': message,
        'mix_content': mixContent == null
            ? []
            : List<dynamic>.from(mixContent!.map((x) => x.toMap())),
        'last_page': lastPage,
        'page': page,
        'total_items': totalItems,
        'contentCounts': contentCounts?.toMap(),
      };
}

class ContentCounts {
  int? flicks;
  int? photos;
  int? offers;
  int? videos;

  ContentCounts({
    this.flicks,
    this.photos,
    this.offers,
    this.videos,
  });

  ContentCounts copyWith({
    int? flicks,
    int? photos,
    int? offers,
    int? videos,
  }) =>
      ContentCounts(
        flicks: flicks ?? this.flicks,
        photos: photos ?? this.photos,
        offers: offers ?? this.offers,
        videos: videos ?? this.videos,
      );

  factory ContentCounts.fromJson(String str) =>
      ContentCounts.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ContentCounts.fromMap(Map<String, dynamic> json) => ContentCounts(
        flicks: json['flicks'],
        photos: json['photos'],
        offers: json['offers'],
        videos: json['videos'],
      );

  Map<String, dynamic> toMap() => {
        'flicks': flicks,
        'photos': photos,
        'offers': offers,
        'videos': videos,
      };
}

class MixContent {
  String? type;
  Content? content;

  MixContent({
    this.type,
    this.content,
  });

  MixContent copyWith({
    String? type,
    Content? content,
  }) =>
      MixContent(
        type: type ?? this.type,
        content: content ?? this.content,
      );

  factory MixContent.fromJson(String str) =>
      MixContent.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MixContent.fromMap(Map<String, dynamic> json) => MixContent(
        type: json['type'],
        content:
            json['content'] == null ? null : Content.fromMap(json['content']),
      );

  Map<String, dynamic> toMap() => {
        'type': type,
        'content': content?.toMap(),
      };
}

class Content {
  DateTime? createdAt;
  String? uid;
  String? title;
  String? description;
  List<String>? hashtags;
  dynamic taggedUserUids;
  bool? isDeleted;
  bool? isArchived;
  bool? isActive;
  String? postCreatorType;
  DateTime? updatedAt;
  String? userUid;
  String? thumbnail;
  String? videoUrl;
  String? location;
  int? totalViews;
  int? totalLikes;
  int? totalComments;
  String? internalAiDescription;
  dynamic addressLatLongWkb;
  dynamic creatorLatLongWkb;
  dynamic taggedCommunityUids;
  int? totalShares;
  int? cumulativeScore;
  int? videoDurationInSec;
  String? seoDataWeighted;
  dynamic communityUid;
  User? user;
  int? totalImpressions;
  List<FilesDatum>? filesData;
  String? ctaAction;
  String? ctaActionUrl;
  String? status;
  String? targetGender;
  List<String>? targetAreas;

  Content({
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
    this.totalViews,
    this.totalLikes,
    this.totalComments,
    this.internalAiDescription,
    this.addressLatLongWkb,
    this.creatorLatLongWkb,
    this.taggedCommunityUids,
    this.totalShares,
    this.cumulativeScore,
    this.videoDurationInSec,
    this.seoDataWeighted,
    this.communityUid,
    this.user,
    this.totalImpressions,
    this.filesData,
    this.ctaAction,
    this.ctaActionUrl,
    this.status,
    this.targetGender,
    this.targetAreas,
  });

  Content copyWith({
    DateTime? createdAt,
    String? uid,
    String? title,
    String? description,
    List<String>? hashtags,
    dynamic taggedUserUids,
    bool? isDeleted,
    bool? isArchived,
    bool? isActive,
    String? postCreatorType,
    DateTime? updatedAt,
    String? userUid,
    String? thumbnail,
    String? videoUrl,
    String? location,
    int? totalViews,
    int? totalLikes,
    int? totalComments,
    String? internalAiDescription,
    dynamic addressLatLongWkb,
    dynamic creatorLatLongWkb,
    dynamic taggedCommunityUids,
    int? totalShares,
    int? cumulativeScore,
    int? videoDurationInSec,
    String? seoDataWeighted,
    dynamic communityUid,
    User? user,
    int? totalImpressions,
    List<FilesDatum>? filesData,
    String? ctaAction,
    String? ctaActionUrl,
    String? status,
    String? targetGender,
    List<String>? targetAreas,
  }) =>
      Content(
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
        totalViews: totalViews ?? this.totalViews,
        totalLikes: totalLikes ?? this.totalLikes,
        totalComments: totalComments ?? this.totalComments,
        internalAiDescription:
            internalAiDescription ?? this.internalAiDescription,
        addressLatLongWkb: addressLatLongWkb ?? this.addressLatLongWkb,
        creatorLatLongWkb: creatorLatLongWkb ?? this.creatorLatLongWkb,
        taggedCommunityUids: taggedCommunityUids ?? this.taggedCommunityUids,
        totalShares: totalShares ?? this.totalShares,
        cumulativeScore: cumulativeScore ?? this.cumulativeScore,
        videoDurationInSec: videoDurationInSec ?? this.videoDurationInSec,
        seoDataWeighted: seoDataWeighted ?? this.seoDataWeighted,
        communityUid: communityUid ?? this.communityUid,
        user: user ?? this.user,
        totalImpressions: totalImpressions ?? this.totalImpressions,
        filesData: filesData ?? this.filesData,
        ctaAction: ctaAction ?? this.ctaAction,
        ctaActionUrl: ctaActionUrl ?? this.ctaActionUrl,
        status: status ?? this.status,
        targetGender: targetGender ?? this.targetGender,
        targetAreas: targetAreas ?? this.targetAreas,
      );

  factory Content.fromJson(String str) => Content.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Content.fromMap(Map<String, dynamic> json) => Content(
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        uid: json['uid'],
        title: json['title'],
        description: json['description'],
        hashtags: json['hashtags'] == null
            ? []
            : List<String>.from(json['hashtags']!.map((x) => x)),
        taggedUserUids: json['tagged_user_uids'],
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
        totalViews: json['total_views'],
        totalLikes: json['total_likes'],
        totalComments: json['total_comments'],
        internalAiDescription: json['internal_ai_description'],
        addressLatLongWkb: json['address_lat_long_wkb'],
        creatorLatLongWkb: json['creator_lat_long_wkb'],
        taggedCommunityUids: json['tagged_community_uids'],
        totalShares: json['total_shares'],
        cumulativeScore: json['cumulative_score'],
        videoDurationInSec: json['video_duration_in_sec'],
        seoDataWeighted: json['seo_data_weighted'],
        communityUid: json['community_uid'],
        user: json['user'] == null ? null : User.fromMap(json['user']),
        totalImpressions: json['total_impressions'],
        filesData: json['files_data'] == null
            ? []
            : List<FilesDatum>.from(
                json['files_data']!.map((x) => FilesDatum.fromMap(x)),
              ),
        ctaAction: json['cta_action'],
        ctaActionUrl: json['cta_action_url'],
        status: json['status'],
        targetGender: json['target_gender'],
        targetAreas: json['target_areas'] == null
            ? []
            : List<String>.from(json['target_areas']!.map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        'created_at': createdAt?.toIso8601String(),
        'uid': uid,
        'title': title,
        'description': description,
        'hashtags':
            hashtags == null ? [] : List<dynamic>.from(hashtags!.map((x) => x)),
        'tagged_user_uids': taggedUserUids,
        'is_deleted': isDeleted,
        'is_archived': isArchived,
        'is_active': isActive,
        'post_creator_type': postCreatorType,
        'updated_at': updatedAt?.toIso8601String(),
        'user_uid': userUid,
        'thumbnail': thumbnail,
        'video_url': videoUrl,
        'location': location,
        'total_views': totalViews,
        'total_likes': totalLikes,
        'total_comments': totalComments,
        'internal_ai_description': internalAiDescription,
        'address_lat_long_wkb': addressLatLongWkb,
        'creator_lat_long_wkb': creatorLatLongWkb,
        'tagged_community_uids': taggedCommunityUids,
        'total_shares': totalShares,
        'cumulative_score': cumulativeScore,
        'video_duration_in_sec': videoDurationInSec,
        'seo_data_weighted': seoDataWeighted,
        'community_uid': communityUid,
        'user': user?.toMap(),
        'total_impressions': totalImpressions,
        'files_data': filesData == null
            ? []
            : List<dynamic>.from(filesData!.map((x) => x.toMap())),
        'cta_action': ctaAction,
        'cta_action_url': ctaActionUrl,
        'status': status,
        'target_gender': targetGender,
        'target_areas': targetAreas == null
            ? []
            : List<dynamic>.from(targetAreas!.map((x) => x)),
      };
}

class FilesDatum {
  String? type;
  String? imageUrl;

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

class User {
  String? bio;
  dynamic dob;
  String? uid;
  String? name;
  dynamic gender;
  String? address;
  bool? isSpam;
  String? emailId;
  String? username;
  bool? isBanned;
  bool? isOnline;
  int? totalLikes;
  bool? isPortfolio;
  String? mobileNumber;
  DateTime? registeredOn;
  bool? isDeactivated;
  DateTime? lastActiveAt;
  String? portfolioTitle;
  String? profilePicture;
  String? publicEmailId;
  int? totalFollowers;
  String? portfolioStatus;
  int? totalFollowings;
  int? totalPostLikes;
  String? seoDataWeighted;
  int? totalConnections;
  dynamic portfolioCreatedAt;
  String? portfolioDescription;
  dynamic userLastLatLongWkb;

  User({
    this.bio,
    this.dob,
    this.uid,
    this.name,
    this.gender,
    this.address,
    this.isSpam,
    this.emailId,
    this.username,
    this.isBanned,
    this.isOnline,
    this.totalLikes,
    this.isPortfolio,
    this.mobileNumber,
    this.registeredOn,
    this.isDeactivated,
    this.lastActiveAt,
    this.portfolioTitle,
    this.profilePicture,
    this.publicEmailId,
    this.totalFollowers,
    this.portfolioStatus,
    this.totalFollowings,
    this.totalPostLikes,
    this.seoDataWeighted,
    this.totalConnections,
    this.portfolioCreatedAt,
    this.portfolioDescription,
    this.userLastLatLongWkb,
  });

  User copyWith({
    String? bio,
    dynamic dob,
    String? uid,
    String? name,
    dynamic gender,
    String? address,
    bool? isSpam,
    String? emailId,
    String? username,
    bool? isBanned,
    bool? isOnline,
    int? totalLikes,
    bool? isPortfolio,
    String? mobileNumber,
    DateTime? registeredOn,
    bool? isDeactivated,
    DateTime? lastActiveAt,
    String? portfolioTitle,
    String? profilePicture,
    String? publicEmailId,
    int? totalFollowers,
    String? portfolioStatus,
    int? totalFollowings,
    int? totalPostLikes,
    String? seoDataWeighted,
    int? totalConnections,
    dynamic portfolioCreatedAt,
    String? portfolioDescription,
    dynamic userLastLatLongWkb,
  }) =>
      User(
        bio: bio ?? this.bio,
        dob: dob ?? this.dob,
        uid: uid ?? this.uid,
        name: name ?? this.name,
        gender: gender ?? this.gender,
        address: address ?? this.address,
        isSpam: isSpam ?? this.isSpam,
        emailId: emailId ?? this.emailId,
        username: username ?? this.username,
        isBanned: isBanned ?? this.isBanned,
        isOnline: isOnline ?? this.isOnline,
        totalLikes: totalLikes ?? this.totalLikes,
        isPortfolio: isPortfolio ?? this.isPortfolio,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        registeredOn: registeredOn ?? this.registeredOn,
        isDeactivated: isDeactivated ?? this.isDeactivated,
        lastActiveAt: lastActiveAt ?? this.lastActiveAt,
        portfolioTitle: portfolioTitle ?? this.portfolioTitle,
        profilePicture: profilePicture ?? this.profilePicture,
        publicEmailId: publicEmailId ?? this.publicEmailId,
        totalFollowers: totalFollowers ?? this.totalFollowers,
        portfolioStatus: portfolioStatus ?? this.portfolioStatus,
        totalFollowings: totalFollowings ?? this.totalFollowings,
        totalPostLikes: totalPostLikes ?? this.totalPostLikes,
        seoDataWeighted: seoDataWeighted ?? this.seoDataWeighted,
        totalConnections: totalConnections ?? this.totalConnections,
        portfolioCreatedAt: portfolioCreatedAt ?? this.portfolioCreatedAt,
        portfolioDescription: portfolioDescription ?? this.portfolioDescription,
        userLastLatLongWkb: userLastLatLongWkb ?? this.userLastLatLongWkb,
      );

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        bio: json['bio'],
        dob: json['dob'],
        uid: json['uid'],
        name: json['name'],
        gender: json['gender'],
        address: json['address'],
        isSpam: json['is_spam'],
        emailId: json['email_id'],
        username: json['username'],
        isBanned: json['is_banned'],
        isOnline: json['is_online'],
        totalLikes: json['total_likes'],
        isPortfolio: json['is_portfolio'],
        mobileNumber: json['mobile_number'],
        registeredOn: json['registered_on'] == null
            ? null
            : DateTime.parse(json['registered_on']),
        isDeactivated: json['is_deactivated'],
        lastActiveAt: json['last_active_at'] == null
            ? null
            : DateTime.parse(json['last_active_at']),
        portfolioTitle: json['portfolio_title'],
        profilePicture: json['profile_picture'],
        publicEmailId: json['public_email_id'],
        totalFollowers: json['total_followers'],
        portfolioStatus: json['portfolio_status'],
        totalFollowings: json['total_followings'],
        totalPostLikes: json['total_post_likes'],
        seoDataWeighted: json['seo_data_weighted'],
        totalConnections: json['total_connections'],
        portfolioCreatedAt: json['portfolio_created_at'],
        portfolioDescription: json['portfolio_description'],
        userLastLatLongWkb: json['user_last_lat_long_wkb'],
      );

  Map<String, dynamic> toMap() => {
        'bio': bio,
        'dob': dob,
        'uid': uid,
        'name': name,
        'gender': gender,
        'address': address,
        'is_spam': isSpam,
        'email_id': emailId,
        'username': username,
        'is_banned': isBanned,
        'is_online': isOnline,
        'total_likes': totalLikes,
        'is_portfolio': isPortfolio,
        'mobile_number': mobileNumber,
        'registered_on': registeredOn?.toIso8601String(),
        'is_deactivated': isDeactivated,
        'last_active_at': lastActiveAt?.toIso8601String(),
        'portfolio_title': portfolioTitle,
        'profile_picture': profilePicture,
        'public_email_id': publicEmailId,
        'total_followers': totalFollowers,
        'portfolio_status': portfolioStatus,
        'total_followings': totalFollowings,
        'total_post_likes': totalPostLikes,
        'seo_data_weighted': seoDataWeighted,
        'total_connections': totalConnections,
        'portfolio_created_at': portfolioCreatedAt,
        'portfolio_description': portfolioDescription,
        'user_last_lat_long_wkb': userLastLatLongWkb,
      };
}
