part of 'bloc.dart';

sealed class CommunityEvent extends Equatable {
  const CommunityEvent();
}

class InitialEvent extends CommunityEvent {
  final CommunityPageArgument? accountPageArgument;

  const InitialEvent({required this.accountPageArgument});

  @override
  List<Object> get props => <Object>[];
}

class LoadCommunityData extends CommunityEvent {
  const LoadCommunityData();

  @override
  List<Object> get props => <Object>[];
}
