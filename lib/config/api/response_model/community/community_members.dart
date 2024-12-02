import 'dart:convert';

class CommunityMembersResponse {
  final String? message;
  final int? page;
  final bool? lastPage;
  final List<Datum>? data;

  CommunityMembersResponse({
    this.message,
    this.page,
    this.lastPage,
    this.data,
  });

  CommunityMembersResponse copyWith({
    String? message,
    int? page,
    bool? lastPage,
    List<Datum>? data,
  }) =>
      CommunityMembersResponse(
        message: message ?? this.message,
        page: page ?? this.page,
        lastPage: lastPage ?? this.lastPage,
        data: data ?? this.data,
      );

  factory CommunityMembersResponse.fromJson(String str) =>
      CommunityMembersResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CommunityMembersResponse.fromMap(Map<String, dynamic> json) =>
      CommunityMembersResponse(
        message: json["message"],
        page: json["page"],
        lastPage: json["last_page"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "page": page,
        "last_page": lastPage,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Datum {
  final String? communityUid;
  final String? userUid;
  final DateTime? joinedAt;
  final String? role;
  final String? status;
  final bool? approved;
  final String? invitedByUserUid;
  final bool? canPost;
  final bool? canEditPosts;
  final bool? canDeletePosts;
  final bool? canPinMessages;
  final bool? canAddMembers;
  final bool? canBanMembers;
  final bool? canMuteMembers;
  final DateTime? lastActiveAt;
  final dynamic mutedUntil;
  final dynamic joinRequestMessage;
  final dynamic notes;
  final Member? user;
  final Member? invitedBy;

  Datum({
    this.communityUid,
    this.userUid,
    this.joinedAt,
    this.role,
    this.status,
    this.approved,
    this.invitedByUserUid,
    this.canPost,
    this.canEditPosts,
    this.canDeletePosts,
    this.canPinMessages,
    this.canAddMembers,
    this.canBanMembers,
    this.canMuteMembers,
    this.lastActiveAt,
    this.mutedUntil,
    this.joinRequestMessage,
    this.notes,
    this.user,
    this.invitedBy,
  });

  Datum copyWith({
    String? communityUid,
    String? userUid,
    DateTime? joinedAt,
    String? role,
    String? status,
    bool? approved,
    String? invitedByUserUid,
    bool? canPost,
    bool? canEditPosts,
    bool? canDeletePosts,
    bool? canPinMessages,
    bool? canAddMembers,
    bool? canBanMembers,
    bool? canMuteMembers,
    DateTime? lastActiveAt,
    dynamic mutedUntil,
    dynamic joinRequestMessage,
    dynamic notes,
    Member? user,
    Member? invitedBy,
  }) =>
      Datum(
        communityUid: communityUid ?? this.communityUid,
        userUid: userUid ?? this.userUid,
        joinedAt: joinedAt ?? this.joinedAt,
        role: role ?? this.role,
        status: status ?? this.status,
        approved: approved ?? this.approved,
        invitedByUserUid: invitedByUserUid ?? this.invitedByUserUid,
        canPost: canPost ?? this.canPost,
        canEditPosts: canEditPosts ?? this.canEditPosts,
        canDeletePosts: canDeletePosts ?? this.canDeletePosts,
        canPinMessages: canPinMessages ?? this.canPinMessages,
        canAddMembers: canAddMembers ?? this.canAddMembers,
        canBanMembers: canBanMembers ?? this.canBanMembers,
        canMuteMembers: canMuteMembers ?? this.canMuteMembers,
        lastActiveAt: lastActiveAt ?? this.lastActiveAt,
        mutedUntil: mutedUntil ?? this.mutedUntil,
        joinRequestMessage: joinRequestMessage ?? this.joinRequestMessage,
        notes: notes ?? this.notes,
        user: user ?? this.user,
        invitedBy: invitedBy ?? this.invitedBy,
      );

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        communityUid: json["community_uid"],
        userUid: json["user_uid"],
        joinedAt: json["joined_at"] == null
            ? null
            : DateTime.parse(json["joined_at"]),
        role: json["role"],
        status: json["status"],
        approved: json["approved"],
        invitedByUserUid: json["invited_by_user_uid"],
        canPost: json["can_post"],
        canEditPosts: json["can_edit_posts"],
        canDeletePosts: json["can_delete_posts"],
        canPinMessages: json["can_pin_messages"],
        canAddMembers: json["can_add_members"],
        canBanMembers: json["can_ban_members"],
        canMuteMembers: json["can_mute_members"],
        lastActiveAt: json["last_active_at"] == null
            ? null
            : DateTime.parse(json["last_active_at"]),
        mutedUntil: json["muted_until"],
        joinRequestMessage: json["join_request_message"],
        notes: json["notes"],
        user: json["user"] == null ? null : Member.fromMap(json["user"]),
        invitedBy: json["invited_by"] == null
            ? null
            : Member.fromMap(json["invited_by"]),
      );

  Map<String, dynamic> toMap() => {
        "community_uid": communityUid,
        "user_uid": userUid,
        "joined_at": joinedAt?.toIso8601String(),
        "role": role,
        "status": status,
        "approved": approved,
        "invited_by_user_uid": invitedByUserUid,
        "can_post": canPost,
        "can_edit_posts": canEditPosts,
        "can_delete_posts": canDeletePosts,
        "can_pin_messages": canPinMessages,
        "can_add_members": canAddMembers,
        "can_ban_members": canBanMembers,
        "can_mute_members": canMuteMembers,
        "last_active_at": lastActiveAt?.toIso8601String(),
        "muted_until": mutedUntil,
        "join_request_message": joinRequestMessage,
        "notes": notes,
        "user": user?.toMap(),
        "invited_by": invitedBy?.toMap(),
      };
}

class Member {
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

  Member({
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

  Member copyWith({
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
      Member(
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

  factory Member.fromJson(String str) => Member.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Member.fromMap(Map<String, dynamic> json) => Member(
        bio: json["bio"],
        dob: json["dob"],
        uid: json["uid"],
        name: json["name"],
        gender: json["gender"],
        address: json["address"],
        isSpam: json["is_spam"],
        emailId: json["email_id"],
        username: json["username"],
        isBanned: json["is_banned"],
        isOnline: json["is_online"],
        totalLikes: json["total_likes"],
        isPortfolio: json["is_portfolio"],
        mobileNumber: json["mobile_number"],
        registeredOn: json["registered_on"] == null
            ? null
            : DateTime.parse(json["registered_on"]),
        isDeactivated: json["is_deactivated"],
        lastActiveAt: json["last_active_at"] == null
            ? null
            : DateTime.parse(json["last_active_at"]),
        portfolioTitle: json["portfolio_title"],
        profilePicture: json["profile_picture"],
        publicEmailId: json["public_email_id"],
        totalFollowers: json["total_followers"],
        portfolioStatus: json["portfolio_status"],
        totalFollowings: json["total_followings"],
        totalPostLikes: json["total_post_likes"],
        seoDataWeighted: json["seo_data_weighted"],
        totalConnections: json["total_connections"],
        portfolioCreatedAt: json["portfolio_created_at"],
        portfolioDescription: json["portfolio_description"],
        userLastLatLongWkb: json["user_last_lat_long_wkb"],
      );

  Map<String, dynamic> toMap() => {
        "bio": bio,
        "dob": dob,
        "uid": uid,
        "name": name,
        "gender": gender,
        "address": address,
        "is_spam": isSpam,
        "email_id": emailId,
        "username": username,
        "is_banned": isBanned,
        "is_online": isOnline,
        "total_likes": totalLikes,
        "is_portfolio": isPortfolio,
        "mobile_number": mobileNumber,
        "registered_on": registeredOn?.toIso8601String(),
        "is_deactivated": isDeactivated,
        "last_active_at": lastActiveAt?.toIso8601String(),
        "portfolio_title": portfolioTitle,
        "profile_picture": profilePicture,
        "public_email_id": publicEmailId,
        "total_followers": totalFollowers,
        "portfolio_status": portfolioStatus,
        "total_followings": totalFollowings,
        "total_post_likes": totalPostLikes,
        "seo_data_weighted": seoDataWeighted,
        "total_connections": totalConnections,
        "portfolio_created_at": portfolioCreatedAt,
        "portfolio_description": portfolioDescription,
        "user_last_lat_long_wkb": userLastLatLongWkb,
      };
}
