import 'dart:convert';

class UserTrackedActivitiesResponse {
    String? message;
    int? page;
    bool? lastPage;
    List<Activity>? activities;

    UserTrackedActivitiesResponse({
        this.message,
        this.page,
        this.lastPage,
        this.activities,
    });

    UserTrackedActivitiesResponse copyWith({
        String? message,
        int? page,
        bool? lastPage,
        List<Activity>? activities,
    }) => 
        UserTrackedActivitiesResponse(
            message: message ?? this.message,
            page: page ?? this.page,
            lastPage: lastPage ?? this.lastPage,
            activities: activities ?? this.activities,
        );

    factory UserTrackedActivitiesResponse.fromJson(String str) => UserTrackedActivitiesResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UserTrackedActivitiesResponse.fromMap(Map<String, dynamic> json) => UserTrackedActivitiesResponse(
        message: json["message"],
        page: json["page"],
        lastPage: json["last_page"],
        activities: json["activities"] == null ? [] : List<Activity>.from(json["activities"]!.map((x) => Activity.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "message": message,
        "page": page,
        "last_page": lastPage,
        "activities": activities == null ? [] : List<dynamic>.from(activities!.map((x) => x.toMap())),
    };
}

class Activity {
    String? uid;
    String? userUid;
    String? wtvUid;
    String? flickUid;
    String? photoUid;
    String? offerUid;
    String? memoryUid;
    String? pdfUid;
    DateTime? activityAt;
    String? deviceOs;
    String? deviceModel;
    String? geoLocation;
    String? appVersion;
    String? activityType;
    String? userAgentUid;
    String? commentUid;
    String? commentReplyUid;
   
    Map<String, dynamic>? metadata;
    Flick? wtv;
    Flick? flick;
    Flick? photo;
    Offer? offer;
    Memory? memory;
    Pdf? pdf;
    Comment? comment;
    CommentReply? commentReply;

    Activity({
        this.uid,
        this.userUid,
        this.wtvUid,
        this.flickUid,
        this.photoUid,
        this.offerUid,
        this.memoryUid,
        this.pdfUid,
        this.activityAt,
        this.deviceOs,
        this.deviceModel,
        this.geoLocation,
        this.appVersion,
        this.activityType,
        this.userAgentUid,
        this.commentUid,
        this.commentReplyUid,
      
        this.metadata,
        this.wtv,
        this.flick,
        this.photo,
        this.offer,
        this.memory,
        this.pdf,
        this.comment,
        this.commentReply,
    });

    Activity copyWith({
        String? uid,
        String? userUid,
        String? wtvUid,
        String? flickUid,
        String? photoUid,
        String? offerUid,
        String? memoryUid,
        String? pdfUid,
        DateTime? activityAt,
        String? deviceOs,
        String? deviceModel,
        String? geoLocation,
        String? appVersion,
        String? activityType,
        String? userAgentUid,
        String? commentUid,
        String? commentReplyUid,
       
        Map<String, dynamic>? metadata,
        Flick? wtv,
        Flick? flick,
        Flick? photo,
        Offer? offer,
        Memory? memory,
        Pdf? pdf,
        Comment? comment,
        CommentReply? commentReply,
    }) => 
        Activity(
            uid: uid ?? this.uid,
            userUid: userUid ?? this.userUid,
            wtvUid: wtvUid ?? this.wtvUid,
            flickUid: flickUid ?? this.flickUid,
            photoUid: photoUid ?? this.photoUid,
            offerUid: offerUid ?? this.offerUid,
            memoryUid: memoryUid ?? this.memoryUid,
            pdfUid: pdfUid ?? this.pdfUid,
            activityAt: activityAt ?? this.activityAt,
            deviceOs: deviceOs ?? this.deviceOs,
            deviceModel: deviceModel ?? this.deviceModel,
            geoLocation: geoLocation ?? this.geoLocation,
            appVersion: appVersion ?? this.appVersion,
            activityType: activityType ?? this.activityType,
            userAgentUid: userAgentUid ?? this.userAgentUid,
            commentUid: commentUid ?? this.commentUid,
            commentReplyUid: commentReplyUid ?? this.commentReplyUid,
            
            metadata: metadata ?? this.metadata,
            wtv: wtv ?? this.wtv,
            flick: flick ?? this.flick,
            photo: photo ?? this.photo,
            offer: offer ?? this.offer,
            memory: memory ?? this.memory,
            pdf: pdf ?? this.pdf,
            comment: comment ?? this.comment,
            commentReply: commentReply ?? this.commentReply,
        );

    factory Activity.fromJson(String str) => Activity.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Activity.fromMap(Map<String, dynamic> json) => Activity(
        uid: json["uid"],
        userUid: json["user_uid"],
        wtvUid: json["wtv_uid"],
        flickUid: json["flick_uid"],
        photoUid: json["photo_uid"],
        offerUid: json["offer_uid"],
        memoryUid: json["memory_uid"],
        pdfUid: json["pdf_uid"],
        activityAt: json["activity_at"] == null ? null : DateTime.parse(json["activity_at"]),
        deviceOs: json["device_os"],
        deviceModel: json["device_model"],
        geoLocation: json["geo_location"],
        appVersion: json["app_version"],
        activityType: json["activity_type"],
        userAgentUid: json["user_agent_uid"],
        commentUid: json["comment_uid"],
        commentReplyUid: json["comment_reply_uid"],
        
        metadata: json["metadata"] != null ? Map<String, dynamic>.from(json["metadata"]) : null,
        wtv: json["wtv"] == null ? null : Flick.fromMap(json["wtv"]),
        flick: json["flick"] == null ? null : Flick.fromMap(json["flick"]),
        photo: json["photo"] == null ? null : Flick.fromMap(json["photo"]),
        offer: json["offer"] == null ? null : Offer.fromMap(json["offer"]),
        memory: json["memory"] == null ? null : Memory.fromMap(json["memory"]),
        pdf: json["pdf"] == null ? null : Pdf.fromMap(json["pdf"]),
        comment: json["comment"] == null ? null : Comment.fromMap(json["comment"]),
        commentReply: json["comment_reply"] == null ? null : CommentReply.fromMap(json["comment_reply"]),
    );

    Map<String, dynamic> toMap() => {
        "uid": uid,
        "user_uid": userUid,
        "wtv_uid": wtvUid,
        "flick_uid": flickUid,
        "photo_uid": photoUid,
        "offer_uid": offerUid,
        "memory_uid": memoryUid,
        "pdf_uid": pdfUid,
        "activity_at": activityAt?.toIso8601String(),
        "device_os": deviceOs,
        "device_model": deviceModel,
        "geo_location": geoLocation,
        "app_version": appVersion,
        "activity_type": activityType,
        "user_agent_uid": userAgentUid,
        "comment_uid": commentUid,
        "comment_reply_uid": commentReplyUid,
   
        "metadata": metadata,
        "wtv": wtv?.toMap(),
        "flick": flick?.toMap(),
        "photo": photo?.toMap(),
        "offer": offer?.toMap(),
        "memory": memory?.toMap(),
        "pdf": pdf?.toMap(),
        "comment": comment?.toMap(),
        "comment_reply": commentReply?.toMap(),
    };
}

class Comment {
    String? uid;
    dynamic pdfUid;
    String? userUid;
    dynamic imageUrl;
    DateTime? createdAt;
    dynamic memoryUid;
    String? commentText;
    String? flickPostUid;
    dynamic offerPostUid;
    dynamic photoPostUid;
    dynamic videoPostUid;

    Comment({
        this.uid,
        this.pdfUid,
        this.userUid,
        this.imageUrl,
        this.createdAt,
        this.memoryUid,
        this.commentText,
        this.flickPostUid,
        this.offerPostUid,
        this.photoPostUid,
        this.videoPostUid,
    });

    Comment copyWith({
        String? uid,
        dynamic pdfUid,
        String? userUid,
        dynamic imageUrl,
        DateTime? createdAt,
        dynamic memoryUid,
        String? commentText,
        String? flickPostUid,
        dynamic offerPostUid,
        dynamic photoPostUid,
        dynamic videoPostUid,
    }) => 
        Comment(
            uid: uid ?? this.uid,
            pdfUid: pdfUid ?? this.pdfUid,
            userUid: userUid ?? this.userUid,
            imageUrl: imageUrl ?? this.imageUrl,
            createdAt: createdAt ?? this.createdAt,
            memoryUid: memoryUid ?? this.memoryUid,
            commentText: commentText ?? this.commentText,
            flickPostUid: flickPostUid ?? this.flickPostUid,
            offerPostUid: offerPostUid ?? this.offerPostUid,
            photoPostUid: photoPostUid ?? this.photoPostUid,
            videoPostUid: videoPostUid ?? this.videoPostUid,
        );

    factory Comment.fromJson(String str) => Comment.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Comment.fromMap(Map<String, dynamic> json) => Comment(
        uid: json["uid"],
        pdfUid: json["pdf_uid"],
        userUid: json["user_uid"],
        imageUrl: json["image_url"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        memoryUid: json["memory_uid"],
        commentText: json["comment_text"],
        flickPostUid: json["flick_post_uid"],
        offerPostUid: json["offer_post_uid"],
        photoPostUid: json["photo_post_uid"],
        videoPostUid: json["video_post_uid"],
    );

    Map<String, dynamic> toMap() => {
        "uid": uid,
        "pdf_uid": pdfUid,
        "user_uid": userUid,
        "image_url": imageUrl,
        "created_at": createdAt?.toIso8601String(),
        "memory_uid": memoryUid,
        "comment_text": commentText,
        "flick_post_uid": flickPostUid,
        "offer_post_uid": offerPostUid,
        "photo_post_uid": photoPostUid,
        "video_post_uid": videoPostUid,
    };
}

class CommentReply {
    String? uid;
    String? userUid;
    DateTime? createdAt;
    String? replyText;
    String? commentUid;

    CommentReply({
        this.uid,
        this.userUid,
        this.createdAt,
        this.replyText,
        this.commentUid,
    });

    CommentReply copyWith({
        String? uid,
        String? userUid,
        DateTime? createdAt,
        String? replyText,
        String? commentUid,
    }) => 
        CommentReply(
            uid: uid ?? this.uid,
            userUid: userUid ?? this.userUid,
            createdAt: createdAt ?? this.createdAt,
            replyText: replyText ?? this.replyText,
            commentUid: commentUid ?? this.commentUid,
        );

    factory CommentReply.fromJson(String str) => CommentReply.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CommentReply.fromMap(Map<String, dynamic> json) => CommentReply(
        uid: json["uid"],
        userUid: json["user_uid"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        replyText: json["reply_text"],
        commentUid: json["comment_uid"],
    );

    Map<String, dynamic> toMap() => {
        "uid": uid,
        "user_uid": userUid,
        "created_at": createdAt?.toIso8601String(),
        "reply_text": replyText,
        "comment_uid": commentUid,
    };
}

class Flick {
    String? uid;
    String? title;
    List<String>? hashtags;
    String? location;
    String? userUid;
    bool? isActive;
    String? thumbnail;
    String? videoUrl;
    DateTime? createdAt;
    bool? isDeleted;
    DateTime? updatedAt;
    String? description;
    bool? isArchived;
    int? totalLikes;
    int? totalViews;
    int? totalShares;
    dynamic communityUid;
    int? totalComments;
    int? cumulativeScore;
    dynamic taggedUserUids;
    String? postCreatorType;
    String? seoDataWeighted;
    dynamic addressLatLongWkb;
    dynamic creatorLatLongWkb;
    dynamic taggedCommunityUids;
    int? videoDurationInSec;
    String? internalAiDescription;
    List<FilesDatum>? filesData;
    int? totalImpressions;

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
        this.filesData,
        this.totalImpressions,
    });

    Flick copyWith({
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
        dynamic communityUid,
        int? totalComments,
        int? cumulativeScore,
        dynamic taggedUserUids,
        String? postCreatorType,
        String? seoDataWeighted,
        dynamic addressLatLongWkb,
        dynamic creatorLatLongWkb,
        dynamic taggedCommunityUids,
        int? videoDurationInSec,
        String? internalAiDescription,
        List<FilesDatum>? filesData,
        int? totalImpressions,
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
            filesData: filesData ?? this.filesData,
            totalImpressions: totalImpressions ?? this.totalImpressions,
        );

    factory Flick.fromJson(String str) => Flick.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Flick.fromMap(Map<String, dynamic> json) => Flick(
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
        taggedUserUids: json["tagged_user_uids"],
        postCreatorType: json["post_creator_type"],
        seoDataWeighted: json["seo_data_weighted"],
        addressLatLongWkb: json["address_lat_long_wkb"],
        creatorLatLongWkb: json["creator_lat_long_wkb"],
        taggedCommunityUids: json["tagged_community_uids"],
        videoDurationInSec: json["video_duration_in_sec"],
        internalAiDescription: json["internal_ai_description"],
        filesData: json["files_data"] == null ? [] : List<FilesDatum>.from(json["files_data"]!.map((x) => FilesDatum.fromMap(x))),
        totalImpressions: json["total_impressions"],
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
        "tagged_user_uids": taggedUserUids,
        "post_creator_type": postCreatorType,
        "seo_data_weighted": seoDataWeighted,
        "address_lat_long_wkb": addressLatLongWkb,
        "creator_lat_long_wkb": creatorLatLongWkb,
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

class Memory {
    String? uid;
    String? caption;
    bool? isText;
    List<String>? hashtags;
    bool? isImage;
    bool? isVideo;
    String? location;
    String? userUid;
    String? imageUrl;
    bool? isActive;
    String? videoUrl;
    DateTime? createdAt;
    dynamic ctaAction;
    DateTime? expiresAt;
    bool? isDeleted;
    bool? isArchived;
    int? totalLikes;
    int? totalViews;
    int? totalShares;
    dynamic communityUid;
    dynamic ctaActionUrl;
    int? totalComments;
    int? cumulativeScore;
    dynamic taggedUserUids;
    String? postCreatorType;
    String? seoDataWeighted;
    int? videoDurationMs;
    dynamic addressLatLongWkb;
    dynamic creatorLatLongWkb;
    dynamic taggedCommunityUids;
    String? internalAiDescription;

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
        bool? isText,
        List<String>? hashtags,
        bool? isImage,
        bool? isVideo,
        String? location,
        String? userUid,
        String? imageUrl,
        bool? isActive,
        String? videoUrl,
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
        dynamic taggedUserUids,
        String? postCreatorType,
        String? seoDataWeighted,
        int? videoDurationMs,
        dynamic addressLatLongWkb,
        dynamic creatorLatLongWkb,
        dynamic taggedCommunityUids,
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
        hashtags: json["hashtags"] == null ? [] : List<String>.from(json["hashtags"]!.map((x) => x)),
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
        taggedUserUids: json["tagged_user_uids"],
        postCreatorType: json["post_creator_type"],
        seoDataWeighted: json["seo_data_weighted"],
        videoDurationMs: json["video_duration_ms"],
        addressLatLongWkb: json["address_lat_long_wkb"],
        creatorLatLongWkb: json["creator_lat_long_wkb"],
        taggedCommunityUids: json["tagged_community_uids"],
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
        "tagged_user_uids": taggedUserUids,
        "post_creator_type": postCreatorType,
        "seo_data_weighted": seoDataWeighted,
        "video_duration_ms": videoDurationMs,
        "address_lat_long_wkb": addressLatLongWkb,
        "creator_lat_long_wkb": creatorLatLongWkb,
        "tagged_community_uids": taggedCommunityUids,
        "internal_ai_description": internalAiDescription,
    };
}

class Offer {
    String? uid;
    String? title;
    String? status;
    List<String>? hashtags;
    String? userUid;
    bool? isActive;
    DateTime? createdAt;
    String? ctaAction;
    List<dynamic>? filesData;
    bool? isDeleted;
    String? description;
    bool? isArchived;
    int? totalLikes;
    List<String>? targetAreas;
    int? totalShares;
    dynamic communityUid;
    String? targetGender;
    String? ctaActionUrl;
    int? totalComments;
    int? cumulativeScore;
    dynamic taggedUserUids;
    String? postCreatorType;
    String? seoDataWeighted;
    int? totalImpressions;
    dynamic creatorLatLongWkb;
    dynamic taggedCommunityUids;
    String? internalAiDescription;

    Offer({
        this.uid,
        this.title,
        this.status,
        this.hashtags,
        this.userUid,
        this.isActive,
        this.createdAt,
        this.ctaAction,
        this.filesData,
        this.isDeleted,
        this.description,
        this.isArchived,
        this.totalLikes,
        this.targetAreas,
        this.totalShares,
        this.communityUid,
        this.targetGender,
        this.ctaActionUrl,
        this.totalComments,
        this.cumulativeScore,
        this.taggedUserUids,
        this.postCreatorType,
        this.seoDataWeighted,
        this.totalImpressions,
        this.creatorLatLongWkb,
        this.taggedCommunityUids,
        this.internalAiDescription,
    });

    Offer copyWith({
        String? uid,
        String? title,
        String? status,
        List<String>? hashtags,
        String? userUid,
        bool? isActive,
        DateTime? createdAt,
        String? ctaAction,
        List<dynamic>? filesData,
        bool? isDeleted,
        String? description,
        bool? isArchived,
        int? totalLikes,
        List<String>? targetAreas,
        int? totalShares,
        dynamic communityUid,
        String? targetGender,
        String? ctaActionUrl,
        int? totalComments,
        int? cumulativeScore,
        dynamic taggedUserUids,
        String? postCreatorType,
        String? seoDataWeighted,
        int? totalImpressions,
        dynamic creatorLatLongWkb,
        dynamic taggedCommunityUids,
        String? internalAiDescription,
    }) => 
        Offer(
            uid: uid ?? this.uid,
            title: title ?? this.title,
            status: status ?? this.status,
            hashtags: hashtags ?? this.hashtags,
            userUid: userUid ?? this.userUid,
            isActive: isActive ?? this.isActive,
            createdAt: createdAt ?? this.createdAt,
            ctaAction: ctaAction ?? this.ctaAction,
            filesData: filesData ?? this.filesData,
            isDeleted: isDeleted ?? this.isDeleted,
            description: description ?? this.description,
            isArchived: isArchived ?? this.isArchived,
            totalLikes: totalLikes ?? this.totalLikes,
            targetAreas: targetAreas ?? this.targetAreas,
            totalShares: totalShares ?? this.totalShares,
            communityUid: communityUid ?? this.communityUid,
            targetGender: targetGender ?? this.targetGender,
            ctaActionUrl: ctaActionUrl ?? this.ctaActionUrl,
            totalComments: totalComments ?? this.totalComments,
            cumulativeScore: cumulativeScore ?? this.cumulativeScore,
            taggedUserUids: taggedUserUids ?? this.taggedUserUids,
            postCreatorType: postCreatorType ?? this.postCreatorType,
            seoDataWeighted: seoDataWeighted ?? this.seoDataWeighted,
            totalImpressions: totalImpressions ?? this.totalImpressions,
            creatorLatLongWkb: creatorLatLongWkb ?? this.creatorLatLongWkb,
            taggedCommunityUids: taggedCommunityUids ?? this.taggedCommunityUids,
            internalAiDescription: internalAiDescription ?? this.internalAiDescription,
        );

    factory Offer.fromJson(String str) => Offer.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Offer.fromMap(Map<String, dynamic> json) => Offer(
        uid: json["uid"],
        title: json["title"],
        status: json["status"],
        hashtags: json["hashtags"] == null ? [] : List<String>.from(json["hashtags"]!.map((x) => x)),
        userUid: json["user_uid"],
        isActive: json["is_active"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        ctaAction: json["cta_action"],
        filesData: json["files_data"] == null ? [] : List<dynamic>.from(json["files_data"]!.map((x) => x)),
        isDeleted: json["is_deleted"],
        description: json["description"],
        isArchived: json["is_archived"],
        totalLikes: json["total_likes"],
        targetAreas: json["target_areas"] == null ? [] : List<String>.from(json["target_areas"]!.map((x) => x)),
        totalShares: json["total_shares"],
        communityUid: json["community_uid"],
        targetGender: json["target_gender"],
        ctaActionUrl: json["cta_action_url"],
        totalComments: json["total_comments"],
        cumulativeScore: json["cumulative_score"],
        taggedUserUids: json["tagged_user_uids"],
        postCreatorType: json["post_creator_type"],
        seoDataWeighted: json["seo_data_weighted"],
        totalImpressions: json["total_impressions"],
        creatorLatLongWkb: json["creator_lat_long_wkb"],
        taggedCommunityUids: json["tagged_community_uids"],
        internalAiDescription: json["internal_ai_description"],
    );

    Map<String, dynamic> toMap() => {
        "uid": uid,
        "title": title,
        "status": status,
        "hashtags": hashtags == null ? [] : List<dynamic>.from(hashtags!.map((x) => x)),
        "user_uid": userUid,
        "is_active": isActive,
        "created_at": createdAt?.toIso8601String(),
        "cta_action": ctaAction,
        "files_data": filesData == null ? [] : List<dynamic>.from(filesData!.map((x) => x)),
        "is_deleted": isDeleted,
        "description": description,
        "is_archived": isArchived,
        "total_likes": totalLikes,
        "target_areas": targetAreas == null ? [] : List<dynamic>.from(targetAreas!.map((x) => x)),
        "total_shares": totalShares,
        "community_uid": communityUid,
        "target_gender": targetGender,
        "cta_action_url": ctaActionUrl,
        "total_comments": totalComments,
        "cumulative_score": cumulativeScore,
        "tagged_user_uids": taggedUserUids,
        "post_creator_type": postCreatorType,
        "seo_data_weighted": seoDataWeighted,
        "total_impressions": totalImpressions,
        "creator_lat_long_wkb": creatorLatLongWkb,
        "tagged_community_uids": taggedCommunityUids,
        "internal_ai_description": internalAiDescription,
    };
}

class Pdf {
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

    Pdf({
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
    });

    Pdf copyWith({
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
    }) => 
        Pdf(
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
        );

    factory Pdf.fromJson(String str) => Pdf.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Pdf.fromMap(Map<String, dynamic> json) => Pdf(
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
    };
}
