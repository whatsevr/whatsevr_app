part of 'conversation_bloc.dart';

class ConversationState extends Equatable {
  final bool isCommunity;
  final String? communityUid;
  final String? privateChatUid;
  final String? title;
  final String? profilePicture;
  final List<Message> messages;
  final Map<String, Message> lastMessages;
  final Map<String, int> unreadCounts;

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
    this.messagesPaginationData = const PaginationData(),
  });

  String get chatId => isCommunity ? communityUid! : privateChatUid!;

  ConversationState copyWith({
    bool? isCommunity,
    String? communityUid,
    String? privateChatUid,
    String? title,
    String? profilePicture,
    List<Message>? messages,
    Map<String, Message>? lastMessages,
    Map<String, int>? unreadCounts,
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
      messagesPaginationData:
          messagesPaginationData ?? this.messagesPaginationData,
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
        'messagesPaginationData': messagesPaginationData,
    
    };
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
      ];

  @override
  String toString() => '''ChatState {
  messages: ${messages.length} messages,
  }''';
}
