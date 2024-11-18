import 'dart:convert';

class ChatMessage {
  final String? uid;

  final String? senderUid;
  final String? message;
  final DateTime? createdAt;

  final bool? isDeleted;
  final bool? isPinned;

  final dynamic replyToMessageUid;

  final String? communityUid;
  final String? privateChatUid;
 



  ChatMessage({
    this.uid,
  
    this.senderUid,
    this.message,
    this.createdAt,
 
    this.isDeleted,
    this.isPinned,
  
    this.replyToMessageUid,
  
    this.communityUid,
    this.privateChatUid,

  });

  ChatMessage copyWith({
    String? uid,

    String? senderUid,
    String? message,
    DateTime? createdAt,
  
    bool? isDeleted,
    bool? isPinned,
   
    dynamic replyToMessageUid,
    dynamic deletedAt,
    String? communityUid,
    String? privateChatUid,

  }) =>
      ChatMessage(
        uid: uid ?? this.uid,
      
        senderUid: senderUid ?? this.senderUid,
        message: message ?? this.message,
        createdAt: createdAt ?? this.createdAt,
      
        isDeleted: isDeleted ?? this.isDeleted,
        isPinned: isPinned ?? this.isPinned,
 
        replyToMessageUid: replyToMessageUid ?? this.replyToMessageUid,
   
        communityUid: communityUid ?? this.communityUid,
        privateChatUid: privateChatUid ?? this.privateChatUid,
      
        
     
      );

  factory ChatMessage.fromJson(String str) =>
      ChatMessage.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChatMessage.fromMap(Map<String, dynamic> json) => ChatMessage(
        uid: json['uid'],
    
        senderUid: json['sender_uid'],
        message: json['message'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
      
        isDeleted: json['is_deleted'],
        isPinned: json['is_pinned'],
      
        replyToMessageUid: json['reply_to_message_uid'],
      
        communityUid: json['community_uid'],
        privateChatUid: json['private_chat_uid'],
      
    );

  Map<String, dynamic> toMap() => {
        'uid': uid,
     
        'sender_uid': senderUid,
        'message': message,
        'created_at': createdAt?.toIso8601String(),
       
        'is_deleted': isDeleted,
        'is_pinned': isPinned,
   
        'reply_to_message_uid': replyToMessageUid,
     
        'community_uid': communityUid,
        'private_chat_uid': privateChatUid,
      
        
      };
}
