import 'dart:convert';

class PrivateRecommendationMixCommunityContentResponse {
  final String? message;
  final List<CommunityMixContent>? communityMixContent;
  final int? totalContent;
  final bool? lastPage;
  final int? page;

  PrivateRecommendationMixCommunityContentResponse({
    this.message,
    this.communityMixContent,
    this.totalContent,
    this.lastPage,
    this.page,
  });

  PrivateRecommendationMixCommunityContentResponse copyWith({
    String? message,
    List<CommunityMixContent>? communityMixContent,
    int? totalContent,
    bool? lastPage,
    int? page,
  }) =>
      PrivateRecommendationMixCommunityContentResponse(
        message: message ?? this.message,
        communityMixContent: communityMixContent ?? this.communityMixContent,
        totalContent: totalContent ?? this.totalContent,
        lastPage: lastPage ?? this.lastPage,
        page: page ?? this.page,
      );

  factory PrivateRecommendationMixCommunityContentResponse.fromJson(
          String str,) =>
      PrivateRecommendationMixCommunityContentResponse.fromMap(
          json.decode(str),);

  String toJson() => json.encode(toMap());

  factory PrivateRecommendationMixCommunityContentResponse.fromMap(
          Map<String, dynamic> json,) =>
      PrivateRecommendationMixCommunityContentResponse(
        message: json['message'],
        communityMixContent: json['community_mix_content'] == null
            ? []
            : List<CommunityMixContent>.from(json['community_mix_content']!
                .map((x) => CommunityMixContent.fromMap(x)),),
        totalContent: json['total_content'],
        lastPage: json['last_page'],
        page: json['page'],
      );

  Map<String, dynamic> toMap() => {
        'message': message,
        'community_mix_content': communityMixContent == null
            ? []
            : List<dynamic>.from(communityMixContent!.map((x) => x.toMap())),
        'total_content': totalContent,
        'last_page': lastPage,
        'page': page,
      };
}

class CommunityMixContent {
  final String? contentType;
  final Content? content;

  CommunityMixContent({
    this.contentType,
    this.content,
  });

  CommunityMixContent copyWith({
    String? contentType,
    Content? content,
  }) =>
      CommunityMixContent(
        contentType: contentType ?? this.contentType,
        content: content ?? this.content,
      );

  factory CommunityMixContent.fromJson(String str) =>
      CommunityMixContent.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CommunityMixContent.fromMap(Map<String, dynamic> json) =>
      CommunityMixContent(
        contentType: json['content_type'],
        content:
            json['content'] == null ? null : Content.fromMap(json['content']),
      );

  Map<String, dynamic> toMap() => {
        'content_type': contentType,
        'content': content?.toMap(),
      };
}

