part of 'bloc.dart';

sealed class CommunityEvent extends Equatable {
  const CommunityEvent();
}

class InitialEvent extends CommunityEvent {
  final CommunityPageArgument? communityPageArgument;

  const InitialEvent({required this.communityPageArgument});

  @override
  List<Object> get props => <Object>[];
}

class LoadCommunityData extends CommunityEvent {
  const LoadCommunityData();

  @override
  List<Object> get props => <Object>[];
}
