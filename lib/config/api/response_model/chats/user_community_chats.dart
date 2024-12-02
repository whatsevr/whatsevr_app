import 'dart:convert';

class UserCommunityChatsResponse {
  final String? message;
  final int? page;
  final bool? lastPage;
  final List<Community>? communities;

  UserCommunityChatsResponse({
    this.message,
    this.page,
    this.lastPage,
    this.communities,
  });

  UserCommunityChatsResponse copyWith({
    String? message,
    int? page,
    bool? lastPage,
    List<Community>? communities,
  }) =>
      UserCommunityChatsResponse(
        message: message ?? this.message,
        page: page ?? this.page,
        lastPage: lastPage ?? this.lastPage,
        communities: communities ?? this.communities,
      );

  factory UserCommunityChatsResponse.fromJson(String str) =>
      UserCommunityChatsResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserCommunityChatsResponse.fromMap(Map<String, dynamic> json) =>
      UserCommunityChatsResponse(
        message: json['message'],
        page: json['page'],
        lastPage: json['last_page'],
        communities: json['communities'] == null
            ? []
            : List<Community>.from(
                json['communities']!.map((x) => Community.fromMap(x)),),
      );

  Map<String, dynamic> toMap() => {
        'message': message,
        'page': page,
        'last_page': lastPage,
        'communities': communities == null
            ? []
            : List<dynamic>.from(communities!.map((x) => x.toMap())),
      };
}

class Community {
  final DateTime? createdAt;
  final String? adminUserUid;
  final String? status;
  final String? bio;
  final String? location;
  final String? description;
  final String? title;
  final dynamic profilePicture;
  final String? uid;
  final String? username;
  final int? totalMembers;
  final bool? requireJoiningApproval;
  final String? seoDataWeighted;
  final dynamic plainLastMessage;
  final dynamic lastMessageAt;

  Community({
    this.createdAt,
    this.adminUserUid,
    this.status,
    this.bio,
    this.location,
    this.description,
    this.title,
    this.profilePicture,
    this.uid,
    this.username,
    this.totalMembers,
    this.requireJoiningApproval,
    this.seoDataWeighted,
    this.plainLastMessage,
    this.lastMessageAt,
  });

  Community copyWith({
    DateTime? createdAt,
    String? adminUserUid,
    String? status,
    String? bio,
    String? location,
    String? description,
    String? title,
    dynamic profilePicture,
    String? uid,
    String? username,
    int? totalMembers,
    bool? requireJoiningApproval,
    String? seoDataWeighted,
    dynamic plainLastMessage,
    dynamic lastMessageAt,
  }) =>
      Community(
        createdAt: createdAt ?? this.createdAt,
        adminUserUid: adminUserUid ?? this.adminUserUid,
        status: status ?? this.status,
        bio: bio ?? this.bio,
        location: location ?? this.location,
        description: description ?? this.description,
        title: title ?? this.title,
        profilePicture: profilePicture ?? this.profilePicture,
        uid: uid ?? this.uid,
        username: username ?? this.username,
        totalMembers: totalMembers ?? this.totalMembers,
        requireJoiningApproval:
            requireJoiningApproval ?? this.requireJoiningApproval,
        seoDataWeighted: seoDataWeighted ?? this.seoDataWeighted,
        plainLastMessage: plainLastMessage ?? this.plainLastMessage,
        lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      );

  factory Community.fromJson(String str) => Community.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Community.fromMap(Map<String, dynamic> json) => Community(
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        adminUserUid: json['admin_user_uid'],
        status: json['status'],
        bio: json['bio'],
        location: json['location'],
        description: json['description'],
        title: json['title'],
        profilePicture: json['profile_picture'],
        uid: json['uid'],
        username: json['username'],
        totalMembers: json['total_members'],
        requireJoiningApproval: json['require_joining_approval'],
        seoDataWeighted: json['seo_data_weighted'],
        plainLastMessage: json['plain_last_message'],
        lastMessageAt: json['last_message_at'],
      );

  Map<String, dynamic> toMap() => {
        'created_at': createdAt?.toIso8601String(),
        'admin_user_uid': adminUserUid,
        'status': status,
        'bio': bio,
        'location': location,
        'description': description,
        'title': title,
        'profile_picture': profilePicture,
        'uid': uid,
        'username': username,
        'total_members': totalMembers,
        'require_joining_approval': requireJoiningApproval,
        'seo_data_weighted': seoDataWeighted,
        'plain_last_message': plainLastMessage,
        'last_message_at': lastMessageAt,
      };
}
