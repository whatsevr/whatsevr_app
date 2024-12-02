part of 'join_leave_community_bloc.dart';

class JoinLeaveCommunityState extends Equatable {
  final Set<String> userJoinedCommunityUids;
  final Set<String> userOwnedCommunityUids;
  final bool isLoading;
  final String? error;

  const JoinLeaveCommunityState({
    this.userJoinedCommunityUids = const {},
    this.userOwnedCommunityUids = const {},
    this.isLoading = false,
    this.error,
  });

  JoinLeaveCommunityState copyWith({
    Set<String>? userJoinedCommunityUids,
    Set<String>? userOwnedCommunityUids,
    bool? isLoading,
    String? error,
  }) {
    return JoinLeaveCommunityState(
      userJoinedCommunityUids:
          userJoinedCommunityUids ?? this.userJoinedCommunityUids,
      userOwnedCommunityUids:
          userOwnedCommunityUids ?? this.userOwnedCommunityUids,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props =>
      [userJoinedCommunityUids, userOwnedCommunityUids, isLoading, error];
}
