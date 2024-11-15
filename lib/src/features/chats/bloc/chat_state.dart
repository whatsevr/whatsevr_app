part of 'chat_bloc.dart';

enum ChatStatus {
  initial,
  loading,
  loaded,
  error,
}

enum MessageStatus {
  initial,
  loading,
  sending,
  sent,
  error,
}

class ChatState extends Equatable {
  final ChatStatus status;
  final List<PrivateChat> chats;
  final PrivateChat? selectedChat;
  final List<ChatMessage> messages;
  final Map<String, ChatMessage> lastMessages;
  final Map<String, int> unreadCounts;
  final List<WhatsevrUser> availableUsers;
  final MessageStatus messageStatus;
  final String? error;
  final bool isLoadingMore;
  final bool hasReachedEnd;
  final Map<String, bool> messagesSendingStatus;
  final Map<String, List<WhatsevrUser>> typingUsers;

  const ChatState({
    this.status = ChatStatus.initial,
    this.chats = const [],
    this.selectedChat,
    this.messages = const [],
    this.lastMessages = const {},
    this.unreadCounts = const {},
    this.availableUsers = const [],
    this.messageStatus = MessageStatus.initial,
    this.error,
    this.isLoadingMore = false,
    this.hasReachedEnd = false,
    this.messagesSendingStatus = const {},
    this.typingUsers = const {},
  });

  ChatState copyWith({
    ChatStatus? status,
    List<PrivateChat>? chats,
    PrivateChat? selectedChat,
    List<ChatMessage>? messages,
    Map<String, ChatMessage>? lastMessages,
    Map<String, int>? unreadCounts,
    List<WhatsevrUser>? availableUsers,
    MessageStatus? messageStatus,
    String? error,
    bool? isLoadingMore,
    bool? hasReachedEnd,
    Map<String, bool>? messagesSendingStatus,
    Map<String, List<WhatsevrUser>>? typingUsers,
  }) {
    return ChatState(
      status: status ?? this.status,
      chats: chats ?? this.chats,
      selectedChat: selectedChat ?? this.selectedChat,
      messages: messages ?? this.messages,
      lastMessages: lastMessages ?? this.lastMessages,
      unreadCounts: unreadCounts ?? this.unreadCounts,
      availableUsers: availableUsers ?? this.availableUsers,
      messageStatus: messageStatus ?? this.messageStatus,
      error: error,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      messagesSendingStatus:
          messagesSendingStatus ?? this.messagesSendingStatus,
      typingUsers: typingUsers ?? this.typingUsers,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status.index,
      'chats': chats.map((e) => e.toJson()).toList(),
      'selectedChat': selectedChat?.toJson(),
      'messages': messages.map((e) => e.toJson()).toList(),
      'lastMessages': lastMessages.map((k, v) => MapEntry(k, v.toJson())),
      'unreadCounts': unreadCounts,
      'availableUsers': availableUsers.map((e) => e.toJson()).toList(),
      'messageStatus': messageStatus.index,
      'error': error,
      'isLoadingMore': isLoadingMore,
      'hasReachedEnd': hasReachedEnd,
      'messagesSendingStatus': messagesSendingStatus,
      'typingUsers': typingUsers
          .map((k, v) => MapEntry(k, v.map((e) => e.toJson()).toList())),
    };
  }

  static ChatState fromJson(Map<String, dynamic> json) {
    return ChatState(
      status: ChatStatus.values[json['status']],
      chats:
          (json['chats'] as List).map((e) => PrivateChat.fromJson(e)).toList(),
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
      error: json['error'],
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
        status,
        chats,
        selectedChat,
        messages,
        lastMessages,
        unreadCounts,
        availableUsers,
        messageStatus,
        error,
        isLoadingMore,
        hasReachedEnd,
        messagesSendingStatus,
        typingUsers,
      ];

  @override
  String toString() => '''ChatState {
    status: $status,
    chats: ${chats.length} chats,
    selectedChat: ${selectedChat?.uid},
    messages: ${messages.length} messages,
    messageStatus: $messageStatus,
    error: $error,
    isLoadingMore: $isLoadingMore,
    hasReachedEnd: $hasReachedEnd
  }''';
}
