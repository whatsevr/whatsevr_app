part of 'follow_unfollow_bloc.dart';

abstract class FollowUnfollowEvent extends Equatable {
  const FollowUnfollowEvent();

  @override
  List<Object?> get props => [];
}

class FetchFollowedUsers extends FollowUnfollowEvent {}

class ReloadFollowedUsers extends FollowUnfollowEvent {}

class ToggleFollow extends FollowUnfollowEvent {
  final String userUid;

  const ToggleFollow({required this.userUid});

  @override
  List<Object?> get props => [userUid];
}
