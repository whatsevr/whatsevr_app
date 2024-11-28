part of 'follow_unfollow_bloc.dart';

class FollowUnfollowState extends Equatable {
  final Set<String> followedUserIds;
  final bool isLoading;
  final String? error;

  const FollowUnfollowState({
    required this.followedUserIds,
    this.isLoading = false,
    this.error,
  });

  FollowUnfollowState copyWith({
    Set<String>? followedUserIds,
    bool? isLoading,
    String? error,
  }) {
    return FollowUnfollowState(
      followedUserIds: followedUserIds ?? this.followedUserIds,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [followedUserIds, isLoading, error];
}
