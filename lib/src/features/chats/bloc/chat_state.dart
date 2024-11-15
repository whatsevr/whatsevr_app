part of 'chat_bloc.dart';

enum MessageStatus {
  initial,
  loading,
  sending,
  sent,
  error,
}

class ChatState extends Equatable {
  final List<PrivateChat> privateChats;
  final PrivateChat? selectedChat;
  final List<ChatMessage> messages;
  final Map<String, ChatMessage> lastMessages;
  final Map<String, int> unreadCounts;
  final List<WhatsevrUser> availableUsers;
  final MessageStatus messageStatus;

  final bool isLoadingMore;
  final bool hasReachedEnd;
  final Map<String, bool> messagesSendingStatus;
  final Map<String, List<WhatsevrUser>> typingUsers;

  const ChatState({
    this.privateChats = const [],
    this.selectedChat,
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

  ChatState copyWith({
    List<PrivateChat>? privateChats,
    PrivateChat? selectedChat,
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
    return ChatState(
      privateChats: privateChats ?? this.privateChats,
      selectedChat: selectedChat ?? this.selectedChat,
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
      'privateChats': privateChats.map((e) => e.toJson()).toList(),
      'selectedChat': selectedChat?.toJson(),
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

  static ChatState fromJson(Map<String, dynamic> json) {
    return ChatState(
      privateChats: (json['privateChats'] as List)
          .map((e) => PrivateChat.fromJson(e))
          .toList(),
      selectedChat: json['selectedChat'] != null
          ? PrivateChat.fromJson(json['selectedChat'])
          : null,
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
        privateChats,
        selectedChat,
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
  
    privateChats: ${privateChats.length} chats,
    selectedChat: ${selectedChat?.uid},
    messages: ${messages.length} messages,
    messageStatus: $messageStatus,
 
    isLoadingMore: $isLoadingMore,
    hasReachedEnd: $hasReachedEnd
  }''';
}
