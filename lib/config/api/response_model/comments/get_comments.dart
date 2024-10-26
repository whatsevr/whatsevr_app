import 'dart:convert';

class GetCommentsResponse {
  final String? message;
  final int? page;
  final bool? lastPage;
  final List<Comment>? comments;

  GetCommentsResponse({
    this.message,
    this.page,
    this.lastPage,
    this.comments,
  });

  GetCommentsResponse copyWith({
    String? message,
    int? page,
    bool? lastPage,
    List<Comment>? comments,
  }) =>
      GetCommentsResponse(
        message: message ?? this.message,
        page: page ?? this.page,
        lastPage: lastPage ?? this.lastPage,
        comments: comments ?? this.comments,
      );

  factory GetCommentsResponse.fromJson(String str) =>
      GetCommentsResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetCommentsResponse.fromMap(Map<String, dynamic> json) =>
      GetCommentsResponse(
        message: json["message"],
        page: json["page"],
        lastPage: json["last_page"],
        comments: json["comments"] == null
            ? []
            : List<Comment>.from(
                json["comments"]!.map((x) => Comment.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "page": page,
        "last_page": lastPage,
        "comments": comments == null
            ? []
            : List<dynamic>.from(comments!.map((x) => x.toMap())),
      };
}

class Comment {
  final DateTime? createdAt;
  final String? commentText;
  final String? userUid;
  final String? videoPostUid;
  final dynamic flickPostUid;
  final dynamic memoryUid;
  final dynamic offerPostUid;
  final dynamic photoPostUid;
  final dynamic pdfUid;
  final String? uid;
  final String? imageUrl;
  final List<UserCommentReply>? userCommentReplies;
  final CommentAuthor? author;

  Comment({
    this.createdAt,
    this.commentText,
    this.userUid,
    this.videoPostUid,
    this.flickPostUid,
    this.memoryUid,
    this.offerPostUid,
    this.photoPostUid,
    this.pdfUid,
    this.uid,
    this.imageUrl,
    this.userCommentReplies,
    this.author,
  });

  Comment copyWith({
    DateTime? createdAt,
    String? commentText,
    String? userUid,
    String? videoPostUid,
    dynamic flickPostUid,
    dynamic memoryUid,
    dynamic offerPostUid,
    dynamic photoPostUid,
    dynamic pdfUid,
    String? uid,
    String? imageUrl,
    List<UserCommentReply>? userCommentReplies,
    CommentAuthor? author,
  }) =>
      Comment(
        createdAt: createdAt ?? this.createdAt,
        commentText: commentText ?? this.commentText,
        userUid: userUid ?? this.userUid,
        videoPostUid: videoPostUid ?? this.videoPostUid,
        flickPostUid: flickPostUid ?? this.flickPostUid,
        memoryUid: memoryUid ?? this.memoryUid,
        offerPostUid: offerPostUid ?? this.offerPostUid,
        photoPostUid: photoPostUid ?? this.photoPostUid,
        pdfUid: pdfUid ?? this.pdfUid,
        uid: uid ?? this.uid,
        imageUrl: imageUrl ?? this.imageUrl,
        userCommentReplies: userCommentReplies ?? this.userCommentReplies,
        author: author ?? this.author,
      );

  factory Comment.fromJson(String str) => Comment.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Comment.fromMap(Map<String, dynamic> json) => Comment(
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        commentText: json["comment_text"],
        userUid: json["user_uid"],
        videoPostUid: json["video_post_uid"],
        flickPostUid: json["flick_post_uid"],
        memoryUid: json["memory_uid"],
        offerPostUid: json["offer_post_uid"],
        photoPostUid: json["photo_post_uid"],
        pdfUid: json["pdf_uid"],
        uid: json["uid"],
        imageUrl: json["image_url"],
        userCommentReplies: json["user_comment_replies"] == null
            ? []
            : List<UserCommentReply>.from(json["user_comment_replies"]!
                .map((x) => UserCommentReply.fromMap(x))),
        author: json["author"] == null
            ? null
            : CommentAuthor.fromMap(json["author"]),
      );

  Map<String, dynamic> toMap() => {
        "created_at": createdAt?.toIso8601String(),
        "comment_text": commentText,
        "user_uid": userUid,
        "video_post_uid": videoPostUid,
        "flick_post_uid": flickPostUid,
        "memory_uid": memoryUid,
        "offer_post_uid": offerPostUid,
        "photo_post_uid": photoPostUid,
        "pdf_uid": pdfUid,
        "uid": uid,
        "image_url": imageUrl,
        "user_comment_replies": userCommentReplies == null
            ? []
            : List<dynamic>.from(userCommentReplies!.map((x) => x.toMap())),
        "author": author?.toMap(),
      };
}

class CommentAuthor {
  final String? bio;
  final DateTime? dob;
  final String? uid;
  final String? name;
  final String? gender;
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
  final int? totalConnections;
  final DateTime? portfolioCreatedAt;
  final String? portfolioDescription;
  final String? userLastLatLongWkb;

  CommentAuthor({
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

  CommentAuthor copyWith({
    String? bio,
    DateTime? dob,
    String? uid,
    String? name,
    String? gender,
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
    int? totalConnections,
    DateTime? portfolioCreatedAt,
    String? portfolioDescription,
    String? userLastLatLongWkb,
  }) =>
      CommentAuthor(
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

  factory CommentAuthor.fromJson(String str) =>
      CommentAuthor.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CommentAuthor.fromMap(Map<String, dynamic> json) => CommentAuthor(
        bio: json["bio"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
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
        totalConnections: json["total_connections"],
        portfolioCreatedAt: json["portfolio_created_at"] == null
            ? null
            : DateTime.parse(json["portfolio_created_at"]),
        portfolioDescription: json["portfolio_description"],
        userLastLatLongWkb: json["user_last_lat_long_wkb"],
      );

  Map<String, dynamic> toMap() => {
        "bio": bio,
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
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
        "total_connections": totalConnections,
        "portfolio_created_at": portfolioCreatedAt?.toIso8601String(),
        "portfolio_description": portfolioDescription,
        "user_last_lat_long_wkb": userLastLatLongWkb,
      };
}

class UserCommentReply {
  final String? uid;
  final UserCommentReplyAuthor? author;
  final String? userUid;
  final DateTime? createdAt;
  final String? replyText;
  final String? commentUid;

  UserCommentReply({
    this.uid,
    this.author,
    this.userUid,
    this.createdAt,
    this.replyText,
    this.commentUid,
  });

  UserCommentReply copyWith({
    String? uid,
    UserCommentReplyAuthor? author,
    String? userUid,
    DateTime? createdAt,
    String? replyText,
    String? commentUid,
  }) =>
      UserCommentReply(
        uid: uid ?? this.uid,
        author: author ?? this.author,
        userUid: userUid ?? this.userUid,
        createdAt: createdAt ?? this.createdAt,
        replyText: replyText ?? this.replyText,
        commentUid: commentUid ?? this.commentUid,
      );

  factory UserCommentReply.fromJson(String str) =>
      UserCommentReply.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserCommentReply.fromMap(Map<String, dynamic> json) =>
      UserCommentReply(
        uid: json["uid"],
        author: json["author"] == null
            ? null
            : UserCommentReplyAuthor.fromMap(json["author"]),
        userUid: json["user_uid"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        replyText: json["reply_text"],
        commentUid: json["comment_uid"],
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "author": author?.toMap(),
        "user_uid": userUid,
        "created_at": createdAt?.toIso8601String(),
        "reply_text": replyText,
        "comment_uid": commentUid,
      };
}

class UserCommentReplyAuthor {
  final String? bio;
  final DateTime? dob;
  final String? uid;
  final String? name;
  final String? gender;
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
  final int? totalConnections;
  final DateTime? portfolioCreatedAt;
  final String? portfolioDescription;
  final String? userLastLatLongWkb;

  UserCommentReplyAuthor({
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

  UserCommentReplyAuthor copyWith({
    String? bio,
    DateTime? dob,
    String? uid,
    String? name,
    String? gender,
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
    int? totalConnections,
    DateTime? portfolioCreatedAt,
    String? portfolioDescription,
    String? userLastLatLongWkb,
  }) =>
      UserCommentReplyAuthor(
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

  factory UserCommentReplyAuthor.fromJson(String str) =>
      UserCommentReplyAuthor.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserCommentReplyAuthor.fromMap(Map<String, dynamic> json) =>
      UserCommentReplyAuthor(
        bio: json["bio"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
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
        totalConnections: json["total_connections"],
        portfolioCreatedAt: json["portfolio_created_at"] == null
            ? null
            : DateTime.parse(json["portfolio_created_at"]),
        portfolioDescription: json["portfolio_description"],
        userLastLatLongWkb: json["user_last_lat_long_wkb"],
      );

  Map<String, dynamic> toMap() => {
        "bio": bio,
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
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
        "total_connections": totalConnections,
        "portfolio_created_at": portfolioCreatedAt?.toIso8601String(),
        "portfolio_description": portfolioDescription,
        "user_last_lat_long_wkb": userLastLatLongWkb,
      };
}
