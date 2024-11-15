import 'dart:convert';

class SearchedUsersAndCommunitiesResponse {
  final String? message;
  final int? page;
  final bool? lastPage;
  final List<User>? users;
  final List<Community>? communities;

  SearchedUsersAndCommunitiesResponse({
    this.message,
    this.page,
    this.lastPage,
    this.users,
    this.communities,
  });

  SearchedUsersAndCommunitiesResponse copyWith({
    String? message,
    int? page,
    bool? lastPage,
    List<User>? users,
    List<Community>? communities,
  }) =>
      SearchedUsersAndCommunitiesResponse(
        message: message ?? this.message,
        page: page ?? this.page,
        lastPage: lastPage ?? this.lastPage,
        users: users ?? this.users,
        communities: communities ?? this.communities,
      );

  factory SearchedUsersAndCommunitiesResponse.fromJson(String str) =>
      SearchedUsersAndCommunitiesResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SearchedUsersAndCommunitiesResponse.fromMap(
          Map<String, dynamic> json,) =>
      SearchedUsersAndCommunitiesResponse(
        message: json['message'],
        page: json['page'],
        lastPage: json['last_page'],
        users: json['users'] == null
            ? []
            : List<User>.from(json['users']!.map((x) => User.fromMap(x))),
        communities: json['communities'] == null
            ? []
            : List<Community>.from(
                json['communities']!.map((x) => Community.fromMap(x)),),
      );

  Map<String, dynamic> toMap() => {
        'message': message,
        'page': page,
        'last_page': lastPage,
        'users': users == null
            ? []
            : List<dynamic>.from(users!.map((x) => x.toMap())),
        'communities': communities == null
            ? []
            : List<dynamic>.from(communities!.map((x) => x.toMap())),
      };
}

class Community {
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
  final String? seoDataWeighted;

  Community({
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
    this.seoDataWeighted,
  });

  Community copyWith({
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
    String? seoDataWeighted,
  }) =>
      Community(
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
        seoDataWeighted: seoDataWeighted ?? this.seoDataWeighted,
      );

  factory Community.fromJson(String str) => Community.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Community.fromMap(Map<String, dynamic> json) => Community(
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
        seoDataWeighted: json['seo_data_weighted'],
      );

  Map<String, dynamic> toMap() => {
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
        'seo_data_weighted': seoDataWeighted,
      };
}

class User {
  final DateTime? registeredOn;
  final String? uid;
  final String? username;
  final String? mobileNumber;
  final dynamic emailId;
  final String? name;
  final String? bio;
  final String? address;
  final dynamic dob;
  final dynamic profilePicture;
  final bool? isPortfolio;
  final String? portfolioStatus;
  final String? portfolioDescription;
  final bool? isBanned;
  final bool? isSpam;
  final bool? isDeactivated;
  final dynamic portfolioCreatedAt;
  final String? portfolioTitle;
  final int? totalFollowers;
  final int? totalFollowings;
  final int? totalPostLikes;
  final dynamic gender;
  final bool? isOnline;
  final DateTime? lastActiveAt;
  final dynamic userLastLatLongWkb;
  final int? totalConnections;
  final int? totalLikes;
  final String? publicEmailId;
  final String? seoDataWeighted;

  User({
    this.registeredOn,
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
    this.totalConnections,
    this.totalLikes,
    this.publicEmailId,
    this.seoDataWeighted,
  });

  User copyWith({
    DateTime? registeredOn,
    String? uid,
    String? username,
    String? mobileNumber,
    dynamic emailId,
    String? name,
    String? bio,
    String? address,
    dynamic dob,
    dynamic profilePicture,
    bool? isPortfolio,
    String? portfolioStatus,
    String? portfolioDescription,
    bool? isBanned,
    bool? isSpam,
    bool? isDeactivated,
    dynamic portfolioCreatedAt,
    String? portfolioTitle,
    int? totalFollowers,
    int? totalFollowings,
    int? totalPostLikes,
    dynamic gender,
    bool? isOnline,
    DateTime? lastActiveAt,
    dynamic userLastLatLongWkb,
    int? totalConnections,
    int? totalLikes,
    String? publicEmailId,
    String? seoDataWeighted,
  }) =>
      User(
        registeredOn: registeredOn ?? this.registeredOn,
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
        totalConnections: totalConnections ?? this.totalConnections,
        totalLikes: totalLikes ?? this.totalLikes,
        publicEmailId: publicEmailId ?? this.publicEmailId,
        seoDataWeighted: seoDataWeighted ?? this.seoDataWeighted,
      );

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        registeredOn: json['registered_on'] == null
            ? null
            : DateTime.parse(json['registered_on']),
        uid: json['uid'],
        username: json['username'],
        mobileNumber: json['mobile_number'],
        emailId: json['email_id'],
        name: json['name'],
        bio: json['bio'],
        address: json['address'],
        dob: json['dob'],
        profilePicture: json['profile_picture'],
        isPortfolio: json['is_portfolio'],
        portfolioStatus: json['portfolio_status'],
        portfolioDescription: json['portfolio_description'],
        isBanned: json['is_banned'],
        isSpam: json['is_spam'],
        isDeactivated: json['is_deactivated'],
        portfolioCreatedAt: json['portfolio_created_at'],
        portfolioTitle: json['portfolio_title'],
        totalFollowers: json['total_followers'],
        totalFollowings: json['total_followings'],
        totalPostLikes: json['total_post_likes'],
        gender: json['gender'],
        isOnline: json['is_online'],
        lastActiveAt: json['last_active_at'] == null
            ? null
            : DateTime.parse(json['last_active_at']),
        userLastLatLongWkb: json['user_last_lat_long_wkb'],
        totalConnections: json['total_connections'],
        totalLikes: json['total_likes'],
        publicEmailId: json['public_email_id'],
        seoDataWeighted: json['seo_data_weighted'],
      );

  Map<String, dynamic> toMap() => {
        'registered_on': registeredOn?.toIso8601String(),
        'uid': uid,
        'username': username,
        'mobile_number': mobileNumber,
        'email_id': emailId,
        'name': name,
        'bio': bio,
        'address': address,
        'dob': dob,
        'profile_picture': profilePicture,
        'is_portfolio': isPortfolio,
        'portfolio_status': portfolioStatus,
        'portfolio_description': portfolioDescription,
        'is_banned': isBanned,
        'is_spam': isSpam,
        'is_deactivated': isDeactivated,
        'portfolio_created_at': portfolioCreatedAt,
        'portfolio_title': portfolioTitle,
        'total_followers': totalFollowers,
        'total_followings': totalFollowings,
        'total_post_likes': totalPostLikes,
        'gender': gender,
        'is_online': isOnline,
        'last_active_at': lastActiveAt?.toIso8601String(),
        'user_last_lat_long_wkb': userLastLatLongWkb,
        'total_connections': totalConnections,
        'total_likes': totalLikes,
        'public_email_id': publicEmailId,
        'seo_data_weighted': seoDataWeighted,
      };
}
