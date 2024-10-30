import 'dart:convert';

class UserCommunitiesResponse {
  final String? message;
  final List<Community>? userCommunities;
  final List<Community>? joinedCommunities;

  UserCommunitiesResponse({
    this.message,
    this.userCommunities,
    this.joinedCommunities,
  });

  UserCommunitiesResponse copyWith({
    String? message,
    List<Community>? userCommunities,
    List<Community>? joinedCommunities,
  }) =>
      UserCommunitiesResponse(
        message: message ?? this.message,
        userCommunities: userCommunities ?? this.userCommunities,
        joinedCommunities: joinedCommunities ?? this.joinedCommunities,
      );

  factory UserCommunitiesResponse.fromJson(String str) =>
      UserCommunitiesResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserCommunitiesResponse.fromMap(Map<String, dynamic> json) =>
      UserCommunitiesResponse(
        message: json['message'],
        userCommunities: json['user_communities'] == null
            ? []
            : List<Community>.from(
                json['user_communities']!.map((x) => Community.fromMap(x)),),
        joinedCommunities: json['joined_communities'] == null
            ? []
            : List<Community>.from(
                json['joined_communities']!.map((x) => Community.fromMap(x)),),
      );

  Map<String, dynamic> toMap() => {
        'message': message,
        'user_communities': userCommunities == null
            ? []
            : List<dynamic>.from(userCommunities!.map((x) => x.toMap())),
        'joined_communities': joinedCommunities == null
            ? []
            : List<dynamic>.from(joinedCommunities!.map((x) => x.toMap())),
      };
}

class Community {
  final int? id;
  final DateTime? createdAt;
  final String? adminUserUid;
  final String? status;
  final String? bio;
  final String? location;
  final String? description;
  final String? title;
  final String? profilePicture;
  final String? uid;
  final String? username;
  final int? totalMembers;
  final bool? requireJoiningApproval;
  final Admin? admin;

  Community({
    this.id,
    this.createdAt,
    this.adminUserUid,
    this.status,
    this.bio,
    this.location,
    this.description,
    this.title,
    this.profilePicture,
    this.uid,
    this.username,
    this.totalMembers,
    this.requireJoiningApproval,
    this.admin,
  });

  Community copyWith({
    int? id,
    DateTime? createdAt,
    String? adminUserUid,
    String? status,
    String? bio,
    String? location,
    String? description,
    String? title,
    String? profilePicture,
    String? uid,
    String? username,
    int? totalMembers,
    bool? requireJoiningApproval,
    Admin? admin,
  }) =>
      Community(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        adminUserUid: adminUserUid ?? this.adminUserUid,
        status: status ?? this.status,
        bio: bio ?? this.bio,
        location: location ?? this.location,
        description: description ?? this.description,
        title: title ?? this.title,
        profilePicture: profilePicture ?? this.profilePicture,
        uid: uid ?? this.uid,
        username: username ?? this.username,
        totalMembers: totalMembers ?? this.totalMembers,
        requireJoiningApproval:
            requireJoiningApproval ?? this.requireJoiningApproval,
        admin: admin ?? this.admin,
      );

  factory Community.fromJson(String str) => Community.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Community.fromMap(Map<String, dynamic> json) => Community(
        id: json['id'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        adminUserUid: json['admin_user_uid'],
        status: json['status'],
        bio: json['bio'],
        location: json['location'],
        description: json['description'],
        title: json['title'],
        profilePicture: json['profile_picture'],
        uid: json['uid'],
        username: json['username'],
        totalMembers: json['total_members'],
        requireJoiningApproval: json['require_joining_approval'],
        admin: json['admin'] == null ? null : Admin.fromMap(json['admin']),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'created_at': createdAt?.toIso8601String(),
        'admin_user_uid': adminUserUid,
        'status': status,
        'bio': bio,
        'location': location,
        'description': description,
        'title': title,
        'profile_picture': profilePicture,
        'uid': uid,
        'username': username,
        'total_members': totalMembers,
        'require_joining_approval': requireJoiningApproval,
        'admin': admin?.toMap(),
      };
}

class Admin {
  final int? id;
  final String? bio;
  final DateTime? dob;
  final String? uid;
  final String? name;
  final String? gender;
  final String? address;
  final bool? isSpam;
  final String? emailId;
  final String? username;
  final bool? isActive;
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
  final int? totalFollowers;
  final String? portfolioStatus;
  final int? totalFollowings;
  final int? totalPostLikes;
  final int? totalConnections;
  final DateTime? portfolioCreatedAt;
  final String? portfolioDescription;
  final String? userLastLatLongWkb;

