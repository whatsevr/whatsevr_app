import 'dart:convert';

class SearchedCommunitiesResponse {
  final String? message;
  final int? page;
  final bool? lastPage;
  final List<Community>? communities;

  SearchedCommunitiesResponse({
    this.message,
    this.page,
    this.lastPage,
    this.communities,
  });

  SearchedCommunitiesResponse copyWith({
    String? message,
    int? page,
    bool? lastPage,
    List<Community>? communities,
  }) =>
      SearchedCommunitiesResponse(
        message: message ?? this.message,
        page: page ?? this.page,
        lastPage: lastPage ?? this.lastPage,
        communities: communities ?? this.communities,
      );

  factory SearchedCommunitiesResponse.fromJson(String str) =>
      SearchedCommunitiesResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SearchedCommunitiesResponse.fromMap(Map<String, dynamic> json) =>
      SearchedCommunitiesResponse(
        message: json['message'],
        page: json['page'],
        lastPage: json['last_page'],
        communities: json['communities'] == null
            ? []
            : List<Community>.from(
                json['communities']!.map((x) => Community.fromMap(x)),),
      );

  Map<String, dynamic> toMap() => {
        'message': message,
        'page': page,
        'last_page': lastPage,
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
  final Admin? admin;

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
    this.admin,
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
    Admin? admin,
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
        admin: admin ?? this.admin,
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
        admin: json['admin'] == null ? null : Admin.fromMap(json['admin']),
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
        'admin': admin?.toMap(),
      };
}

class Admin {
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

  Admin({
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

  Admin copyWith({
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
      Admin(
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

  factory Admin.fromJson(String str) => Admin.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Admin.fromMap(Map<String, dynamic> json) => Admin(
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
