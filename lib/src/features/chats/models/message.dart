import 'dart:convert';

class ChatMessage {
  final String? uid;
  final String? chatType;
  final String? senderUid;
  final String? message;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? isDeleted;
  final bool? isPinned;
  final bool? isEdited;
  final dynamic replyToMessageUid;
  final dynamic deletedAt;
  final String? communityUid;
  final String? privateChatUid;

  ChatMessage({
    this.uid,
    this.chatType,
    this.senderUid,
    this.message,
    this.createdAt,
    this.updatedAt,
    this.isDeleted,
    this.isPinned,
    this.isEdited,
    this.replyToMessageUid,
    this.deletedAt,
    this.communityUid,
    this.privateChatUid,
  });

  ChatMessage copyWith({
    String? uid,
    String? chatType,
    String? senderUid,
    String? message,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isDeleted,
    bool? isPinned,
    bool? isEdited,
    dynamic replyToMessageUid,
    dynamic deletedAt,
    String? communityUid,
    String? privateChatUid,
  }) =>
      ChatMessage(
        uid: uid ?? this.uid,
        chatType: chatType ?? this.chatType,
        senderUid: senderUid ?? this.senderUid,
        message: message ?? this.message,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isDeleted: isDeleted ?? this.isDeleted,
        isPinned: isPinned ?? this.isPinned,
        isEdited: isEdited ?? this.isEdited,
        replyToMessageUid: replyToMessageUid ?? this.replyToMessageUid,
        deletedAt: deletedAt ?? this.deletedAt,
        communityUid: communityUid ?? this.communityUid,
        privateChatUid: privateChatUid ?? this.privateChatUid,
      );

  factory ChatMessage.fromJson(String str) =>
      ChatMessage.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChatMessage.fromMap(Map<String, dynamic> json) => ChatMessage(
        uid: json["uid"],
        chatType: json["chat_type"],
        senderUid: json["sender_uid"],
        message: json["message"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        isDeleted: json["is_deleted"],
        isPinned: json["is_pinned"],
        isEdited: json["is_edited"],
        replyToMessageUid: json["reply_to_message_uid"],
        deletedAt: json["deleted_at"],
        communityUid: json["community_uid"],
        privateChatUid: json["private_chat_uid"],
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "chat_type": chatType,
        "sender_uid": senderUid,
        "message": message,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "is_deleted": isDeleted,
        "is_pinned": isPinned,
        "is_edited": isEdited,
        "reply_to_message_uid": replyToMessageUid,
        "deleted_at": deletedAt,
        "community_uid": communityUid,
        "private_chat_uid": privateChatUid,
      };
}
