part of 'conversation_bloc.dart';

abstract class ConversationEvent extends Equatable {
  const ConversationEvent();

  @override
  List<Object?> get props => [];
}

class InitialEvent extends ConversationEvent {
  final ConversationPageArguments? pageArguments;

  const InitialEvent({required this.pageArguments});
  @override
  List<Object?> get props => [];
}

class LoadMoreMessages extends ConversationEvent {

  @override
  List<Object?> get props => [];
}

// Message Actions
class SendMessage extends ConversationEvent {
 
  final String content;
  final String? replyToMessageUid;
 // Add this line

  const SendMessage({ 
     this.replyToMessageUid,
    required this.content,
    // Add this line
  });

  @override
  List<Object?> get props => [replyToMessageUid, content, ]; // Add chatType here
}

class DeleteMessage extends ConversationEvent {
  final String messageUid;

  const DeleteMessage(this.messageUid);

  @override
  List<Object?> get props => [messageUid];
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

// Remove UpdateChats and UpdateMessages events




