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
    String? userAgentUid;
    String? userUid;
    String? activityType;
    String? wtvUid;
    String? deviceOs;
    String? deviceModel;
    String? appVersion;
    dynamic geoLocation;
    String? flickUid;
    String? description;
    String? photoUid;
    String? commentUid;
    String? memoryUid;

    Activity({
        this.userAgentUid,
        this.userUid,
        this.activityType,
        this.wtvUid,
        this.deviceOs,
        this.deviceModel,
        this.appVersion,
        this.geoLocation,
        this.flickUid,
        this.description,
        this.photoUid,
        this.commentUid,
        this.memoryUid,
    });

    Activity copyWith({
        String? userAgentUid,
        String? userUid,
        String? activityType,
        String? wtvUid,
        String? deviceOs,
        String? deviceModel,
        String? appVersion,
        dynamic geoLocation,
        String? flickUid,
        String? description,
        String? photoUid,
        String? commentUid,
        String? memoryUid,
    }) => 
        Activity(
            userAgentUid: userAgentUid ?? this.userAgentUid,
            userUid: userUid ?? this.userUid,
            activityType: activityType ?? this.activityType,
            wtvUid: wtvUid ?? this.wtvUid,
            deviceOs: deviceOs ?? this.deviceOs,
            deviceModel: deviceModel ?? this.deviceModel,
            appVersion: appVersion ?? this.appVersion,
            geoLocation: geoLocation ?? this.geoLocation,
            flickUid: flickUid ?? this.flickUid,
            description: description ?? this.description,
            photoUid: photoUid ?? this.photoUid,
            commentUid: commentUid ?? this.commentUid,
            memoryUid: memoryUid ?? this.memoryUid,
        );

    factory Activity.fromJson(String str) => Activity.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Activity.fromMap(Map<String, dynamic> json) => Activity(
        userAgentUid: json["user_agent_uid"],
        userUid: json["user_uid"],
        activityType: json["activity_type"],
        wtvUid: json["wtv_uid"],
        deviceOs: json["device_os"],
        deviceModel: json["device_model"],
        appVersion: json["app_version"],
        geoLocation: json["geo_location"],
        flickUid: json["flick_uid"],
        description: json["description"],
        photoUid: json["photo_uid"],
        commentUid: json["comment_uid"],
        memoryUid: json["memory_uid"],
    );

    Map<String, dynamic> toMap() => {
        "user_agent_uid": userAgentUid,
        "user_uid": userUid,
        "activity_type": activityType,
        "wtv_uid": wtvUid,
        "device_os": deviceOs,
        "device_model": deviceModel,
        "app_version": appVersion,
        "geo_location": geoLocation,
        "flick_uid": flickUid,
        "description": description,
        "photo_uid": photoUid,
        "comment_uid": commentUid,
        "memory_uid": memoryUid,
    };
}
