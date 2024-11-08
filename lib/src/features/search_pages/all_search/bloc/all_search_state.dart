part of 'all_search_bloc.dart';

class AllSearchState extends Equatable {
  final SearchedUsersResponse? searchedUsers;
  final SearchedPortfoliosResponse? searchedPortfolios;
  final SearchedCommunitiesResponse? searchedCommunities;
  final SearchedFlickPostsResponse? searchedFlickPosts;
  final SearchedMemoriesResponse? searchedMemories;
  final SearchedOffersResponse? searchedOffers;
  final SearchedPdfsResponse? searchedPdfs;
  final SearchedPhotoPostsResponse? searchedPhotoPosts;
  final SearchedVideoPostsResponse? searchedVideoPosts;
  final PaginationData usersPagination;
  final PaginationData portfoliosPagination;
  final PaginationData communitiesPagination;
  final PaginationData flickPostsPagination;
  final PaginationData memoriesPagination;
  final PaginationData offersPagination;
  final PaginationData pdfsPagination;
  final PaginationData photoPostsPagination;
  final PaginationData videoPostsPagination;
  final int selectedViewIndex;

  const AllSearchState({
    this.searchedUsers,
    this.searchedPortfolios,
    this.searchedCommunities,
    this.searchedFlickPosts,
    this.searchedMemories,
    this.searchedOffers,
    this.searchedPdfs,
    this.searchedPhotoPosts,
    this.searchedVideoPosts,
    this.usersPagination = const PaginationData(),
    this.portfoliosPagination = const PaginationData(),
    this.communitiesPagination = const PaginationData(),
    this.flickPostsPagination = const PaginationData(),
    this.memoriesPagination = const PaginationData(),
    this.offersPagination = const PaginationData(),
    this.pdfsPagination = const PaginationData(),
    this.photoPostsPagination = const PaginationData(),
    this.videoPostsPagination = const PaginationData(),
    this.selectedViewIndex = 0,
  });

  AllSearchState copyWith({
    SearchedUsersResponse? searchedUsers,
    SearchedPortfoliosResponse? searchedPortfolios,
    SearchedCommunitiesResponse? searchedCommunities,
    SearchedFlickPostsResponse? searchedFlickPosts,
    SearchedMemoriesResponse? searchedMemories,
    SearchedOffersResponse? searchedOffers,
    SearchedPdfsResponse? searchedPdfs,
    SearchedPhotoPostsResponse? searchedPhotoPosts,
    SearchedVideoPostsResponse? searchedVideoPosts,
    PaginationData? usersPagination,
    PaginationData? portfoliosPagination,
    PaginationData? communitiesPagination,
    PaginationData? flickPostsPagination,
    PaginationData? memoriesPagination,
    PaginationData? offersPagination,
    PaginationData? pdfsPagination,
    PaginationData? photoPostsPagination,
    PaginationData? videoPostsPagination,
    int? selectedViewIndex,
  }) {
    return AllSearchState(
      searchedUsers: searchedUsers ?? this.searchedUsers,
      searchedPortfolios: searchedPortfolios ?? this.searchedPortfolios,
      searchedCommunities: searchedCommunities ?? this.searchedCommunities,
      searchedFlickPosts: searchedFlickPosts ?? this.searchedFlickPosts,
      searchedMemories: searchedMemories ?? this.searchedMemories,
      searchedOffers: searchedOffers ?? this.searchedOffers,
      searchedPdfs: searchedPdfs ?? this.searchedPdfs,
      searchedPhotoPosts: searchedPhotoPosts ?? this.searchedPhotoPosts,
      searchedVideoPosts: searchedVideoPosts ?? this.searchedVideoPosts,
      usersPagination: usersPagination ?? this.usersPagination,
      portfoliosPagination: portfoliosPagination ?? this.portfoliosPagination,
      communitiesPagination:
          communitiesPagination ?? this.communitiesPagination,
      flickPostsPagination: flickPostsPagination ?? this.flickPostsPagination,
      memoriesPagination: memoriesPagination ?? this.memoriesPagination,
      offersPagination: offersPagination ?? this.offersPagination,
      pdfsPagination: pdfsPagination ?? this.pdfsPagination,
      photoPostsPagination: photoPostsPagination ?? this.photoPostsPagination,
      videoPostsPagination: videoPostsPagination ?? this.videoPostsPagination,
      selectedViewIndex: selectedViewIndex ?? this.selectedViewIndex,
    );
  }

  @override
  List<Object?> get props => [
        searchedUsers,
        searchedPortfolios,
        searchedCommunities,
        searchedFlickPosts,
        searchedMemories,
        searchedOffers,
        searchedPdfs,
        searchedPhotoPosts,
        searchedVideoPosts,
        usersPagination,
        portfoliosPagination,
        communitiesPagination,
        flickPostsPagination,
        memoriesPagination,
        offersPagination,
        pdfsPagination,
        photoPostsPagination,
        videoPostsPagination,
        selectedViewIndex,
      ];
}
