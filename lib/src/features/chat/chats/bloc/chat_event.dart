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
class LoadPrivateChats extends ChatEvent {}
class LoadCommunities extends ChatEvent {}


