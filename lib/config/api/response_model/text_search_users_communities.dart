import 'dart:convert';

class TextSearchUsersAndCommunitiesResponse {
  final String? message;
  final List<User>? users;
  final List<Community>? communities;

  TextSearchUsersAndCommunitiesResponse({
    this.message,
    this.users,
    this.communities,
  });

  TextSearchUsersAndCommunitiesResponse copyWith({
    String? message,
    List<User>? users,
    List<Community>? communities,
  }) =>
      TextSearchUsersAndCommunitiesResponse(
        message: message ?? this.message,
        users: users ?? this.users,
        communities: communities ?? this.communities,
      );

  factory TextSearchUsersAndCommunitiesResponse.fromJson(String str) => TextSearchUsersAndCommunitiesResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TextSearchUsersAndCommunitiesResponse.fromMap(Map<String, dynamic> json) => TextSearchUsersAndCommunitiesResponse(
    message: json["message"],
    users: json["users"] == null ? [] : List<User>.from(json["users"]!.map((x) => User.fromMap(x))),
    communities: json["communities"] == null ? [] : List<Community>.from(json["communities"]!.map((x) => Community.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "message": message,
    "users": users == null ? [] : List<dynamic>.from(users!.map((x) => x.toMap())),
    "communities": communities == null ? [] : List<dynamic>.from(communities!.map((x) => x.toMap())),
  };
}

class Community {
  final int? id;
  final DateTime? createdAt;
  final String? userUid;
  final String? status;
  final dynamic services;
  final String? bio;
  final String? address;
  final String? description;
  final String? title;
  final String? profilePicture;
  final String? uid;
  final String? username;

  Community({
    this.id,
    this.createdAt,
    this.userUid,
    this.status,
    this.services,
    this.bio,
    this.address,
    this.description,
    this.title,
    this.profilePicture,
    this.uid,
    this.username,
  });

  Community copyWith({
    int? id,
    DateTime? createdAt,
    String? userUid,
    String? status,
    dynamic services,
    String? bio,
    String? address,
    String? description,
    String? title,
    String? profilePicture,
    String? uid,
    String? username,
  }) =>
      Community(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        userUid: userUid ?? this.userUid,
        status: status ?? this.status,
        services: services ?? this.services,
        bio: bio ?? this.bio,
        address: address ?? this.address,
        description: description ?? this.description,
        title: title ?? this.title,
        profilePicture: profilePicture ?? this.profilePicture,
        uid: uid ?? this.uid,
        username: username ?? this.username,
      );

  factory Community.fromJson(String str) => Community.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Community.fromMap(Map<String, dynamic> json) => Community(
    id: json["id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    userUid: json["user_uid"],
    status: json["status"],
    services: json["services"],
    bio: json["bio"],
    address: json["address"],
    description: json["description"],
    title: json["title"],
    profilePicture: json["profile_picture"],
    uid: json["uid"],
    username: json["username"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "created_at": createdAt?.toIso8601String(),
    "user_uid": userUid,
    "status": status,
    "services": services,
    "bio": bio,
    "address": address,
    "description": description,
    "title": title,
    "profile_picture": profilePicture,
    "uid": uid,
    "username": username,
  };
}

class User {
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

  User({
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

  User copyWith({
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
      User(
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

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["id"],
    registeredOn: json["registered_on"] == null ? null : DateTime.parse(json["registered_on"]),
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
    portfolioCreatedAt: json["portfolio_created_at"] == null ? null : DateTime.parse(json["portfolio_created_at"]),
    portfolioTitle: json["portfolio_title"],
    totalFollowers: json["total_followers"],
    totalFollowings: json["total_followings"],
    totalPostLikes: json["total_post_likes"],
    gender: json["gender"],
    isOnline: json["is_online"],
    lastActiveAt: json["last_active_at"] == null ? null : DateTime.parse(json["last_active_at"]),
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
    "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
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