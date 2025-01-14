import 'dart:convert';

class SearchedPdfsResponse {
  final String? message;
  final int? page;
  final bool? lastPage;
  final List<Pdf>? pdfs;

  SearchedPdfsResponse({
    this.message,
    this.page,
    this.lastPage,
    this.pdfs,
  });

  SearchedPdfsResponse copyWith({
    String? message,
    int? page,
    bool? lastPage,
    List<Pdf>? pdfs,
  }) =>
      SearchedPdfsResponse(
        message: message ?? this.message,
        page: page ?? this.page,
        lastPage: lastPage ?? this.lastPage,
        pdfs: pdfs ?? this.pdfs,
      );

  factory SearchedPdfsResponse.fromJson(String str) =>
      SearchedPdfsResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SearchedPdfsResponse.fromMap(Map<String, dynamic> json) =>
      SearchedPdfsResponse(
        message: json['message'],
        page: json['page'],
        lastPage: json['last_page'],
        pdfs: json['pdfs'] == null
            ? []
            : List<Pdf>.from(json['pdfs']!.map((x) => Pdf.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        'message': message,
        'page': page,
        'last_page': lastPage,
        'pdfs':
            pdfs == null ? [] : List<dynamic>.from(pdfs!.map((x) => x.toMap())),
      };
}

class Pdf {
  final DateTime? createdAt;
  final String? fileUrl;
  final String? userUid;
  final String? title;
  final String? thumbnailUrl;
  final String? description;
  final String? postCreatorType;
  final dynamic communityUid;
  final dynamic creatorLatLongWkb;
  final String? uid;
  final String? seoDataWeighted;
  final Owner? owner;

  Pdf({
    this.createdAt,
    this.fileUrl,
    this.userUid,
    this.title,
    this.thumbnailUrl,
    this.description,
    this.postCreatorType,
    this.communityUid,
    this.creatorLatLongWkb,
    this.uid,
    this.seoDataWeighted,
    this.owner,
  });

  Pdf copyWith({
    DateTime? createdAt,
    String? fileUrl,
    String? userUid,
    String? title,
    String? thumbnailUrl,
    String? description,
    String? postCreatorType,
    dynamic communityUid,
    dynamic creatorLatLongWkb,
    String? uid,
    String? seoDataWeighted,
    Owner? owner,
  }) =>
      Pdf(
        createdAt: createdAt ?? this.createdAt,
        fileUrl: fileUrl ?? this.fileUrl,
        userUid: userUid ?? this.userUid,
        title: title ?? this.title,
        thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
        description: description ?? this.description,
        postCreatorType: postCreatorType ?? this.postCreatorType,
        communityUid: communityUid ?? this.communityUid,
        creatorLatLongWkb: creatorLatLongWkb ?? this.creatorLatLongWkb,
        uid: uid ?? this.uid,
        seoDataWeighted: seoDataWeighted ?? this.seoDataWeighted,
        owner: owner ?? this.owner,
      );

  factory Pdf.fromJson(String str) => Pdf.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pdf.fromMap(Map<String, dynamic> json) => Pdf(
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        fileUrl: json['file_url'],
        userUid: json['user_uid'],
        title: json['title'],
        thumbnailUrl: json['thumbnail_url'],
        description: json['description'],
        postCreatorType: json['post_creator_type'],
        communityUid: json['community_uid'],
        creatorLatLongWkb: json['creator_lat_long_wkb'],
        uid: json['uid'],
        seoDataWeighted: json['seo_data_weighted'],
        owner: json['owner'] == null ? null : Owner.fromMap(json['owner']),
      );

  Map<String, dynamic> toMap() => {
        'created_at': createdAt?.toIso8601String(),
        'file_url': fileUrl,
        'user_uid': userUid,
        'title': title,
        'thumbnail_url': thumbnailUrl,
        'description': description,
        'post_creator_type': postCreatorType,
        'community_uid': communityUid,
        'creator_lat_long_wkb': creatorLatLongWkb,
        'uid': uid,
        'seo_data_weighted': seoDataWeighted,
        'owner': owner?.toMap(),
      };
}

class Owner {
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

  Owner({
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

  Owner copyWith({
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
      Owner(
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

  factory Owner.fromJson(String str) => Owner.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Owner.fromMap(Map<String, dynamic> json) => Owner(
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