class Content {
  final DateTime? createdAt;
  final String? uid;
  final String? title;
  final String? description;
  final List<String>? hashtags;
  final dynamic taggedUserUids;
  final bool? isDeleted;
  final bool? isArchived;
  final bool? isActive;
  final String? postCreatorType;
  final String? userUid;
  final int? totalImpressions;
  final int? totalLikes;
  final int? totalComments;
  final String? internalAiDescription;
  final dynamic creatorLatLongWkb;
  final dynamic taggedCommunityUids;
  final int? totalShares;
  final int? cumulativeScore;
  final String? ctaAction;
  final String? ctaActionUrl;
  final List<FilesDatum>? filesData;
  final String? status;
  final String? targetGender;
  final List<String>? targetAreas;
  final String? seoDataWeighted;
  final String? communityUid;
  final User? user;
  final Community? community;
  final DateTime? updatedAt;
  final String? location;
  final dynamic addressLatLongWkb;
  final String? thumbnail;
  final String? videoUrl;
  final int? totalViews;
  final int? videoDurationInSec;

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
    this.userUid,
    this.totalImpressions,
    this.totalLikes,
    this.totalComments,
    this.internalAiDescription,
    this.creatorLatLongWkb,
    this.taggedCommunityUids,
    this.totalShares,
    this.cumulativeScore,
    this.ctaAction,
    this.ctaActionUrl,
    this.filesData,
    this.status,
    this.targetGender,
    this.targetAreas,
    this.seoDataWeighted,
    this.communityUid,
    this.user,
    this.community,
    this.updatedAt,
    this.location,
    this.addressLatLongWkb,
    this.thumbnail,
    this.videoUrl,
    this.totalViews,
    this.videoDurationInSec,
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
    String? userUid,
    int? totalImpressions,
    int? totalLikes,
    int? totalComments,
    String? internalAiDescription,
    dynamic creatorLatLongWkb,
    dynamic taggedCommunityUids,
    int? totalShares,
    int? cumulativeScore,
    String? ctaAction,
    String? ctaActionUrl,
    List<FilesDatum>? filesData,
    String? status,
    String? targetGender,
    List<String>? targetAreas,
    String? seoDataWeighted,
    String? communityUid,
    User? user,
    Community? community,
    DateTime? updatedAt,
    String? location,
    dynamic addressLatLongWkb,
    String? thumbnail,
    String? videoUrl,
    int? totalViews,
    int? videoDurationInSec,
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
        userUid: userUid ?? this.userUid,
        totalImpressions: totalImpressions ?? this.totalImpressions,
        totalLikes: totalLikes ?? this.totalLikes,
        totalComments: totalComments ?? this.totalComments,
        internalAiDescription:
            internalAiDescription ?? this.internalAiDescription,
        creatorLatLongWkb: creatorLatLongWkb ?? this.creatorLatLongWkb,
        taggedCommunityUids: taggedCommunityUids ?? this.taggedCommunityUids,
        totalShares: totalShares ?? this.totalShares,
        cumulativeScore: cumulativeScore ?? this.cumulativeScore,
        ctaAction: ctaAction ?? this.ctaAction,
        ctaActionUrl: ctaActionUrl ?? this.ctaActionUrl,
        filesData: filesData ?? this.filesData,
        status: status ?? this.status,
        targetGender: targetGender ?? this.targetGender,
        targetAreas: targetAreas ?? this.targetAreas,
        seoDataWeighted: seoDataWeighted ?? this.seoDataWeighted,
        communityUid: communityUid ?? this.communityUid,
        user: user ?? this.user,
        community: community ?? this.community,
        updatedAt: updatedAt ?? this.updatedAt,
        location: location ?? this.location,
        addressLatLongWkb: addressLatLongWkb ?? this.addressLatLongWkb,
        thumbnail: thumbnail ?? this.thumbnail,
        videoUrl: videoUrl ?? this.videoUrl,
        totalViews: totalViews ?? this.totalViews,
        videoDurationInSec: videoDurationInSec ?? this.videoDurationInSec,
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
        userUid: json['user_uid'],
        totalImpressions: json['total_impressions'],
        totalLikes: json['total_likes'],
        totalComments: json['total_comments'],
        internalAiDescription: json['internal_ai_description'],
        creatorLatLongWkb: json['creator_lat_long_wkb'],
        taggedCommunityUids: json['tagged_community_uids'],
        totalShares: json['total_shares'],
        cumulativeScore: json['cumulative_score'],
        ctaAction: json['cta_action'],
        ctaActionUrl: json['cta_action_url'],
        filesData: json['files_data'] == null
            ? []
            : List<FilesDatum>.from(
                json['files_data']!.map((x) => FilesDatum.fromMap(x)),),
        status: json['status'],
        targetGender: json['target_gender'],
        targetAreas: json['target_areas'] == null
            ? []
            : List<String>.from(json['target_areas']!.map((x) => x)),
        seoDataWeighted: json['seo_data_weighted'],
        communityUid: json['community_uid'],
        user: json['user'] == null ? null : User.fromMap(json['user']),
        community: json['community'] == null
            ? null
            : Community.fromMap(json['community']),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at']),
        location: json['location'],
        addressLatLongWkb: json['address_lat_long_wkb'],
        thumbnail: json['thumbnail'],
        videoUrl: json['video_url'],
        totalViews: json['total_views'],
        videoDurationInSec: json['video_duration_in_sec'],
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
        'user_uid': userUid,
        'total_impressions': totalImpressions,
        'total_likes': totalLikes,
        'total_comments': totalComments,
        'internal_ai_description': internalAiDescription,
        'creator_lat_long_wkb': creatorLatLongWkb,
        'tagged_community_uids': taggedCommunityUids,
        'total_shares': totalShares,
        'cumulative_score': cumulativeScore,
        'cta_action': ctaAction,
        'cta_action_url': ctaActionUrl,
        'files_data': filesData == null
            ? []
            : List<dynamic>.from(filesData!.map((x) => x.toMap())),
        'status': status,
        'target_gender': targetGender,
        'target_areas': targetAreas == null
            ? []
            : List<dynamic>.from(targetAreas!.map((x) => x)),
        'seo_data_weighted': seoDataWeighted,
        'community_uid': communityUid,
        'user': user?.toMap(),
        'community': community?.toMap(),
        'updated_at': updatedAt?.toIso8601String(),
        'location': location,
        'address_lat_long_wkb': addressLatLongWkb,
        'thumbnail': thumbnail,
        'video_url': videoUrl,
        'total_views': totalViews,
        'video_duration_in_sec': videoDurationInSec,
      };
}

