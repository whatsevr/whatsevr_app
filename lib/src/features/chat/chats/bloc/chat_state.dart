part of 'chat_bloc.dart';



class ChatState extends Equatable {
  final List<PrivateChat> privateChats;





  const ChatState({
    this.privateChats = const [],



  });

  ChatState copyWith({
    List<PrivateChat>? privateChats,
    PrivateChat? selectedChat,
    List<ChatMessage>? messages,
    Map<String, ChatMessage>? lastMessages,
    Map<String, int>? unreadCounts,
    List<WhatsevrUser>? availableUsers,
 
    bool? isLoadingMore,
    bool? hasReachedEnd,
    Map<String, bool>? messagesSendingStatus,
    Map<String, List<WhatsevrUser>>? typingUsers,
  }) {
    return ChatState(
      privateChats: privateChats ?? this.privateChats,
    
 );
  }

  Map<String, dynamic> toJson() {
    return {
      'privateChats': privateChats.map((e) => e.toJson()).toList(),

    };
  }

  static ChatState fromJson(Map<String, dynamic> json) {
    return ChatState(
      privateChats: (json['privateChats'] as List)
          .map((e) => PrivateChat.fromJson(e))
          .toList(),
  
    );
  }

  @override
  List<Object?> get props => [
        privateChats,
    
      ];

  @override
  String toString() => '''ChatState {
    privateChats: ${privateChats.length} chats,
  }''';
}
