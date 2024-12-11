part of 'chat_bloc.dart';

class ChatState extends Equatable {
  final List<Chat> privateChats;
  final List<Community> communities;

  const ChatState({
    this.privateChats = const [],
    this.communities = const [],
  });

  ChatState copyWith({
    List<Chat>? privateChats,
    List<Community>? communities,
  }) {
    return ChatState(
      privateChats: privateChats ?? this.privateChats,
      communities: communities ?? this.communities,
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
