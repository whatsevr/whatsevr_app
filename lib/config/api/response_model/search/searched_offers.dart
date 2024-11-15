import 'dart:convert';

class SearchedOffersResponse {
  final String? message;
  final int? page;
  final bool? lastPage;
  final List<Offer>? offers;

  SearchedOffersResponse({
    this.message,
    this.page,
    this.lastPage,
    this.offers,
  });

  SearchedOffersResponse copyWith({
    String? message,
    int? page,
    bool? lastPage,
    List<Offer>? offers,
  }) =>
      SearchedOffersResponse(
        message: message ?? this.message,
        page: page ?? this.page,
        lastPage: lastPage ?? this.lastPage,
        offers: offers ?? this.offers,
      );

  factory SearchedOffersResponse.fromJson(String str) =>
      SearchedOffersResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SearchedOffersResponse.fromMap(Map<String, dynamic> json) =>
      SearchedOffersResponse(
        message: json['message'],
        page: json['page'],
        lastPage: json['last_page'],
        offers: json['offers'] == null
            ? []
            : List<Offer>.from(json['offers']!.map((x) => Offer.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        'message': message,
        'page': page,
        'last_page': lastPage,
        'offers': offers == null
            ? []
            : List<dynamic>.from(offers!.map((x) => x.toMap())),
      };
}

class Offer {
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
  final List<dynamic>? filesData;
  final String? status;
  final String? targetGender;
  final List<String>? targetAreas;
  final String? seoDataWeighted;
  final Creator? creator;

  Offer({
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
    this.creator,
  });

  Offer copyWith({
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
    List<dynamic>? filesData,
    String? status,
    String? targetGender,
    List<String>? targetAreas,
    String? seoDataWeighted,
    Creator? creator,
  }) =>
      Offer(
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
        creator: creator ?? this.creator,
      );

  factory Offer.fromJson(String str) => Offer.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Offer.fromMap(Map<String, dynamic> json) => Offer(
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
            : List<dynamic>.from(json['files_data']!.map((x) => x)),
        status: json['status'],
        targetGender: json['target_gender'],
        targetAreas: json['target_areas'] == null
            ? []
            : List<String>.from(json['target_areas']!.map((x) => x)),
        seoDataWeighted: json['seo_data_weighted'],
        creator:
            json['creator'] == null ? null : Creator.fromMap(json['creator']),
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
            : List<dynamic>.from(filesData!.map((x) => x)),
        'status': status,
        'target_gender': targetGender,
        'target_areas': targetAreas == null
            ? []
            : List<dynamic>.from(targetAreas!.map((x) => x)),
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
