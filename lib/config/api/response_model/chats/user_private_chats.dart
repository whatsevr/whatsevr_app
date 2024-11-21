import 'dart:convert';

class UserPrivateChatsResponse {
    final String? message;
    final int? page;
    final bool? lastPage;
    final List<Chat>? chats;

    UserPrivateChatsResponse({
        this.message,
        this.page,
        this.lastPage,
        this.chats,
    });

    UserPrivateChatsResponse copyWith({
        String? message,
        int? page,
        bool? lastPage,
        List<Chat>? chats,
    }) => 
        UserPrivateChatsResponse(
            message: message ?? this.message,
            page: page ?? this.page,
            lastPage: lastPage ?? this.lastPage,
            chats: chats ?? this.chats,
        );

    factory UserPrivateChatsResponse.fromJson(String str) => UserPrivateChatsResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UserPrivateChatsResponse.fromMap(Map<String, dynamic> json) => UserPrivateChatsResponse(
        message: json["message"],
        page: json["page"],
        lastPage: json["last_page"],
        chats: json["chats"] == null ? [] : List<Chat>.from(json["chats"]!.map((x) => Chat.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "message": message,
        "page": page,
        "last_page": lastPage,
        "chats": chats == null ? [] : List<dynamic>.from(chats!.map((x) => x.toMap())),
    };
}

class Chat {
    final String? uid;
    final String? user1Uid;
    final String? user2Uid;
    final DateTime? createdAt;
    final DateTime? lastMessageAt;
    final bool? user1IsMuted;
    final bool? user2IsMuted;
    final bool? user1IsBlocked;
    final bool? user2IsBlocked;
    final String? plainLastMessage;
    final User? user1;
    final User? user2;

    Chat({
        this.uid,
        this.user1Uid,
        this.user2Uid,
        this.createdAt,
        this.lastMessageAt,
        this.user1IsMuted,
        this.user2IsMuted,
        this.user1IsBlocked,
        this.user2IsBlocked,
        this.plainLastMessage,
        this.user1,
        this.user2,
    });

    Chat copyWith({
        String? uid,
        String? user1Uid,
        String? user2Uid,
        DateTime? createdAt,
        DateTime? lastMessageAt,
        bool? user1IsMuted,
        bool? user2IsMuted,
        bool? user1IsBlocked,
        bool? user2IsBlocked,
        String? plainLastMessage,
        User? user1,
        User? user2,
    }) => 
        Chat(
            uid: uid ?? this.uid,
            user1Uid: user1Uid ?? this.user1Uid,
            user2Uid: user2Uid ?? this.user2Uid,
            createdAt: createdAt ?? this.createdAt,
            lastMessageAt: lastMessageAt ?? this.lastMessageAt,
            user1IsMuted: user1IsMuted ?? this.user1IsMuted,
            user2IsMuted: user2IsMuted ?? this.user2IsMuted,
            user1IsBlocked: user1IsBlocked ?? this.user1IsBlocked,
            user2IsBlocked: user2IsBlocked ?? this.user2IsBlocked,
            plainLastMessage: plainLastMessage ?? this.plainLastMessage,
            user1: user1 ?? this.user1,
            user2: user2 ?? this.user2,
        );

    factory Chat.fromJson(String str) => Chat.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Chat.fromMap(Map<String, dynamic> json) => Chat(
        uid: json["uid"],
        user1Uid: json["user1_uid"],
        user2Uid: json["user2_uid"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        lastMessageAt: json["last_message_at"] == null ? null : DateTime.parse(json["last_message_at"]),
        user1IsMuted: json["user1_is_muted"],
        user2IsMuted: json["user2_is_muted"],
        user1IsBlocked: json["user1_is_blocked"],
        user2IsBlocked: json["user2_is_blocked"],
        plainLastMessage: json["plain_last_message"],
        user1: json["user1"] == null ? null : User.fromMap(json["user1"]),
        user2: json["user2"] == null ? null : User.fromMap(json["user2"]),
    );

    Map<String, dynamic> toMap() => {
        "uid": uid,
        "user1_uid": user1Uid,
        "user2_uid": user2Uid,
        "created_at": createdAt?.toIso8601String(),
        "last_message_at": lastMessageAt?.toIso8601String(),
        "user1_is_muted": user1IsMuted,
        "user2_is_muted": user2IsMuted,
        "user1_is_blocked": user1IsBlocked,
        "user2_is_blocked": user2IsBlocked,
        "plain_last_message": plainLastMessage,
        "user1": user1?.toMap(),
        "user2": user2?.toMap(),
    };
}

class User {
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
        this.seoDataWeighted,
        this.totalConnections,
        this.portfolioCreatedAt,
        this.portfolioDescription,
        this.userLastLatLongWkb,
    });

    User copyWith({
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
            seoDataWeighted: seoDataWeighted ?? this.seoDataWeighted,
            totalConnections: totalConnections ?? this.totalConnections,
            portfolioCreatedAt: portfolioCreatedAt ?? this.portfolioCreatedAt,
            portfolioDescription: portfolioDescription ?? this.portfolioDescription,
            userLastLatLongWkb: userLastLatLongWkb ?? this.userLastLatLongWkb,
        );

    factory User.fromJson(String str) => User.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory User.fromMap(Map<String, dynamic> json) => User(
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
        registeredOn: json["registered_on"] == null ? null : DateTime.parse(json["registered_on"]),
        isDeactivated: json["is_deactivated"],
        lastActiveAt: json["last_active_at"] == null ? null : DateTime.parse(json["last_active_at"]),
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
