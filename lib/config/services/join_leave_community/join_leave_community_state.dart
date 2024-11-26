part of 'join_leave_community_bloc.dart';

class JoinLeaveCommunityState extends Equatable {
  final Set<String> userCommunities;
  final bool isLoading;
  final String? error;

  const JoinLeaveCommunityState({
    required this.userCommunities,
    this.isLoading = false,
    this.error,
  });

  JoinLeaveCommunityState copyWith({
    Set<String>? userCommunities,
    bool? isLoading,
    String? error,
  }) {
    return JoinLeaveCommunityState(
      userCommunities: userCommunities ?? this.userCommunities,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [userCommunities, isLoading, error];
}
