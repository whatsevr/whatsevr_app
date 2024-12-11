import 'dart:convert';

class UpdateCommunityServicesRequest {
  final String? communityUid;
  final String? userUid;
  final List<CommunityService>? communityServices;

  UpdateCommunityServicesRequest({
    this.communityUid,
    this.userUid,
    this.communityServices,
  });

  UpdateCommunityServicesRequest copyWith({
    String? communityUid,
    String? userUid,
    List<CommunityService>? communityServices,
  }) =>
      UpdateCommunityServicesRequest(
        communityUid: communityUid ?? this.communityUid,
        userUid: userUid ?? this.userUid,
        communityServices: communityServices ?? this.communityServices,
      );

  factory UpdateCommunityServicesRequest.fromJson(String str) =>
      UpdateCommunityServicesRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UpdateCommunityServicesRequest.fromMap(Map<String, dynamic> json) =>
      UpdateCommunityServicesRequest(
        communityUid: json["community_uid"],
        userUid: json["user_uid"],
        communityServices: json["community_services"] == null
            ? []
            : List<CommunityService>.from(json["community_services"]!
                .map((x) => CommunityService.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "community_uid": communityUid,
        "user_uid": userUid,
        "community_services": communityServices == null
            ? []
            : List<dynamic>.from(communityServices!.map((x) => x.toMap())),
      };
}

class CommunityService {
  final String? title;
  final String? communityUid;
  final String? description;

  CommunityService({
    this.title,
    this.communityUid,
    this.description,
  });

  CommunityService copyWith({
    String? title,
    String? communityUid,
    String? description,
  }) =>
      CommunityService(
        title: title ?? this.title,
        communityUid: communityUid ?? this.communityUid,
        description: description ?? this.description,
      );

  factory CommunityService.fromJson(String str) =>
      CommunityService.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CommunityService.fromMap(Map<String, dynamic> json) =>
      CommunityService(
        title: json["title"],
        communityUid: json["community_uid"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "community_uid": communityUid,
        "description": description,
      };
}
