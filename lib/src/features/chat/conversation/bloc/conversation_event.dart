part of 'conversation_bloc.dart';

abstract class ConversationEvent extends Equatable {
  const ConversationEvent();

  @override
  List<Object?> get props => [];
}

class InitialEvent extends ConversationEvent {
  @override
  List<Object?> get props => [];
}



class LoadMessages extends ConversationEvent {
  final String chatId;
  final bool loadMore;

  const LoadMessages(this.chatId, {this.loadMore = false});

  @override
  List<Object?> get props => [chatId, loadMore];
}


// Message Actions
class SendMessage extends ConversationEvent {
  final String chatId;
  final String content;
  final String chatType; // Add this line

  const SendMessage({
    required this.chatId,
    required this.content,
    required this.chatType, // Add this line
  });

  @override
  List<Object?> get props => [chatId, content, chatType]; // Add chatType here
}

class DeleteMessage extends ConversationEvent {
  final String messageId;

  const DeleteMessage(this.messageId);

  @override
  List<Object?> get props => [messageId];
}

class EditMessage extends ConversationEvent {
  final String messageId;
  final String newContent;

  const EditMessage({
    required this.messageId,
    required this.newContent,
  });

  @override
  List<Object?> get props => [messageId, newContent];
}

// Typing Indicator
class SetTypingStatus extends ConversationEvent {
  final String chatId;
  final bool isTyping;

  const SetTypingStatus({
    required this.chatId,
    required this.isTyping,
  });

  @override
  List<Object?> get props => [chatId, isTyping];
}

// Update Events
class UpdateChats extends ConversationEvent {
  final List<PrivateChat> chats;

  const UpdateChats(this.chats);

  @override
  List<Object?> get props => [chats];
}

class UpdateMessages extends ConversationEvent {
  final List<ChatMessage> messages;
  final bool isLoadMore;

  const UpdateMessages(this.messages, [this.isLoadMore = false]);

  @override
  List<Object?> get props => [messages, isLoadMore];
}


