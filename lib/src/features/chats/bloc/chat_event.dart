part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class InitialEvent extends ChatEvent {
  @override
  List<Object?> get props => [];
}

// Load Events
class LoadChats extends ChatEvent {}

class LoadMessages extends ChatEvent {
  final String chatId;
  final bool loadMore;

  const LoadMessages(this.chatId, {this.loadMore = false});

  @override
  List<Object?> get props => [chatId, loadMore];
}

class LoadAvailableUsers extends ChatEvent {}

// Chat Actions
class CreateDirectChat extends ChatEvent {
  final String otherUserId;

  const CreateDirectChat(this.otherUserId);

  @override
  List<Object?> get props => [otherUserId];
}

class CreateGroupChat extends ChatEvent {
  final String name;
  final List<String> participantIds;

  const CreateGroupChat({
    required this.name,
    required this.participantIds,
  });

  @override
  List<Object?> get props => [name, participantIds];
}

class SelectChat extends ChatEvent {
  final PrivateChat chat;

  const SelectChat(this.chat);

  @override
  List<Object?> get props => [chat];
}

// Message Actions
class SendMessage extends ChatEvent {
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

class DeleteMessage extends ChatEvent {
  final String messageId;

  const DeleteMessage(this.messageId);

  @override
  List<Object?> get props => [messageId];
}

class EditMessage extends ChatEvent {
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
class SetTypingStatus extends ChatEvent {
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
class UpdateChats extends ChatEvent {
  final List<PrivateChat> chats;

  const UpdateChats(this.chats);

  @override
  List<Object?> get props => [chats];
}

class UpdateMessages extends ChatEvent {
  final List<ChatMessage> messages;
  final bool isLoadMore;

  const UpdateMessages(this.messages, [this.isLoadMore = false]);

  @override
  List<Object?> get props => [messages, isLoadMore];
}

class UpdateTypingUsers extends ChatEvent {
  final String chatId;
  final List<WhatsevrUser> users;

  const UpdateTypingUsers({
    required this.chatId,
    required this.users,
  });

  @override
  List<Object?> get props => [chatId, users];
}
