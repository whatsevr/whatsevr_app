import 'dart:convert';

class SearchedMemoriesResponse {
  final String? message;
  final int? page;
  final bool? lastPage;
  final List<Memory>? memories;

  SearchedMemoriesResponse({
    this.message,
    this.page,
    this.lastPage,
    this.memories,
  });

  SearchedMemoriesResponse copyWith({
    String? message,
    int? page,
    bool? lastPage,
    List<Memory>? memories,
  }) =>
      SearchedMemoriesResponse(
        message: message ?? this.message,
        page: page ?? this.page,
        lastPage: lastPage ?? this.lastPage,
        memories: memories ?? this.memories,
      );

  factory SearchedMemoriesResponse.fromJson(String str) =>
      SearchedMemoriesResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SearchedMemoriesResponse.fromMap(Map<String, dynamic> json) =>
      SearchedMemoriesResponse(
        message: json['message'],
        page: json['page'],
        lastPage: json['last_page'],
        memories: json['memories'] == null
            ? []
            : List<Memory>.from(
                json['memories']!.map((x) => Memory.fromMap(x)),),
      );

  Map<String, dynamic> toMap() => {
        'message': message,
        'page': page,
        'last_page': lastPage,
        'memories': memories == null
            ? []
            : List<dynamic>.from(memories!.map((x) => x.toMap())),
      };
}

class Memory {
  final DateTime? createdAt;
  final String? uid;
  final String? caption;
  final List<String>? hashtags;
  final dynamic taggedUserUids;
  final bool? isDeleted;
  final bool? isArchived;
  final bool? isActive;
  final String? postCreatorType;
  final DateTime? expiresAt;
  final String? userUid;
  final String? imageUrl;
  final String? videoUrl;
  final bool? isVideo;
  final String? location;
  final int? totalViews;
  final int? totalLikes;
  final int? totalComments;
  final String? internalAiDescription;
  final dynamic addressLatLongWkb;
  final dynamic creatorLatLongWkb;
  final dynamic taggedCommunityUids;
  final int? totalShares;
  final int? cumulativeScore;
  final dynamic ctaAction;
  final dynamic ctaActionUrl;
  final bool? isImage;
  final bool? isText;
  final int? videoDurationMs;
  final String? seoDataWeighted;
  final Creator? creator;

  Memory({
    this.createdAt,
    this.uid,
    this.caption,
    this.hashtags,
    this.taggedUserUids,
    this.isDeleted,
    this.isArchived,
    this.isActive,
    this.postCreatorType,
    this.expiresAt,
    this.userUid,
    this.imageUrl,
    this.videoUrl,
    this.isVideo,
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
    this.ctaAction,
    this.ctaActionUrl,
    this.isImage,
    this.isText,
    this.videoDurationMs,
    this.seoDataWeighted,
    this.creator,
  });

  Memory copyWith({
    DateTime? createdAt,
    String? uid,
    String? caption,
    List<String>? hashtags,
    dynamic taggedUserUids,
    bool? isDeleted,
    bool? isArchived,
    bool? isActive,
    String? postCreatorType,
    DateTime? expiresAt,
    String? userUid,
    String? imageUrl,
    String? videoUrl,
    bool? isVideo,
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
    dynamic ctaAction,
    dynamic ctaActionUrl,
    bool? isImage,
    bool? isText,
    int? videoDurationMs,
    String? seoDataWeighted,
    Creator? creator,
  }) =>
      Memory(
        createdAt: createdAt ?? this.createdAt,
        uid: uid ?? this.uid,
        caption: caption ?? this.caption,
        hashtags: hashtags ?? this.hashtags,
        taggedUserUids: taggedUserUids ?? this.taggedUserUids,
        isDeleted: isDeleted ?? this.isDeleted,
        isArchived: isArchived ?? this.isArchived,
        isActive: isActive ?? this.isActive,
        postCreatorType: postCreatorType ?? this.postCreatorType,
        expiresAt: expiresAt ?? this.expiresAt,
        userUid: userUid ?? this.userUid,
        imageUrl: imageUrl ?? this.imageUrl,
        videoUrl: videoUrl ?? this.videoUrl,
        isVideo: isVideo ?? this.isVideo,
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
        ctaAction: ctaAction ?? this.ctaAction,
        ctaActionUrl: ctaActionUrl ?? this.ctaActionUrl,
        isImage: isImage ?? this.isImage,
        isText: isText ?? this.isText,
        videoDurationMs: videoDurationMs ?? this.videoDurationMs,
        seoDataWeighted: seoDataWeighted ?? this.seoDataWeighted,
        creator: creator ?? this.creator,
      );

  factory Memory.fromJson(String str) => Memory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Memory.fromMap(Map<String, dynamic> json) => Memory(
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        uid: json['uid'],
        caption: json['caption'],
        hashtags: json['hashtags'] == null
            ? []
            : List<String>.from(json['hashtags']!.map((x) => x)),
        taggedUserUids: json['tagged_user_uids'],
        isDeleted: json['is_deleted'],
        isArchived: json['is_archived'],
        isActive: json['is_active'],
        postCreatorType: json['post_creator_type'],
        expiresAt: json['expires_at'] == null
            ? null
            : DateTime.parse(json['expires_at']),
        userUid: json['user_uid'],
        imageUrl: json['image_url'],
        videoUrl: json['video_url'],
        isVideo: json['is_video'],
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
        ctaAction: json['cta_action'],
        ctaActionUrl: json['cta_action_url'],
        isImage: json['is_image'],
        isText: json['is_text'],
        videoDurationMs: json['video_duration_ms'],
        seoDataWeighted: json['seo_data_weighted'],
        creator:
            json['creator'] == null ? null : Creator.fromMap(json['creator']),
      );

  Map<String, dynamic> toMap() => {
        'created_at': createdAt?.toIso8601String(),
        'uid': uid,
        'caption': caption,
        'hashtags':
            hashtags == null ? [] : List<dynamic>.from(hashtags!.map((x) => x)),
        'tagged_user_uids': taggedUserUids,
        'is_deleted': isDeleted,
        'is_archived': isArchived,
        'is_active': isActive,
        'post_creator_type': postCreatorType,
        'expires_at': expiresAt?.toIso8601String(),
        'user_uid': userUid,
        'image_url': imageUrl,
        'video_url': videoUrl,
        'is_video': isVideo,
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
        'cta_action': ctaAction,
        'cta_action_url': ctaActionUrl,
        'is_image': isImage,
        'is_text': isText,
        'video_duration_ms': videoDurationMs,
        'seo_data_weighted': seoDataWeighted,
        'creator': creator?.toMap(),
      };
}

class Creator {
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
  final DateTime? registeredOn;
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

  Creator({
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

  Creator copyWith({
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
      Creator(
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

  factory Creator.fromJson(String str) => Creator.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Creator.fromMap(Map<String, dynamic> json) => Creator(
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
