part of 'new_community_bloc.dart';

class NewCommunityState extends Equatable {
  final List<TopCommunity>? topCommunities;
  final PaginationData? topCommunitiesPaginationData;
  final bool? approveJoiningRequest;
  const NewCommunityState({
    this.topCommunities = const [],
    this.topCommunitiesPaginationData,
    this.approveJoiningRequest = false,
  });

  @override
  List<Object?> get props => [
        topCommunities,
        topCommunitiesPaginationData,
        approveJoiningRequest,
      ];

  NewCommunityState copyWith({
    List<TopCommunity>? topCommunities,
    PaginationData? topCommunitiesPaginationData,
    bool? approveJoiningRequest,
  }) {
    return NewCommunityState(
      topCommunities: topCommunities ?? this.topCommunities,
      topCommunitiesPaginationData:
          topCommunitiesPaginationData ?? this.topCommunitiesPaginationData,
      approveJoiningRequest:
          approveJoiningRequest ?? this.approveJoiningRequest,
    );
  }
}
