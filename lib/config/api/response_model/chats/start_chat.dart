import 'dart:convert';

class StartChatResponse {
  String? message;
  String? privateChatUid;
  String? communityUid;
  String? chatTitle;
  dynamic chatAvatarUrl;

  StartChatResponse({
    this.message,
    this.privateChatUid,
    this.communityUid,
    this.chatTitle,
    this.chatAvatarUrl,
  });

  StartChatResponse copyWith({
    String? message,
    String? privateChatUid,
    String? communityUid,
    String? chatTitle,
    dynamic chatAvatarUrl,
  }) =>
      StartChatResponse(
        message: message ?? this.message,
        privateChatUid: privateChatUid ?? this.privateChatUid,
        communityUid: communityUid ?? this.communityUid,
        chatTitle: chatTitle ?? this.chatTitle,
        chatAvatarUrl: chatAvatarUrl ?? this.chatAvatarUrl,
      );

  factory StartChatResponse.fromJson(String str) =>
      StartChatResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StartChatResponse.fromMap(Map<String, dynamic> json) =>
      StartChatResponse(
        message: json['message'],
        privateChatUid: json['private_chat_uid'],
        communityUid: json['community_uid'],
        chatTitle: json['chat_title'],
        chatAvatarUrl: json['chat_avatar_url'],
      );

  Map<String, dynamic> toMap() => {
        'message': message,
        'private_chat_uid': privateChatUid,
        'community_uid': communityUid,
        'chat_title': chatTitle,
        'chat_avatar_url': chatAvatarUrl,
      };
}
