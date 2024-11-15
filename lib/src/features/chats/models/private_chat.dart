import 'dart:convert';

class PrivateChat {
  final String? uid;
  final String? user1Uid;
  final String? user2Uid;
  final DateTime? createdAt;
  final DateTime? lastMessageAt;
  final bool? user1IsMuted;
  final bool? user2IsMuted;
  final bool? user1IsBlocked;
  final bool? user2IsBlocked;

  PrivateChat({
    this.uid,
    this.user1Uid,
    this.user2Uid,
    this.createdAt,
    this.lastMessageAt,
    this.user1IsMuted,
    this.user2IsMuted,
    this.user1IsBlocked,
    this.user2IsBlocked,
  });

  PrivateChat copyWith({
    String? uid,
    String? user1Uid,
    String? user2Uid,
    DateTime? createdAt,
    DateTime? lastMessageAt,
    bool? user1IsMuted,
    bool? user2IsMuted,
    bool? user1IsBlocked,
    bool? user2IsBlocked,
  }) =>
      PrivateChat(
        uid: uid ?? this.uid,
        user1Uid: user1Uid ?? this.user1Uid,
        user2Uid: user2Uid ?? this.user2Uid,
        createdAt: createdAt ?? this.createdAt,
        lastMessageAt: lastMessageAt ?? this.lastMessageAt,
        user1IsMuted: user1IsMuted ?? this.user1IsMuted,
        user2IsMuted: user2IsMuted ?? this.user2IsMuted,
        user1IsBlocked: user1IsBlocked ?? this.user1IsBlocked,
        user2IsBlocked: user2IsBlocked ?? this.user2IsBlocked,
      );

  factory PrivateChat.fromJson(String str) =>
      PrivateChat.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PrivateChat.fromMap(Map<String, dynamic> json) => PrivateChat(
        uid: json["uid"],
        user1Uid: json["user1_uid"],
        user2Uid: json["user2_uid"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        lastMessageAt: json["last_message_at"] == null
            ? null
            : DateTime.parse(json["last_message_at"]),
        user1IsMuted: json["user1_is_muted"],
        user2IsMuted: json["user2_is_muted"],
        user1IsBlocked: json["user1_is_blocked"],
        user2IsBlocked: json["user2_is_blocked"],
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
      };
}
