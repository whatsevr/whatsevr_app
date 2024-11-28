part of 'join_leave_community_bloc.dart';

abstract class JoinLeaveCommunityEvent extends Equatable {
  const JoinLeaveCommunityEvent();

  @override
  List<Object?> get props => [];
}

class FetchUserCommunities extends JoinLeaveCommunityEvent {}

class ReloadUserCommunities extends JoinLeaveCommunityEvent {}

class JoinOrLeave extends JoinLeaveCommunityEvent {
  final String userUid;

  const JoinOrLeave({required this.userUid});

  @override
  List<Object?> get props => [userUid];
}
