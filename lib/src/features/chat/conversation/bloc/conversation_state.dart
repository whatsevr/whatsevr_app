part of 'conversation_bloc.dart';

enum MessageStatus {
  initial,
  loading,
  sending,
  sent,
  error,
}

class ConversationState extends Equatable {
  final bool isCommunity;
  final String? communityUid;
  final String? privateChatUid;
  final String? title;
  final String? profilePicture;
  final List<ChatMessage> messages;
  final Map<String, ChatMessage> lastMessages;
  final Map<String, int> unreadCounts;
  final List<WhatsevrUser> availableUsers;
  final MessageStatus messageStatus;

  final bool isLoadingMore;
  final bool hasReachedEnd;
  final Map<String, bool> messagesSendingStatus;
  final Map<String, List<WhatsevrUser>> typingUsers;

  const ConversationState({
    this.isCommunity = false,
    this.communityUid,
    this.privateChatUid,
    this.title,
    this.profilePicture,
    this.messages = const [],
    this.lastMessages = const {},
    this.unreadCounts = const {},
    this.availableUsers = const [],
    this.messageStatus = MessageStatus.initial,
    this.isLoadingMore = false,
    this.hasReachedEnd = false,
    this.messagesSendingStatus = const {},
    this.typingUsers = const {},
  });

  ConversationState copyWith({
    bool? isCommunity,
    String? communityUid,
    String? privateChatUid,
    String? title,
    String? profilePicture,
    List<ChatMessage>? messages,
    Map<String, ChatMessage>? lastMessages,
    Map<String, int>? unreadCounts,
    List<WhatsevrUser>? availableUsers,
    MessageStatus? messageStatus,
    bool? isLoadingMore,
    bool? hasReachedEnd,
    Map<String, bool>? messagesSendingStatus,
    Map<String, List<WhatsevrUser>>? typingUsers,
  }) {
    return ConversationState(
      isCommunity: isCommunity ?? this.isCommunity,
      communityUid: communityUid ?? this.communityUid,
      privateChatUid: privateChatUid ?? this.privateChatUid,
      title: title ?? this.title,
      profilePicture: profilePicture ?? this.profilePicture,
      messages: messages ?? this.messages,
      lastMessages: lastMessages ?? this.lastMessages,
      unreadCounts: unreadCounts ?? this.unreadCounts,
      availableUsers: availableUsers ?? this.availableUsers,
      messageStatus: messageStatus ?? this.messageStatus,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      messagesSendingStatus:
          messagesSendingStatus ?? this.messagesSendingStatus,
      typingUsers: typingUsers ?? this.typingUsers,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isCommunity': isCommunity,
      'communityUid': communityUid,
      'privateChatUid': privateChatUid,
      'title': title,
      'profilePicture': profilePicture,
      'messages': messages.map((e) => e.toJson()).toList(),
      'lastMessages': lastMessages.map((k, v) => MapEntry(k, v.toJson())),
      'unreadCounts': unreadCounts,
      'availableUsers': availableUsers.map((e) => e.toJson()).toList(),
      'messageStatus': messageStatus.index,
      'isLoadingMore': isLoadingMore,
      'hasReachedEnd': hasReachedEnd,
      'messagesSendingStatus': messagesSendingStatus,
      'typingUsers': typingUsers
          .map((k, v) => MapEntry(k, v.map((e) => e.toJson()).toList())),
    };
  }

  static ConversationState fromJson(Map<String, dynamic> json) {
    return ConversationState(
      isCommunity: json['isCommunity'] ?? false,
      communityUid: json['communityUid'],
      privateChatUid: json['privateChatUid'],
      title: json['title'],
      profilePicture: json['profilePicture'],
      messages: (json['messages'] as List)
          .map((e) => ChatMessage.fromJson(e))
          .toList(),
      lastMessages: (json['lastMessages'] as Map)
          .map((k, v) => MapEntry(k, ChatMessage.fromJson(v))),
      unreadCounts: Map<String, int>.from(json['unreadCounts']),
      availableUsers: (json['availableUsers'] as List)
          .map((e) => WhatsevrUser.fromJson(e))
          .toList(),
      messageStatus: MessageStatus.values[json['messageStatus']],
      isLoadingMore: json['isLoadingMore'],
      hasReachedEnd: json['hasReachedEnd'],
      messagesSendingStatus:
          Map<String, bool>.from(json['messagesSendingStatus']),
      typingUsers: (json['typingUsers'] as Map).map((k, v) => MapEntry(
          k, (v as List).map((e) => WhatsevrUser.fromJson(e)).toList())),
    );
  }

  @override
  List<Object?> get props => [
        isCommunity,
        communityUid,
        privateChatUid,
        title,
        profilePicture,
        messages,
        lastMessages,
        unreadCounts,
        availableUsers,
        messageStatus,
        isLoadingMore,
        hasReachedEnd,
        messagesSendingStatus,
        typingUsers,
      ];

  @override
  String toString() => '''ChatState {
  messages: ${messages.length} messages,
    messageStatus: $messageStatus,
 
    isLoadingMore: $isLoadingMore,
    hasReachedEnd: $hasReachedEnd
  }''';
}
