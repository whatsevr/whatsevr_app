import 'dart:convert';

class UserTaggedContentResponse {
    String? message;
    int? page;
    bool? lastPage;
    List<TaggedContent>? taggedContent;

    UserTaggedContentResponse({
        this.message,
        this.page,
        this.lastPage,
        this.taggedContent,
    });

    UserTaggedContentResponse copyWith({
        String? message,
        int? page,
        bool? lastPage,
        List<TaggedContent>? taggedContent,
    }) => 
        UserTaggedContentResponse(
            message: message ?? this.message,
            page: page ?? this.page,
            lastPage: lastPage ?? this.lastPage,
            taggedContent: taggedContent ?? this.taggedContent,
        );

    factory UserTaggedContentResponse.fromJson(String str) => UserTaggedContentResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UserTaggedContentResponse.fromMap(Map<String, dynamic> json) => UserTaggedContentResponse(
        message: json["message"],
        page: json["page"],
        lastPage: json["last_page"],
        taggedContent: json["tagged_content"] == null ? [] : List<TaggedContent>.from(json["tagged_content"]!.map((x) => TaggedContent.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "message": message,
        "page": page,
        "last_page": lastPage,
        "tagged_content": taggedContent == null ? [] : List<dynamic>.from(taggedContent!.map((x) => x.toMap())),
    };
}

class TaggedContent {
    TagInfo? tagInfo;
    String? contentType;
    Content? content;

    TaggedContent({
        this.tagInfo,
        this.contentType,
        this.content,
    });

    TaggedContent copyWith({
        TagInfo? tagInfo,
        String? contentType,
        Content? content,
    }) => 
        TaggedContent(
            tagInfo: tagInfo ?? this.tagInfo,
            contentType: contentType ?? this.contentType,
            content: content ?? this.content,
        );

    factory TaggedContent.fromJson(String str) => TaggedContent.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory TaggedContent.fromMap(Map<String, dynamic> json) => TaggedContent(
        tagInfo: json["tag_info"] == null ? null : TagInfo.fromMap(json["tag_info"]),
        contentType: json["content_type"],
        content: json["content"] == null ? null : Content.fromMap(json["content"]),
    );

    Map<String, dynamic> toMap() => {
        "tag_info": tagInfo?.toMap(),
        "content_type": contentType,
        "content": content?.toMap(),
    };
}

class Content {
    String? uid;
    String? title;
    String? fileUrl;
    String? userUid;
    DateTime? createdAt;
    String? description;
    dynamic communityUid;
    String? thumbnailUrl;
    String? postCreatorType;
    String? seoDataWeighted;
    dynamic creatorLatLongWkb;
    List<String>? hashtags;
    String? location;
    bool? isActive;
    String? thumbnail;
    String? videoUrl;
    bool? isDeleted;
    DateTime? updatedAt;
    bool? isArchived;
    int? totalLikes;
    int? totalViews;
    int? totalShares;
    int? totalComments;
    int? cumulativeScore;
    dynamic taggedUserUids;
    dynamic addressLatLongWkb;
    dynamic taggedCommunityUids;
    int? videoDurationInSec;
    String? internalAiDescription;
    List<FilesDatum>? filesData;
    int? totalImpressions;

    Content({
        this.uid,
        this.title,
        this.fileUrl,
        this.userUid,
        this.createdAt,
        this.description,
        this.communityUid,
        this.thumbnailUrl,
        this.postCreatorType,
        this.seoDataWeighted,
        this.creatorLatLongWkb,
        this.hashtags,
        this.location,
        this.isActive,
        this.thumbnail,
        this.videoUrl,
        this.isDeleted,
        this.updatedAt,
        this.isArchived,
        this.totalLikes,
        this.totalViews,
        this.totalShares,
        this.totalComments,
        this.cumulativeScore,
        this.taggedUserUids,
        this.addressLatLongWkb,
        this.taggedCommunityUids,
        this.videoDurationInSec,
        this.internalAiDescription,
        this.filesData,
        this.totalImpressions,
    });

    Content copyWith({
        String? uid,
        String? title,
        String? fileUrl,
        String? userUid,
        DateTime? createdAt,
        String? description,
        dynamic communityUid,
        String? thumbnailUrl,
        String? postCreatorType,
        String? seoDataWeighted,
        dynamic creatorLatLongWkb,
        List<String>? hashtags,
        String? location,
        bool? isActive,
        String? thumbnail,
        String? videoUrl,
        bool? isDeleted,
        DateTime? updatedAt,
        bool? isArchived,
        int? totalLikes,
        int? totalViews,
        int? totalShares,
        int? totalComments,
        int? cumulativeScore,
        dynamic taggedUserUids,
        dynamic addressLatLongWkb,
        dynamic taggedCommunityUids,
        int? videoDurationInSec,
        String? internalAiDescription,
        List<FilesDatum>? filesData,
        int? totalImpressions,
    }) => 
        Content(
            uid: uid ?? this.uid,
            title: title ?? this.title,
            fileUrl: fileUrl ?? this.fileUrl,
            userUid: userUid ?? this.userUid,
            createdAt: createdAt ?? this.createdAt,
            description: description ?? this.description,
            communityUid: communityUid ?? this.communityUid,
            thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
            postCreatorType: postCreatorType ?? this.postCreatorType,
            seoDataWeighted: seoDataWeighted ?? this.seoDataWeighted,
            creatorLatLongWkb: creatorLatLongWkb ?? this.creatorLatLongWkb,
            hashtags: hashtags ?? this.hashtags,
            location: location ?? this.location,
            isActive: isActive ?? this.isActive,
            thumbnail: thumbnail ?? this.thumbnail,
            videoUrl: videoUrl ?? this.videoUrl,
            isDeleted: isDeleted ?? this.isDeleted,
            updatedAt: updatedAt ?? this.updatedAt,
            isArchived: isArchived ?? this.isArchived,
            totalLikes: totalLikes ?? this.totalLikes,
            totalViews: totalViews ?? this.totalViews,
            totalShares: totalShares ?? this.totalShares,
            totalComments: totalComments ?? this.totalComments,
            cumulativeScore: cumulativeScore ?? this.cumulativeScore,
            taggedUserUids: taggedUserUids ?? this.taggedUserUids,
            addressLatLongWkb: addressLatLongWkb ?? this.addressLatLongWkb,
            taggedCommunityUids: taggedCommunityUids ?? this.taggedCommunityUids,
            videoDurationInSec: videoDurationInSec ?? this.videoDurationInSec,
            internalAiDescription: internalAiDescription ?? this.internalAiDescription,
            filesData: filesData ?? this.filesData,
            totalImpressions: totalImpressions ?? this.totalImpressions,
        );

    factory Content.fromJson(String str) => Content.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Content.fromMap(Map<String, dynamic> json) => Content(
        uid: json["uid"],
        title: json["title"],
        fileUrl: json["file_url"],
        userUid: json["user_uid"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        description: json["description"],
        communityUid: json["community_uid"],
        thumbnailUrl: json["thumbnail_url"],
        postCreatorType: json["post_creator_type"],
        seoDataWeighted: json["seo_data_weighted"],
        creatorLatLongWkb: json["creator_lat_long_wkb"],
        hashtags: json["hashtags"] == null ? [] : List<String>.from(json["hashtags"]!.map((x) => x)),
        location: json["location"],
        isActive: json["is_active"],
        thumbnail: json["thumbnail"],
        videoUrl: json["video_url"],
        isDeleted: json["is_deleted"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        isArchived: json["is_archived"],
        totalLikes: json["total_likes"],
        totalViews: json["total_views"],
        totalShares: json["total_shares"],
        totalComments: json["total_comments"],
        cumulativeScore: json["cumulative_score"],
        taggedUserUids: json["tagged_user_uids"],
        addressLatLongWkb: json["address_lat_long_wkb"],
        taggedCommunityUids: json["tagged_community_uids"],
        videoDurationInSec: json["video_duration_in_sec"],
        internalAiDescription: json["internal_ai_description"],
        filesData: json["files_data"] == null ? [] : List<FilesDatum>.from(json["files_data"]!.map((x) => FilesDatum.fromMap(x))),
        totalImpressions: json["total_impressions"],
    );

    Map<String, dynamic> toMap() => {
        "uid": uid,
        "title": title,
        "file_url": fileUrl,
        "user_uid": userUid,
        "created_at": createdAt?.toIso8601String(),
        "description": description,
        "community_uid": communityUid,
        "thumbnail_url": thumbnailUrl,
        "post_creator_type": postCreatorType,
        "seo_data_weighted": seoDataWeighted,
        "creator_lat_long_wkb": creatorLatLongWkb,
        "hashtags": hashtags == null ? [] : List<dynamic>.from(hashtags!.map((x) => x)),
        "location": location,
        "is_active": isActive,
        "thumbnail": thumbnail,
        "video_url": videoUrl,
        "is_deleted": isDeleted,
        "updated_at": updatedAt?.toIso8601String(),
        "is_archived": isArchived,
        "total_likes": totalLikes,
        "total_views": totalViews,
        "total_shares": totalShares,
        "total_comments": totalComments,
        "cumulative_score": cumulativeScore,
        "tagged_user_uids": taggedUserUids,
        "address_lat_long_wkb": addressLatLongWkb,
        "tagged_community_uids": taggedCommunityUids,
        "video_duration_in_sec": videoDurationInSec,
        "internal_ai_description": internalAiDescription,
        "files_data": filesData == null ? [] : List<dynamic>.from(filesData!.map((x) => x.toMap())),
        "total_impressions": totalImpressions,
    };
}

class FilesDatum {
    String? type;
    String? imageUrl;

    FilesDatum({
        this.type,
        this.imageUrl,
    });

    FilesDatum copyWith({
        String? type,
        String? imageUrl,
    }) => 
        FilesDatum(
            type: type ?? this.type,
            imageUrl: imageUrl ?? this.imageUrl,
        );

    factory FilesDatum.fromJson(String str) => FilesDatum.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory FilesDatum.fromMap(Map<String, dynamic> json) => FilesDatum(
        type: json["type"],
        imageUrl: json["image_url"],
    );

    Map<String, dynamic> toMap() => {
        "type": type,
        "image_url": imageUrl,
    };
}

class TagInfo {
    String? uid;
    DateTime? taggedAt;
    TaggedBy? taggedBy;

    TagInfo({
        this.uid,
        this.taggedAt,
        this.taggedBy,
    });

    TagInfo copyWith({
        String? uid,
        DateTime? taggedAt,
        TaggedBy? taggedBy,
    }) => 
        TagInfo(
            uid: uid ?? this.uid,
            taggedAt: taggedAt ?? this.taggedAt,
            taggedBy: taggedBy ?? this.taggedBy,
        );

    factory TagInfo.fromJson(String str) => TagInfo.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory TagInfo.fromMap(Map<String, dynamic> json) => TagInfo(
        uid: json["uid"],
        taggedAt: json["tagged_at"] == null ? null : DateTime.parse(json["tagged_at"]),
        taggedBy: json["tagged_by"] == null ? null : TaggedBy.fromMap(json["tagged_by"]),
    );

    Map<String, dynamic> toMap() => {
        "uid": uid,
        "tagged_at": taggedAt?.toIso8601String(),
        "tagged_by": taggedBy?.toMap(),
    };
}

class TaggedBy {
    String? bio;
    dynamic dob;
    String? uid;
    String? name;
    dynamic gender;
    String? address;
    bool? isSpam;
    String? emailId;
    String? username;
    bool? isBanned;
    bool? isOnline;
    int? totalLikes;
    bool? isPortfolio;
    String? mobileNumber;
    DateTime? registeredAt;
    bool? isDeactivated;
    DateTime? lastActiveAt;
    String? portfolioTitle;
    dynamic profilePicture;
    String? publicEmailId;
    int? totalFollowers;
    String? portfolioStatus;
    int? totalFollowings;
    int? totalPostLikes;
    String? seoDataWeighted;
    int? totalConnections;
    dynamic portfolioCreatedAt;
    String? portfolioDescription;
    dynamic userLastLatLongWkb;

    TaggedBy({
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
        this.registeredAt,
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

    TaggedBy copyWith({
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
        DateTime? registeredAt,
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
        TaggedBy(
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
            registeredAt: registeredAt ?? this.registeredAt,
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

    factory TaggedBy.fromJson(String str) => TaggedBy.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory TaggedBy.fromMap(Map<String, dynamic> json) => TaggedBy(
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
        registeredAt: json["registered_at"] == null ? null : DateTime.parse(json["registered_at"]),
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
        "registered_at": registeredAt?.toIso8601String(),
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
