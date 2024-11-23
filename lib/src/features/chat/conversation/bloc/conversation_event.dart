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

class LoadMessages extends ConversationEvent {
  const LoadMessages();

  @override
  List<Object?> get props => [];
}

class MessageChangesEvent extends ConversationEvent {
  @override
  List<Object?> get props => [];
}
class LoadLatestMessages extends ConversationEvent {
  
  const LoadLatestMessages();

  @override
  List<Object?> get props => [];
}
class SendMessage extends ConversationEvent {
  final String content;
  final String? replyToMessageUid;

  const SendMessage({
    this.replyToMessageUid,
    required this.content,
  });

  @override
  List<Object?> get props => [
        replyToMessageUid,
        content,
      ]; // Add chatType here
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
