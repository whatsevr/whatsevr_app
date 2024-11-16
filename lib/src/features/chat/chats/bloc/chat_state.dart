part of 'chat_bloc.dart';

class ChatState extends Equatable {
  final List<PrivateChat> privateChats;
  final List<Community> communities;

  const ChatState({
    this.privateChats = const [],
    this.communities = const [],
  });

  ChatState copyWith({
    List<PrivateChat>? privateChats,
    List<Community>? communities,
  }) {
    return ChatState(
      privateChats: privateChats ?? this.privateChats,
      communities: communities ?? this.communities,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'privateChats': privateChats.map((e) => e.toJson()).toList(),
      'communities': communities.map((e) => e.toMap()).toList(),
    };
  }

  static ChatState fromJson(Map<String, dynamic> json) {
    return ChatState(
      privateChats: (json['privateChats'] as List)
          .map((e) => PrivateChat.fromJson(e))
          .toList(),
      communities: (json['communities'] as List)
          .map((e) => Community.fromMap(e))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [
        privateChats,
        communities,
      ];

  @override
  String toString() => '''ChatState {
    privateChats: ${privateChats.length} chats,
    communities: ${communities.length} communities,
  }''';
}