class Community {
  final String? bio;
  final String? uid;
  final String? title;
  final String? status;
  final String? location;
  final String? username;
  final DateTime? createdAt;
  final String? description;
  final int? totalMembers;
  final String? adminUserUid;
  final dynamic lastMessageAt;
  final dynamic profilePicture;
  final String? seoDataWeighted;
  final dynamic plainLastMessage;
  final bool? requireJoiningApproval;

  Community({
    this.bio,
    this.uid,
    this.title,
    this.status,
    this.location,
    this.username,
    this.createdAt,
    this.description,
    this.totalMembers,
    this.adminUserUid,
    this.lastMessageAt,
    this.profilePicture,
    this.seoDataWeighted,
    this.plainLastMessage,
    this.requireJoiningApproval,
  });

  Community copyWith({
    String? bio,
    String? uid,
    String? title,
    String? status,
    String? location,
    String? username,
    DateTime? createdAt,
    String? description,
    int? totalMembers,
    String? adminUserUid,
    dynamic lastMessageAt,
    dynamic profilePicture,
    String? seoDataWeighted,
    dynamic plainLastMessage,
    bool? requireJoiningApproval,
  }) =>
      Community(
        bio: bio ?? this.bio,
        uid: uid ?? this.uid,
        title: title ?? this.title,
        status: status ?? this.status,
        location: location ?? this.location,
        username: username ?? this.username,
        createdAt: createdAt ?? this.createdAt,
        description: description ?? this.description,
        totalMembers: totalMembers ?? this.totalMembers,
        adminUserUid: adminUserUid ?? this.adminUserUid,
        lastMessageAt: lastMessageAt ?? this.lastMessageAt,
        profilePicture: profilePicture ?? this.profilePicture,
        seoDataWeighted: seoDataWeighted ?? this.seoDataWeighted,
        plainLastMessage: plainLastMessage ?? this.plainLastMessage,
        requireJoiningApproval:
            requireJoiningApproval ?? this.requireJoiningApproval,
      );

  factory Community.fromJson(String str) => Community.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Community.fromMap(Map<String, dynamic> json) => Community(
        bio: json['bio'],
        uid: json['uid'],
        title: json['title'],
        status: json['status'],
        location: json['location'],
        username: json['username'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        description: json['description'],
        totalMembers: json['total_members'],
        adminUserUid: json['admin_user_uid'],
        lastMessageAt: json['last_message_at'],
        profilePicture: json['profile_picture'],
        seoDataWeighted: json['seo_data_weighted'],
        plainLastMessage: json['plain_last_message'],
        requireJoiningApproval: json['require_joining_approval'],
      );

  Map<String, dynamic> toMap() => {
        'bio': bio,
        'uid': uid,
        'title': title,
        'status': status,
        'location': location,
        'username': username,
        'created_at': createdAt?.toIso8601String(),
        'description': description,
        'total_members': totalMembers,
        'admin_user_uid': adminUserUid,
        'last_message_at': lastMessageAt,
        'profile_picture': profilePicture,
        'seo_data_weighted': seoDataWeighted,
        'plain_last_message': plainLastMessage,
        'require_joining_approval': requireJoiningApproval,
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

class User {
  final String? bio;
  final dynamic dob;
  final String? uid;
  final String? name;
  final dynamic gender;
  final String? address;
  final bool? isSpam;
  final String? emailId;
  final String? username;
  final bool? isBanned;
  final bool? isOnline;
  final int? totalLikes;
  final bool? isPortfolio;
  final String? mobileNumber;
  final DateTime? registeredAt;
  final bool? isDeactivated;
  final DateTime? lastActiveAt;
  final String? portfolioTitle;
  final String? profilePicture;
  final String? publicEmailId;
  final int? totalFollowers;
  final String? portfolioStatus;
  final int? totalFollowings;
  final int? totalPostLikes;
  final String? seoDataWeighted;
  final int? totalConnections;
  final dynamic portfolioCreatedAt;
  final String? portfolioDescription;
  final dynamic userLastLatLongWkb;

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
    this.registeredAt,
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
    DateTime? registeredAt,
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
        registeredAt: registeredAt ?? this.registeredAt,
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
        registeredAt: json['registered_at'] == null
            ? null
            : DateTime.parse(json['registered_at']),
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
        'registered_at': registeredAt?.toIso8601String(),
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