  Admin({
    this.id,
    this.bio,
    this.dob,
    this.uid,
    this.name,
    this.gender,
    this.address,
    this.isSpam,
    this.emailId,
    this.username,
    this.isActive,
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
    this.totalFollowers,
    this.portfolioStatus,
    this.totalFollowings,
    this.totalPostLikes,
    this.totalConnections,
    this.portfolioCreatedAt,
    this.portfolioDescription,
    this.userLastLatLongWkb,
  });

  Admin copyWith({
    int? id,
    String? bio,
    DateTime? dob,
    String? uid,
    String? name,
    String? gender,
    String? address,
    bool? isSpam,
    String? emailId,
    String? username,
    bool? isActive,
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
    int? totalFollowers,
    String? portfolioStatus,
    int? totalFollowings,
    int? totalPostLikes,
    int? totalConnections,
    DateTime? portfolioCreatedAt,
    String? portfolioDescription,
    String? userLastLatLongWkb,
  }) =>
      Admin(
        id: id ?? this.id,
        bio: bio ?? this.bio,
        dob: dob ?? this.dob,
        uid: uid ?? this.uid,
        name: name ?? this.name,
        gender: gender ?? this.gender,
        address: address ?? this.address,
        isSpam: isSpam ?? this.isSpam,
        emailId: emailId ?? this.emailId,
        username: username ?? this.username,
        isActive: isActive ?? this.isActive,
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
        totalFollowers: totalFollowers ?? this.totalFollowers,
        portfolioStatus: portfolioStatus ?? this.portfolioStatus,
        totalFollowings: totalFollowings ?? this.totalFollowings,
        totalPostLikes: totalPostLikes ?? this.totalPostLikes,
        totalConnections: totalConnections ?? this.totalConnections,
        portfolioCreatedAt: portfolioCreatedAt ?? this.portfolioCreatedAt,
        portfolioDescription: portfolioDescription ?? this.portfolioDescription,
        userLastLatLongWkb: userLastLatLongWkb ?? this.userLastLatLongWkb,
      );

  factory Admin.fromJson(String str) => Admin.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Admin.fromMap(Map<String, dynamic> json) => Admin(
        id: json['id'],
        bio: json['bio'],
        dob: json['dob'] == null ? null : DateTime.parse(json['dob']),
        uid: json['uid'],
        name: json['name'],
        gender: json['gender'],
        address: json['address'],
        isSpam: json['is_spam'],
        emailId: json['email_id'],
        username: json['username'],
        isActive: json['is_active'],
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
        totalFollowers: json['total_followers'],
        portfolioStatus: json['portfolio_status'],
        totalFollowings: json['total_followings'],
        totalPostLikes: json['total_post_likes'],
        totalConnections: json['total_connections'],
        portfolioCreatedAt: json['portfolio_created_at'] == null
            ? null
            : DateTime.parse(json['portfolio_created_at']),
        portfolioDescription: json['portfolio_description'],
        userLastLatLongWkb: json['user_last_lat_long_wkb'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'bio': bio,
        'dob':
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        'uid': uid,
        'name': name,
        'gender': gender,
        'address': address,
        'is_spam': isSpam,
        'email_id': emailId,
        'username': username,
        'is_active': isActive,
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
        'total_followers': totalFollowers,
        'portfolio_status': portfolioStatus,
        'total_followings': totalFollowings,
        'total_post_likes': totalPostLikes,
        'total_connections': totalConnections,
        'portfolio_created_at': portfolioCreatedAt?.toIso8601String(),
        'portfolio_description': portfolioDescription,
        'user_last_lat_long_wkb': userLastLatLongWkb,
      };
}
