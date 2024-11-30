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

    factory ChatMessagesResponse.fromJson(String str) => ChatMessagesResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ChatMessagesResponse.fromMap(Map<String, dynamic> json) => ChatMessagesResponse(
        message: json["message"],
        page: json["page"],
        lastPage: json["last_page"],
        messages: json["messages"] == null ? [] : List<Message>.from(json["messages"]!.map((x) => Message.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "message": message,
        "page": page,
        "last_page": lastPage,
        "messages": messages == null ? [] : List<dynamic>.from(messages!.map((x) => x.toMap())),
    };
}

class Message {
    final String? uid;
    final String? senderUid;
    final String? message;
    final DateTime? createdAt;
    final bool? isPinned;
    final String? communityUid;
    final String? privateChatUid;
    final String? flickUid;
    final String? memoryUid;
    final dynamic offerUid;
    final dynamic photoPostUid;
    final String? videoPostUid;
    final dynamic pdfUid;
    final String? replyToMessageUid;
    final String? forwarderUserUid;
    final bool? isDeleted;
    final bool? isSystemMessage;
    final Sender? sender;
    final VideoPost? videoPost;
    final Flick? flick;
    final Memory? memory;
    final dynamic offer;
    final dynamic photoPost;
    final dynamic pdf;
    final List<dynamic>? replyToChatMessage;

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
        this.forwarderUserUid,
        this.isDeleted,
        this.isSystemMessage,
        this.sender,
        this.videoPost,
        this.flick,
        this.memory,
        this.offer,
        this.photoPost,
        this.pdf,
        this.replyToChatMessage,
    });

    Message copyWith({
        String? uid,
        String? senderUid,
        String? message,
        DateTime? createdAt,
        bool? isPinned,
        String? communityUid,
        String? privateChatUid,
        String? flickUid,
        String? memoryUid,
        dynamic offerUid,
        dynamic photoPostUid,
        String? videoPostUid,
        dynamic pdfUid,
        String? replyToMessageUid,
        String? forwarderUserUid,
        bool? isDeleted,
        bool? isSystemMessage,
        Sender? sender,
        VideoPost? videoPost,
        Flick? flick,
        Memory? memory,
        dynamic offer,
        dynamic photoPost,
        dynamic pdf,
        List<dynamic>? replyToChatMessage,
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
            forwarderUserUid: forwarderUserUid ?? this.forwarderUserUid,
            isDeleted: isDeleted ?? this.isDeleted,
            isSystemMessage: isSystemMessage ?? this.isSystemMessage,
            sender: sender ?? this.sender,
            videoPost: videoPost ?? this.videoPost,
            flick: flick ?? this.flick,
            memory: memory ?? this.memory,
            offer: offer ?? this.offer,
            photoPost: photoPost ?? this.photoPost,
            pdf: pdf ?? this.pdf,
            replyToChatMessage: replyToChatMessage ?? this.replyToChatMessage,
        );

    factory Message.fromJson(String str) => Message.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Message.fromMap(Map<String, dynamic> json) => Message(
        uid: json["uid"],
        senderUid: json["sender_uid"],
        message: json["message"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
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
        forwarderUserUid: json["forwarder_user_uid"],
        isDeleted: json["is_deleted"],
        isSystemMessage: json["is_system_message"],
        sender: json["sender"] == null ? null : Sender.fromMap(json["sender"]),
        videoPost: json["video_post"] == null ? null : VideoPost.fromMap(json["video_post"]),
        flick: json["flick"] == null ? null : Flick.fromMap(json["flick"]),
        memory: json["memory"] == null ? null : Memory.fromMap(json["memory"]),
        offer: json["offer"],
        photoPost: json["photo_post"],
        pdf: json["pdf"],
        replyToChatMessage: json["reply_to_chat_message"] == null ? [] : List<dynamic>.from(json["reply_to_chat_message"]!.map((x) => x)),
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
        "forwarder_user_uid": forwarderUserUid,
        "is_deleted": isDeleted,
        "is_system_message": isSystemMessage,
        "sender": sender?.toMap(),
        "video_post": videoPost?.toMap(),
        "flick": flick?.toMap(),
        "memory": memory?.toMap(),
        "offer": offer,
        "photo_post": photoPost,
        "pdf": pdf,
        "reply_to_chat_message": replyToChatMessage == null ? [] : List<dynamic>.from(replyToChatMessage!.map((x) => x)),
    };
}

class Flick {
    final String? uid;
    final String? title;
    final List<dynamic>? hashtags;
    final dynamic location;
    final String? userUid;
    final bool? isActive;
    final String? thumbnail;
    final String? videoUrl;
    final DateTime? createdAt;
    final bool? isDeleted;
    final DateTime? updatedAt;
    final String? description;
    final bool? isArchived;
    final int? totalLikes;
    final int? totalViews;
    final int? totalShares;
    final dynamic communityUid;
    final int? totalComments;
    final int? cumulativeScore;
    final List<dynamic>? taggedUserUids;
    final String? postCreatorType;
    final String? seoDataWeighted;
    final dynamic addressLatLongWkb;
    final String? creatorLatLongWkb;
    final List<dynamic>? taggedCommunityUids;
    final int? videoDurationInSec;
    final String? internalAiDescription;

    Flick({
        this.uid,
        this.title,
        this.hashtags,
        this.location,
        this.userUid,
        this.isActive,
        this.thumbnail,
        this.videoUrl,
        this.createdAt,
        this.isDeleted,
        this.updatedAt,
        this.description,
        this.isArchived,
        this.totalLikes,
        this.totalViews,
        this.totalShares,
        this.communityUid,
        this.totalComments,
        this.cumulativeScore,
        this.taggedUserUids,
        this.postCreatorType,
        this.seoDataWeighted,
        this.addressLatLongWkb,
        this.creatorLatLongWkb,
        this.taggedCommunityUids,
        this.videoDurationInSec,
        this.internalAiDescription,
    });

    Flick copyWith({
        String? uid,
        String? title,
        List<dynamic>? hashtags,
        dynamic location,
        String? userUid,
        bool? isActive,
        String? thumbnail,
        String? videoUrl,
        DateTime? createdAt,
        bool? isDeleted,
        DateTime? updatedAt,
        String? description,
        bool? isArchived,
        int? totalLikes,
        int? totalViews,
        int? totalShares,
        dynamic communityUid,
        int? totalComments,
        int? cumulativeScore,
        List<dynamic>? taggedUserUids,
        String? postCreatorType,
        String? seoDataWeighted,
        dynamic addressLatLongWkb,
        String? creatorLatLongWkb,
        List<dynamic>? taggedCommunityUids,
        int? videoDurationInSec,
        String? internalAiDescription,
    }) => 
        Flick(
            uid: uid ?? this.uid,
            title: title ?? this.title,
            hashtags: hashtags ?? this.hashtags,
            location: location ?? this.location,
            userUid: userUid ?? this.userUid,
            isActive: isActive ?? this.isActive,
            thumbnail: thumbnail ?? this.thumbnail,
            videoUrl: videoUrl ?? this.videoUrl,
            createdAt: createdAt ?? this.createdAt,
            isDeleted: isDeleted ?? this.isDeleted,
            updatedAt: updatedAt ?? this.updatedAt,
            description: description ?? this.description,
            isArchived: isArchived ?? this.isArchived,
            totalLikes: totalLikes ?? this.totalLikes,
            totalViews: totalViews ?? this.totalViews,
            totalShares: totalShares ?? this.totalShares,
            communityUid: communityUid ?? this.communityUid,
            totalComments: totalComments ?? this.totalComments,
            cumulativeScore: cumulativeScore ?? this.cumulativeScore,
            taggedUserUids: taggedUserUids ?? this.taggedUserUids,
            postCreatorType: postCreatorType ?? this.postCreatorType,
            seoDataWeighted: seoDataWeighted ?? this.seoDataWeighted,
            addressLatLongWkb: addressLatLongWkb ?? this.addressLatLongWkb,
            creatorLatLongWkb: creatorLatLongWkb ?? this.creatorLatLongWkb,
            taggedCommunityUids: taggedCommunityUids ?? this.taggedCommunityUids,
            videoDurationInSec: videoDurationInSec ?? this.videoDurationInSec,
            internalAiDescription: internalAiDescription ?? this.internalAiDescription,
        );

    factory Flick.fromJson(String str) => Flick.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Flick.fromMap(Map<String, dynamic> json) => Flick(
        uid: json["uid"],
        title: json["title"],
        hashtags: json["hashtags"] == null ? [] : List<dynamic>.from(json["hashtags"]!.map((x) => x)),
        location: json["location"],
        userUid: json["user_uid"],
        isActive: json["is_active"],
        thumbnail: json["thumbnail"],
        videoUrl: json["video_url"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        isDeleted: json["is_deleted"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        description: json["description"],
        isArchived: json["is_archived"],
        totalLikes: json["total_likes"],
        totalViews: json["total_views"],
        totalShares: json["total_shares"],
        communityUid: json["community_uid"],
        totalComments: json["total_comments"],
        cumulativeScore: json["cumulative_score"],
        taggedUserUids: json["tagged_user_uids"] == null ? [] : List<dynamic>.from(json["tagged_user_uids"]!.map((x) => x)),
        postCreatorType: json["post_creator_type"],
        seoDataWeighted: json["seo_data_weighted"],
        addressLatLongWkb: json["address_lat_long_wkb"],
        creatorLatLongWkb: json["creator_lat_long_wkb"],
        taggedCommunityUids: json["tagged_community_uids"] == null ? [] : List<dynamic>.from(json["tagged_community_uids"]!.map((x) => x)),
        videoDurationInSec: json["video_duration_in_sec"],
        internalAiDescription: json["internal_ai_description"],
    );

    Map<String, dynamic> toMap() => {
        "uid": uid,
        "title": title,
        "hashtags": hashtags == null ? [] : List<dynamic>.from(hashtags!.map((x) => x)),
        "location": location,
        "user_uid": userUid,
        "is_active": isActive,
        "thumbnail": thumbnail,
        "video_url": videoUrl,
        "created_at": createdAt?.toIso8601String(),
        "is_deleted": isDeleted,
        "updated_at": updatedAt?.toIso8601String(),
        "description": description,
        "is_archived": isArchived,
        "total_likes": totalLikes,
        "total_views": totalViews,
        "total_shares": totalShares,
        "community_uid": communityUid,
        "total_comments": totalComments,
        "cumulative_score": cumulativeScore,
        "tagged_user_uids": taggedUserUids == null ? [] : List<dynamic>.from(taggedUserUids!.map((x) => x)),
        "post_creator_type": postCreatorType,
        "seo_data_weighted": seoDataWeighted,
        "address_lat_long_wkb": addressLatLongWkb,
        "creator_lat_long_wkb": creatorLatLongWkb,
        "tagged_community_uids": taggedCommunityUids == null ? [] : List<dynamic>.from(taggedCommunityUids!.map((x) => x)),
        "video_duration_in_sec": videoDurationInSec,
        "internal_ai_description": internalAiDescription,
    };
}

class Memory {
    final String? uid;
    final String? caption;
    final dynamic isText;
    final List<dynamic>? hashtags;
    final bool? isImage;
    final dynamic isVideo;
    final String? location;
    final String? userUid;
    final String? imageUrl;
    final bool? isActive;
    final dynamic videoUrl;
    final DateTime? createdAt;
    final dynamic ctaAction;
    final DateTime? expiresAt;
    final bool? isDeleted;
    final bool? isArchived;
    final int? totalLikes;
    final int? totalViews;
    final int? totalShares;
    final dynamic communityUid;
    final dynamic ctaActionUrl;
    final int? totalComments;
    final int? cumulativeScore;
    final List<dynamic>? taggedUserUids;
    final String? postCreatorType;
    final String? seoDataWeighted;
    final dynamic videoDurationMs;
    final String? addressLatLongWkb;
    final String? creatorLatLongWkb;
    final List<dynamic>? taggedCommunityUids;
    final String? internalAiDescription;

    Memory({
        this.uid,
        this.caption,
        this.isText,
        this.hashtags,
        this.isImage,
        this.isVideo,
        this.location,
        this.userUid,
        this.imageUrl,
        this.isActive,
        this.videoUrl,
        this.createdAt,
        this.ctaAction,
        this.expiresAt,
        this.isDeleted,
        this.isArchived,
        this.totalLikes,
        this.totalViews,
        this.totalShares,
        this.communityUid,
        this.ctaActionUrl,
        this.totalComments,
        this.cumulativeScore,
        this.taggedUserUids,
        this.postCreatorType,
        this.seoDataWeighted,
        this.videoDurationMs,
        this.addressLatLongWkb,
        this.creatorLatLongWkb,
        this.taggedCommunityUids,
        this.internalAiDescription,
    });

    Memory copyWith({
        String? uid,
        String? caption,
        dynamic isText,
        List<dynamic>? hashtags,
        bool? isImage,
        dynamic isVideo,
        String? location,
        String? userUid,
        String? imageUrl,
        bool? isActive,
        dynamic videoUrl,
        DateTime? createdAt,
        dynamic ctaAction,
        DateTime? expiresAt,
        bool? isDeleted,
        bool? isArchived,
        int? totalLikes,
        int? totalViews,
        int? totalShares,
        dynamic communityUid,
        dynamic ctaActionUrl,
        int? totalComments,
        int? cumulativeScore,
        List<dynamic>? taggedUserUids,
        String? postCreatorType,
        String? seoDataWeighted,
        dynamic videoDurationMs,
        String? addressLatLongWkb,
        String? creatorLatLongWkb,
        List<dynamic>? taggedCommunityUids,
        String? internalAiDescription,
    }) => 
        Memory(
            uid: uid ?? this.uid,
            caption: caption ?? this.caption,
            isText: isText ?? this.isText,
            hashtags: hashtags ?? this.hashtags,
            isImage: isImage ?? this.isImage,
            isVideo: isVideo ?? this.isVideo,
            location: location ?? this.location,
            userUid: userUid ?? this.userUid,
            imageUrl: imageUrl ?? this.imageUrl,
            isActive: isActive ?? this.isActive,
            videoUrl: videoUrl ?? this.videoUrl,
            createdAt: createdAt ?? this.createdAt,
            ctaAction: ctaAction ?? this.ctaAction,
            expiresAt: expiresAt ?? this.expiresAt,
            isDeleted: isDeleted ?? this.isDeleted,
            isArchived: isArchived ?? this.isArchived,
            totalLikes: totalLikes ?? this.totalLikes,
            totalViews: totalViews ?? this.totalViews,
            totalShares: totalShares ?? this.totalShares,
            communityUid: communityUid ?? this.communityUid,
            ctaActionUrl: ctaActionUrl ?? this.ctaActionUrl,
            totalComments: totalComments ?? this.totalComments,
            cumulativeScore: cumulativeScore ?? this.cumulativeScore,
            taggedUserUids: taggedUserUids ?? this.taggedUserUids,
            postCreatorType: postCreatorType ?? this.postCreatorType,
            seoDataWeighted: seoDataWeighted ?? this.seoDataWeighted,
            videoDurationMs: videoDurationMs ?? this.videoDurationMs,
            addressLatLongWkb: addressLatLongWkb ?? this.addressLatLongWkb,
            creatorLatLongWkb: creatorLatLongWkb ?? this.creatorLatLongWkb,
            taggedCommunityUids: taggedCommunityUids ?? this.taggedCommunityUids,
            internalAiDescription: internalAiDescription ?? this.internalAiDescription,
        );

    factory Memory.fromJson(String str) => Memory.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Memory.fromMap(Map<String, dynamic> json) => Memory(
        uid: json["uid"],
        caption: json["caption"],
        isText: json["is_text"],
        hashtags: json["hashtags"] == null ? [] : List<dynamic>.from(json["hashtags"]!.map((x) => x)),
        isImage: json["is_image"],
        isVideo: json["is_video"],
        location: json["location"],
        userUid: json["user_uid"],
        imageUrl: json["image_url"],
        isActive: json["is_active"],
        videoUrl: json["video_url"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        ctaAction: json["cta_action"],
        expiresAt: json["expires_at"] == null ? null : DateTime.parse(json["expires_at"]),
        isDeleted: json["is_deleted"],
        isArchived: json["is_archived"],
        totalLikes: json["total_likes"],
        totalViews: json["total_views"],
        totalShares: json["total_shares"],
        communityUid: json["community_uid"],
        ctaActionUrl: json["cta_action_url"],
        totalComments: json["total_comments"],
        cumulativeScore: json["cumulative_score"],
        taggedUserUids: json["tagged_user_uids"] == null ? [] : List<dynamic>.from(json["tagged_user_uids"]!.map((x) => x)),
        postCreatorType: json["post_creator_type"],
        seoDataWeighted: json["seo_data_weighted"],
        videoDurationMs: json["video_duration_ms"],
        addressLatLongWkb: json["address_lat_long_wkb"],
        creatorLatLongWkb: json["creator_lat_long_wkb"],
        taggedCommunityUids: json["tagged_community_uids"] == null ? [] : List<dynamic>.from(json["tagged_community_uids"]!.map((x) => x)),
        internalAiDescription: json["internal_ai_description"],
    );

    Map<String, dynamic> toMap() => {
        "uid": uid,
        "caption": caption,
        "is_text": isText,
        "hashtags": hashtags == null ? [] : List<dynamic>.from(hashtags!.map((x) => x)),
        "is_image": isImage,
        "is_video": isVideo,
        "location": location,
        "user_uid": userUid,
        "image_url": imageUrl,
        "is_active": isActive,
        "video_url": videoUrl,
        "created_at": createdAt?.toIso8601String(),
        "cta_action": ctaAction,
        "expires_at": expiresAt?.toIso8601String(),
        "is_deleted": isDeleted,
        "is_archived": isArchived,
        "total_likes": totalLikes,
        "total_views": totalViews,
        "total_shares": totalShares,
        "community_uid": communityUid,
        "cta_action_url": ctaActionUrl,
        "total_comments": totalComments,
        "cumulative_score": cumulativeScore,
        "tagged_user_uids": taggedUserUids == null ? [] : List<dynamic>.from(taggedUserUids!.map((x) => x)),
        "post_creator_type": postCreatorType,
        "seo_data_weighted": seoDataWeighted,
        "video_duration_ms": videoDurationMs,
        "address_lat_long_wkb": addressLatLongWkb,
        "creator_lat_long_wkb": creatorLatLongWkb,
        "tagged_community_uids": taggedCommunityUids == null ? [] : List<dynamic>.from(taggedCommunityUids!.map((x) => x)),
        "internal_ai_description": internalAiDescription,
    };
}

class Sender {
    final String? bio;
    final dynamic dob;
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

class VideoPost {
    final String? uid;
    final String? title;
    final List<String>? hashtags;
    final String? location;
    final String? userUid;
    final bool? isActive;
    final String? thumbnail;
    final String? videoUrl;
    final DateTime? createdAt;
    final bool? isDeleted;
    final DateTime? updatedAt;
    final String? description;
    final bool? isArchived;
    final int? totalLikes;
    final int? totalViews;
    final int? totalShares;
    final String? communityUid;
    final int? totalComments;
    final int? cumulativeScore;
    final List<String>? taggedUserUids;
    final String? postCreatorType;
    final String? seoDataWeighted;
    final dynamic addressLatLongWkb;
    final String? creatorLatLongWkb;
    final List<String>? taggedCommunityUids;
    final int? videoDurationInSec;
    final String? internalAiDescription;

    VideoPost({
        this.uid,
        this.title,
        this.hashtags,
        this.location,
        this.userUid,
        this.isActive,
        this.thumbnail,
        this.videoUrl,
        this.createdAt,
        this.isDeleted,
        this.updatedAt,
        this.description,
        this.isArchived,
        this.totalLikes,
        this.totalViews,
        this.totalShares,
        this.communityUid,
        this.totalComments,
        this.cumulativeScore,
        this.taggedUserUids,
        this.postCreatorType,
        this.seoDataWeighted,
        this.addressLatLongWkb,
        this.creatorLatLongWkb,
        this.taggedCommunityUids,
        this.videoDurationInSec,
        this.internalAiDescription,
    });

    VideoPost copyWith({
        String? uid,
        String? title,
        List<String>? hashtags,
        String? location,
        String? userUid,
        bool? isActive,
        String? thumbnail,
        String? videoUrl,
        DateTime? createdAt,
        bool? isDeleted,
        DateTime? updatedAt,
        String? description,
        bool? isArchived,
        int? totalLikes,
        int? totalViews,
        int? totalShares,
        String? communityUid,
        int? totalComments,
        int? cumulativeScore,
        List<String>? taggedUserUids,
        String? postCreatorType,
        String? seoDataWeighted,
        dynamic addressLatLongWkb,
        String? creatorLatLongWkb,
        List<String>? taggedCommunityUids,
        int? videoDurationInSec,
        String? internalAiDescription,
    }) => 
        VideoPost(
            uid: uid ?? this.uid,
            title: title ?? this.title,
            hashtags: hashtags ?? this.hashtags,
            location: location ?? this.location,
            userUid: userUid ?? this.userUid,
            isActive: isActive ?? this.isActive,
            thumbnail: thumbnail ?? this.thumbnail,
            videoUrl: videoUrl ?? this.videoUrl,
            createdAt: createdAt ?? this.createdAt,
            isDeleted: isDeleted ?? this.isDeleted,
            updatedAt: updatedAt ?? this.updatedAt,
            description: description ?? this.description,
            isArchived: isArchived ?? this.isArchived,
            totalLikes: totalLikes ?? this.totalLikes,
            totalViews: totalViews ?? this.totalViews,
            totalShares: totalShares ?? this.totalShares,
            communityUid: communityUid ?? this.communityUid,
            totalComments: totalComments ?? this.totalComments,
            cumulativeScore: cumulativeScore ?? this.cumulativeScore,
            taggedUserUids: taggedUserUids ?? this.taggedUserUids,
            postCreatorType: postCreatorType ?? this.postCreatorType,
            seoDataWeighted: seoDataWeighted ?? this.seoDataWeighted,
            addressLatLongWkb: addressLatLongWkb ?? this.addressLatLongWkb,
            creatorLatLongWkb: creatorLatLongWkb ?? this.creatorLatLongWkb,
            taggedCommunityUids: taggedCommunityUids ?? this.taggedCommunityUids,
            videoDurationInSec: videoDurationInSec ?? this.videoDurationInSec,
            internalAiDescription: internalAiDescription ?? this.internalAiDescription,
        );

    factory VideoPost.fromJson(String str) => VideoPost.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory VideoPost.fromMap(Map<String, dynamic> json) => VideoPost(
        uid: json["uid"],
        title: json["title"],
        hashtags: json["hashtags"] == null ? [] : List<String>.from(json["hashtags"]!.map((x) => x)),
        location: json["location"],
        userUid: json["user_uid"],
        isActive: json["is_active"],
        thumbnail: json["thumbnail"],
        videoUrl: json["video_url"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        isDeleted: json["is_deleted"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        description: json["description"],
        isArchived: json["is_archived"],
        totalLikes: json["total_likes"],
        totalViews: json["total_views"],
        totalShares: json["total_shares"],
        communityUid: json["community_uid"],
        totalComments: json["total_comments"],
        cumulativeScore: json["cumulative_score"],
        taggedUserUids: json["tagged_user_uids"] == null ? [] : List<String>.from(json["tagged_user_uids"]!.map((x) => x)),
        postCreatorType: json["post_creator_type"],
        seoDataWeighted: json["seo_data_weighted"],
        addressLatLongWkb: json["address_lat_long_wkb"],
        creatorLatLongWkb: json["creator_lat_long_wkb"],
        taggedCommunityUids: json["tagged_community_uids"] == null ? [] : List<String>.from(json["tagged_community_uids"]!.map((x) => x)),
        videoDurationInSec: json["video_duration_in_sec"],
        internalAiDescription: json["internal_ai_description"],
    );

    Map<String, dynamic> toMap() => {
        "uid": uid,
        "title": title,
        "hashtags": hashtags == null ? [] : List<dynamic>.from(hashtags!.map((x) => x)),
        "location": location,
        "user_uid": userUid,
        "is_active": isActive,
        "thumbnail": thumbnail,
        "video_url": videoUrl,
        "created_at": createdAt?.toIso8601String(),
        "is_deleted": isDeleted,
        "updated_at": updatedAt?.toIso8601String(),
        "description": description,
        "is_archived": isArchived,
        "total_likes": totalLikes,
        "total_views": totalViews,
        "total_shares": totalShares,
        "community_uid": communityUid,
        "total_comments": totalComments,
        "cumulative_score": cumulativeScore,
        "tagged_user_uids": taggedUserUids == null ? [] : List<dynamic>.from(taggedUserUids!.map((x) => x)),
        "post_creator_type": postCreatorType,
        "seo_data_weighted": seoDataWeighted,
        "address_lat_long_wkb": addressLatLongWkb,
        "creator_lat_long_wkb": creatorLatLongWkb,
        "tagged_community_uids": taggedCommunityUids == null ? [] : List<dynamic>.from(taggedCommunityUids!.map((x) => x)),
        "video_duration_in_sec": videoDurationInSec,
        "internal_ai_description": internalAiDescription,
    };
}
