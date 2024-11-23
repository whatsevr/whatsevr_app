import 'dart:convert';

class ChatMessagesResponse {
  final String? message;
  final int? page;
  final bool? lastPage;
  final List<Message>? messages;

  ChatMessagesResponse({
    this.message,
    this.page,
    this.lastPage,
    this.messages,
  });

  ChatMessagesResponse copyWith({
    String? message,
    int? page,
    bool? lastPage,
    List<Message>? messages,
  }) =>
      ChatMessagesResponse(
        message: message ?? this.message,
        page: page ?? this.page,
        lastPage: lastPage ?? this.lastPage,
        messages: messages ?? this.messages,
      );

  factory ChatMessagesResponse.fromJson(String str) =>
      ChatMessagesResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChatMessagesResponse.fromMap(Map<String, dynamic> json) =>
      ChatMessagesResponse(
        message: json["message"],
        page: json["page"],
        lastPage: json["last_page"],
        messages: json["messages"] == null
            ? []
            : List<Message>.from(
                json["messages"]!.map((x) => Message.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "page": page,
        "last_page": lastPage,
        "messages": messages == null
            ? []
            : List<dynamic>.from(messages!.map((x) => x.toMap())),
      };
}

class Message {
  final String? uid;
  final String? senderUid;
  final String? message;
  final DateTime? createdAt;
  final bool? isPinned;
  final dynamic communityUid;
  final String? privateChatUid;
  final dynamic flickUid;
  final dynamic memoryUid;
  final dynamic offerUid;
  final dynamic photoPostUid;
  final dynamic videoPostUid;
  final dynamic pdfUid;
  final String? replyToMessageUid;
  final Sender? sender;
  final List<Message>? replyToChatMessage;

  Message({
    this.uid,
    this.senderUid,
    this.message,
    this.createdAt,
    this.isPinned,
    this.communityUid,
    this.privateChatUid,
    this.flickUid,
    this.memoryUid,
    this.offerUid,
    this.photoPostUid,
    this.videoPostUid,
    this.pdfUid,
    this.replyToMessageUid,
    this.sender,
    this.replyToChatMessage,
  });

  Message copyWith({
    String? uid,
    String? senderUid,
    String? message,
    DateTime? createdAt,
    bool? isPinned,
    dynamic communityUid,
    String? privateChatUid,
    dynamic flickUid,
    dynamic memoryUid,
    dynamic offerUid,
    dynamic photoPostUid,
    dynamic videoPostUid,
    dynamic pdfUid,
    String? replyToMessageUid,
    Sender? sender,
    List<Message>? replyToChatMessage,
  }) =>
      Message(
        uid: uid ?? this.uid,
        senderUid: senderUid ?? this.senderUid,
        message: message ?? this.message,
        createdAt: createdAt ?? this.createdAt,
        isPinned: isPinned ?? this.isPinned,
        communityUid: communityUid ?? this.communityUid,
        privateChatUid: privateChatUid ?? this.privateChatUid,
        flickUid: flickUid ?? this.flickUid,
        memoryUid: memoryUid ?? this.memoryUid,
        offerUid: offerUid ?? this.offerUid,
        photoPostUid: photoPostUid ?? this.photoPostUid,
        videoPostUid: videoPostUid ?? this.videoPostUid,
        pdfUid: pdfUid ?? this.pdfUid,
        replyToMessageUid: replyToMessageUid ?? this.replyToMessageUid,
        sender: sender ?? this.sender,
        replyToChatMessage: replyToChatMessage ?? this.replyToChatMessage,
      );

  factory Message.fromJson(String str) => Message.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Message.fromMap(Map<String, dynamic> json) => Message(
        uid: json["uid"],
        senderUid: json["sender_uid"],
        message: json["message"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        isPinned: json["is_pinned"],
        communityUid: json["community_uid"],
        privateChatUid: json["private_chat_uid"],
        flickUid: json["flick_uid"],
        memoryUid: json["memory_uid"],
        offerUid: json["offer_uid"],
        photoPostUid: json["photo_post_uid"],
        videoPostUid: json["video_post_uid"],
        pdfUid: json["pdf_uid"],
        replyToMessageUid: json["reply_to_message_uid"],
        sender: json["sender"] == null ? null : Sender.fromMap(json["sender"]),
        replyToChatMessage: json["reply_to_chat_message"] == null
            ? []
            : List<Message>.from(
                json["reply_to_chat_message"]!.map((x) => Message.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "sender_uid": senderUid,
        "message": message,
        "created_at": createdAt?.toIso8601String(),
        "is_pinned": isPinned,
        "community_uid": communityUid,
        "private_chat_uid": privateChatUid,
        "flick_uid": flickUid,
        "memory_uid": memoryUid,
        "offer_uid": offerUid,
        "photo_post_uid": photoPostUid,
        "video_post_uid": videoPostUid,
        "pdf_uid": pdfUid,
        "reply_to_message_uid": replyToMessageUid,
        "sender": sender?.toMap(),
        "reply_to_chat_message": replyToChatMessage == null
            ? []
            : List<dynamic>.from(replyToChatMessage!.map((x) => x.toMap())),
      };
}

class Sender {
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
  final dynamic mobileNumber;
  final DateTime? registeredOn;
  final bool? isDeactivated;
  final DateTime? lastActiveAt;
  final String? portfolioTitle;
  final dynamic profilePicture;
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

  Sender({
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

  Sender copyWith({
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
    dynamic mobileNumber,
    DateTime? registeredOn,
    bool? isDeactivated,
    DateTime? lastActiveAt,
    String? portfolioTitle,
    dynamic profilePicture,
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
      Sender(
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

  factory Sender.fromJson(String str) => Sender.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Sender.fromMap(Map<String, dynamic> json) => Sender(
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
