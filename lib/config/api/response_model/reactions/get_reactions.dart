import 'dart:convert';

class GetReactionsResponse {
  final String? message;
  final int? page;
  final bool? lastPage;
  final List<Reaction>? reactions;

  GetReactionsResponse({
    this.message,
    this.page,
    this.lastPage,
    this.reactions,
  });

  GetReactionsResponse copyWith({
    String? message,
    int? page,
    bool? lastPage,
    List<Reaction>? reactions,
  }) =>
      GetReactionsResponse(
        message: message ?? this.message,
        page: page ?? this.page,
        lastPage: lastPage ?? this.lastPage,
        reactions: reactions ?? this.reactions,
      );

  factory GetReactionsResponse.fromJson(String str) =>
      GetReactionsResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetReactionsResponse.fromMap(Map<String, dynamic> json) =>
      GetReactionsResponse(
        message: json['message'],
        page: json['page'],
        lastPage: json['last_page'],
        reactions: json['reactions'] == null
            ? []
            : List<Reaction>.from(
                json['reactions']!.map((x) => Reaction.fromMap(x)),),
      );

  Map<String, dynamic> toMap() => {
        'message': message,
        'page': page,
        'last_page': lastPage,
        'reactions': reactions == null
            ? []
            : List<dynamic>.from(reactions!.map((x) => x.toMap())),
      };
}

class Reaction {
  final DateTime? createdAt;
  final String? userUid;
  final dynamic videoPostUid;
  final String? flickPostUid;
  final dynamic memoryUid;
  final dynamic offerPostUid;
  final dynamic photoPostUid;
  final dynamic pdfUid;
  final String? uid;
  final String? reactionType;
  final User? user;

  Reaction({
    this.createdAt,
    this.userUid,
    this.videoPostUid,
    this.flickPostUid,
    this.memoryUid,
    this.offerPostUid,
    this.photoPostUid,
    this.pdfUid,
    this.uid,
    this.reactionType,
    this.user,
  });

  Reaction copyWith({
    DateTime? createdAt,
    String? userUid,
    dynamic videoPostUid,
    String? flickPostUid,
    dynamic memoryUid,
    dynamic offerPostUid,
    dynamic photoPostUid,
    dynamic pdfUid,
    String? uid,
    String? reactionType,
    User? user,
  }) =>
      Reaction(
        createdAt: createdAt ?? this.createdAt,
        userUid: userUid ?? this.userUid,
        videoPostUid: videoPostUid ?? this.videoPostUid,
        flickPostUid: flickPostUid ?? this.flickPostUid,
        memoryUid: memoryUid ?? this.memoryUid,
        offerPostUid: offerPostUid ?? this.offerPostUid,
        photoPostUid: photoPostUid ?? this.photoPostUid,
        pdfUid: pdfUid ?? this.pdfUid,
        uid: uid ?? this.uid,
        reactionType: reactionType ?? this.reactionType,
        user: user ?? this.user,
      );

  factory Reaction.fromJson(String str) => Reaction.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Reaction.fromMap(Map<String, dynamic> json) => Reaction(
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        userUid: json['user_uid'],
        videoPostUid: json['video_post_uid'],
        flickPostUid: json['flick_post_uid'],
        memoryUid: json['memory_uid'],
        offerPostUid: json['offer_post_uid'],
        photoPostUid: json['photo_post_uid'],
        pdfUid: json['pdf_uid'],
        uid: json['uid'],
        reactionType: json['reaction_type'],
        user: json['user'] == null ? null : User.fromMap(json['user']),
      );

  Map<String, dynamic> toMap() => {
        'created_at': createdAt?.toIso8601String(),
        'user_uid': userUid,
        'video_post_uid': videoPostUid,
        'flick_post_uid': flickPostUid,
        'memory_uid': memoryUid,
        'offer_post_uid': offerPostUid,
        'photo_post_uid': photoPostUid,
        'pdf_uid': pdfUid,
        'uid': uid,
        'reaction_type': reactionType,
        'user': user?.toMap(),
      };
}

class User {
  final String? bio;
  final DateTime? dob;
  final String? uid;
  final String? name;
  final String? gender;
  final String? address;
  final bool? isSpam;
  final dynamic emailId;
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
    this.totalConnections,
    this.portfolioCreatedAt,
    this.portfolioDescription,
    this.userLastLatLongWkb,
  });

  User copyWith({
    String? bio,
    DateTime? dob,
    String? uid,
    String? name,
    String? gender,
    String? address,
    bool? isSpam,
    dynamic emailId,
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
        totalConnections: totalConnections ?? this.totalConnections,
        portfolioCreatedAt: portfolioCreatedAt ?? this.portfolioCreatedAt,
        portfolioDescription: portfolioDescription ?? this.portfolioDescription,
        userLastLatLongWkb: userLastLatLongWkb ?? this.userLastLatLongWkb,
      );

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        bio: json['bio'],
        dob: json['dob'] == null ? null : DateTime.parse(json['dob']),
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
        totalConnections: json['total_connections'],
        portfolioCreatedAt: json['portfolio_created_at'],
        portfolioDescription: json['portfolio_description'],
        userLastLatLongWkb: json['user_last_lat_long_wkb'],
      );

  Map<String, dynamic> toMap() => {
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
        'total_connections': totalConnections,
        'portfolio_created_at': portfolioCreatedAt,
        'portfolio_description': portfolioDescription,
        'user_last_lat_long_wkb': userLastLatLongWkb,
      };
}
