import 'package:flutter/foundation.dart';

class Community {
  final DateTime? createdAt;
  final String? adminUserUid;
  final String? status;
  final String? bio;
  final String? location;
  final String? description;
  final String? title;
  final String? profilePicture;
  final String? uid;
  final String? username;
  final int? totalMembers;
  final bool? requireJoiningApproval;
  final String? plainLastMessage;
  final DateTime? lastMessageAt;

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
    this.plainLastMessage,
    this.lastMessageAt,
  });

  factory Community.fromMap(Map<String, dynamic>? map) {
    if (map == null) return Community();
    
    return Community(
      createdAt: map['created_at'] != null 
          ? DateTime.parse(map['created_at'].toString())
          : null,
      adminUserUid: map['admin_user_uid'],
      status: map['status'],
      bio: map['bio'],
      location: map['location'],
      description: map['description'],
      title: map['title'],
      profilePicture: map['profile_picture'],
      uid: map['uid'],
      username: map['username'],
      totalMembers: map['total_members']?.toInt(),
      requireJoiningApproval: map['require_joining_approval'],
      plainLastMessage: map['plain_last_message'],
      lastMessageAt: map['last_message_at'] != null 
          ? DateTime.parse(map['last_message_at'].toString())
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (createdAt != null) 'created_at': createdAt?.toIso8601String(),
      if (adminUserUid != null) 'admin_user_uid': adminUserUid,
      if (status != null) 'status': status,
      if (bio != null) 'bio': bio,
      if (location != null) 'location': location,
      if (description != null) 'description': description,
      if (title != null) 'title': title,
      if (profilePicture != null) 'profile_picture': profilePicture,
      if (uid != null) 'uid': uid,
      if (username != null) 'username': username,
      if (totalMembers != null) 'total_members': totalMembers,
      if (requireJoiningApproval != null) 'require_joining_approval': requireJoiningApproval,
      if (plainLastMessage != null) 'plain_last_message': plainLastMessage,
      if (lastMessageAt != null) 'last_message_at': lastMessageAt?.toIso8601String(),
    };
  }

  Community copyWith({
    DateTime? createdAt,
    String? adminUserUid,
    String? status,
    String? bio,
    String? location,
    String? description,
    String? title,
    String? profilePicture,
    String? uid,
    String? username,
    int? totalMembers,
    bool? requireJoiningApproval,
    String? plainLastMessage,
    DateTime? lastMessageAt,
  }) {
    return Community(
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
      requireJoiningApproval: requireJoiningApproval ?? this.requireJoiningApproval,
      plainLastMessage: plainLastMessage ?? this.plainLastMessage,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
    );
  }

  @override
  String toString() {
    return 'Community(createdAt: $createdAt, adminUserUid: $adminUserUid, status: $status, '
           'bio: $bio, location: $location, description: $description, title: $title, '
           'profilePicture: $profilePicture, uid: $uid, username: $username, '
           'totalMembers: $totalMembers, requireJoiningApproval: $requireJoiningApproval, '
           'plainLastMessage: $plainLastMessage, lastMessageAt: $lastMessageAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Community &&
        other.createdAt == createdAt &&
        other.adminUserUid == adminUserUid &&
        other.status == status &&
        other.bio == bio &&
        other.location == location &&
        other.description == description &&
        other.title == title &&
        other.profilePicture == profilePicture &&
        other.uid == uid &&
        other.username == username &&
        other.totalMembers == totalMembers &&
        other.requireJoiningApproval == requireJoiningApproval &&
        other.plainLastMessage == plainLastMessage &&
        other.lastMessageAt == lastMessageAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      createdAt,
      adminUserUid,
      status,
      bio,
      location,
      description,
      title,
      profilePicture,
      uid,
      username,
      totalMembers,
      requireJoiningApproval,
      plainLastMessage,
      lastMessageAt,
    );
  }
}