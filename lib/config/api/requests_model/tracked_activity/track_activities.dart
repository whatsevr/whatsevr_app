import 'dart:convert';

class TrackActivitiesRequest {
    List<Activity>? activities;

    TrackActivitiesRequest({
        this.activities,
    });

    TrackActivitiesRequest copyWith({
        List<Activity>? activities,
    }) => 
        TrackActivitiesRequest(
            activities: activities ?? this.activities,
        );

    factory TrackActivitiesRequest.fromJson(String str) => TrackActivitiesRequest.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory TrackActivitiesRequest.fromMap(Map<String, dynamic> json) => TrackActivitiesRequest(
        activities: json["activities"] == null ? [] : List<Activity>.from(json["activities"]!.map((x) => Activity.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "activities": activities == null ? [] : List<dynamic>.from(activities!.map((x) => x.toMap())),
    };
}

class Activity {
  
    String? userUid;
    String? activityType;
    String? deviceOs;
    String? deviceModel;
    String? appVersion;
    dynamic geoLocation;
    DateTime? activityAt;
    String? wtvUid;
    String? flickUid;
    String? photoUid;
    String? commentUid;
    String? memoryUid;
    String? commentReplyUid;
    Map<String, dynamic>? metadata;

    Activity({

        this.userUid,
        this.activityType,
        this.deviceOs,
        this.deviceModel,
        this.appVersion,
        this.geoLocation,
        this.activityAt,
        this.wtvUid,
        this.flickUid,
        this.photoUid,
        this.commentUid,
        this.memoryUid,
        this.commentReplyUid,
        this.metadata,
    });

    Activity copyWith({
     
        String? userUid,
        String? activityType,
        String? deviceOs,
        String? deviceModel,
        String? appVersion,
        dynamic geoLocation,
        DateTime? activityAt,
        String? wtvUid,
        String? flickUid,
        String? photoUid,
        String? commentUid,
        String? memoryUid,
        String? commentReplyUid,
        Map<String, dynamic>? metadata,
    }) => 
        Activity(
           
            userUid: userUid ?? this.userUid,
            activityType: activityType ?? this.activityType,
            deviceOs: deviceOs ?? this.deviceOs,
            deviceModel: deviceModel ?? this.deviceModel,
            appVersion: appVersion ?? this.appVersion,
            geoLocation: geoLocation ?? this.geoLocation,
            activityAt: activityAt ?? this.activityAt,
            wtvUid: wtvUid ?? this.wtvUid,
            flickUid: flickUid ?? this.flickUid,
            photoUid: photoUid ?? this.photoUid,
            commentUid: commentUid ?? this.commentUid,
            memoryUid: memoryUid ?? this.memoryUid,
            commentReplyUid: commentReplyUid ?? this.commentReplyUid,
            metadata: metadata ?? this.metadata,
        );

    factory Activity.fromJson(String str) => Activity.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Activity.fromMap(Map<String, dynamic> json) => Activity(

        userUid: json["user_uid"],
        activityType: json["activity_type"],
        deviceOs: json["device_os"],
        deviceModel: json["device_model"],
        appVersion: json["app_version"],
        geoLocation: json["geo_location"],
        activityAt: json["activity_at"] == null ? null : DateTime.parse(json["activity_at"]),
        wtvUid: json["wtv_uid"],
        flickUid: json["flick_uid"],
        photoUid: json["photo_uid"],
        commentUid: json["comment_uid"],
        memoryUid: json["memory_uid"],
        commentReplyUid: json["comment_reply_uid"],
        metadata: json["metadata"] != null ? Map<String, dynamic>.from(json["metadata"]) : null,
    );

    Map<String, dynamic> toMap() => {
        "user_uid": userUid,
        "activity_type": activityType,
        "device_os": deviceOs,
        "device_model": deviceModel,
        "app_version": appVersion,
        "geo_location": geoLocation,
        "activity_at": activityAt?.toIso8601String(),
        "wtv_uid": wtvUid,
        "flick_uid": flickUid,
        "photo_uid": photoUid,
        "comment_uid": commentUid,
        "memory_uid": memoryUid,
        "comment_reply_uid": commentReplyUid,
        "metadata": metadata,
    };
}
