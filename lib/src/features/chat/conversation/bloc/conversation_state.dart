part of 'conversation_bloc.dart';

class ConversationState extends Equatable {
  final bool isCommunity;
  final String? communityUid;
  final String? privateChatUid;
  final String? title;
  final String? profilePicture;
  final List<ChatMessage> messages;
  final Map<String, ChatMessage> lastMessages;
  final Map<String, int> unreadCounts;
  final List<WhatsevrUser> chatMembers;

  final PaginationData messagesPaginationData;

  const ConversationState({
    this.isCommunity = false,
    this.communityUid,
    this.privateChatUid,
    this.title,
    this.profilePicture,
    this.messages = const [],
    this.lastMessages = const {},
    this.unreadCounts = const {},
    this.chatMembers = const [],
    this.messagesPaginationData = const PaginationData(),
  });

  String get chatId => isCommunity ? communityUid! : privateChatUid!;

  ConversationState copyWith({
    bool? isCommunity,
    String? communityUid,
    String? privateChatUid,
    String? title,
    String? profilePicture,
    List<ChatMessage>? messages,
    Map<String, ChatMessage>? lastMessages,
    Map<String, int>? unreadCounts,
    List<WhatsevrUser>? chatMembers,
    PaginationData? messagesPaginationData,
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
      chatMembers: chatMembers ?? this.chatMembers,
      messagesPaginationData: messagesPaginationData ?? this.messagesPaginationData,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      chatId: {
        'isCommunity': isCommunity,
        'communityUid': communityUid,
        'privateChatUid': privateChatUid,
        'title': title,
        'profilePicture': profilePicture,
        'messages': messages.map((e) => e.toJson()).toList(),
        'lastMessages': lastMessages.map((k, v) => MapEntry(k, v.toJson())),
        'unreadCounts': unreadCounts,
        'availableUsers': chatMembers.map((e) => e.toJson()).toList(),
        'messagesPaginationData': messagesPaginationData,
      }
    };
  }

  static ConversationState fromJson(Map<String, dynamic> json, String chatId) {
    final chatData = json[chatId] as Map<String, dynamic>?;
    if (chatData == null) return ConversationState();

    return ConversationState(
      isCommunity: chatData['isCommunity'] ?? false,
      communityUid: chatData['communityUid'],
      privateChatUid: chatData['privateChatUid'],
      title: chatData['title'],
      profilePicture: chatData['profilePicture'],
      messages: (chatData['messages'] as List?)
              ?.map((e) => ChatMessage.fromJson(e))
              .toList() ??
          [],
      lastMessages: (chatData['lastMessages'] as Map?)
              ?.map((k, v) => MapEntry(k, ChatMessage.fromJson(v))) ??
          {},
      unreadCounts: Map<String, int>.from(chatData['unreadCounts'] ?? {}),
      chatMembers: (chatData['availableUsers'] as List?)
              ?.map((e) => WhatsevrUser.fromJson(e))
              .toList() ??
          [],
      messagesPaginationData:
          chatData['messagesPaginationData'] ?? const PaginationData(),
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
        chatMembers,
      ];

  @override
  String toString() => '''ChatState {
  messages: ${messages.length} messages,
  }''';
}
