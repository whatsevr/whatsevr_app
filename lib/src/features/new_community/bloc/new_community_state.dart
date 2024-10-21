part of 'new_community_bloc.dart';

class NewCommunityState extends Equatable {
  final List<TopCommunity>? topCommunities;
  final PaginationData? topCommunitiesPaginationData;
  const NewCommunityState(
      {this.topCommunities = const [], this.topCommunitiesPaginationData});

  @override
  List<Object?> get props => [topCommunities, topCommunitiesPaginationData];

  NewCommunityState copyWith({
    List<TopCommunity>? topCommunities,
    PaginationData? topCommunitiesPaginationData,
  }) {
    return NewCommunityState(
      topCommunities: topCommunities ?? this.topCommunities,
    );
  }
}
