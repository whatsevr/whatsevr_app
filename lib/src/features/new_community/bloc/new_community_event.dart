part of 'new_community_bloc.dart';

sealed class NewCommunityEvent extends Equatable {
  const NewCommunityEvent();
}

class NewCommunityInitialEvent extends NewCommunityEvent {
  final NewCommunityPageArgument pageArgument;
  const NewCommunityInitialEvent({required this.pageArgument});

  @override
  List<Object?> get props => [pageArgument];
}

class LoadTopCommunitiesEvent extends NewCommunityEvent {
  const LoadTopCommunitiesEvent();

  @override
  List<Object> get props => [];
}

class LoadMoreTopCommunitiesEvent extends NewCommunityEvent {
  final int? page;
  const LoadMoreTopCommunitiesEvent({required this.page});
  @override
  List<Object?> get props => [page];
}

class ChangeApproveJoiningRequestEvent extends NewCommunityEvent {
  const ChangeApproveJoiningRequestEvent();

  @override
  List<Object?> get props => [];
}

class CreateCommunityEvent extends NewCommunityEvent {
  final Function onCompleted;
  const CreateCommunityEvent({required this.onCompleted});

  @override
  List<Object?> get props => [onCompleted];
}
