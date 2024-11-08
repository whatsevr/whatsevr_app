part of 'all_search_bloc.dart';

class AllSearchState extends Equatable {
  final SearchedFlickPostsResponse? searchedFlickPosts;
  final SearchedMemoriesResponse? searchedMemories;
  final SearchedOffersResponse? searchedOffers;
  final SearchedPdfsResponse? searchedPdfs;
  final SearchedPhotoPostsResponse? searchedPhotoPosts;
  final SearchedVideoPostsResponse? searchedVideoPosts;
  final PaginationData flickPostsPagination;
  final PaginationData memoriesPagination;
  final PaginationData offersPagination;
  final PaginationData pdfsPagination;
  final PaginationData photoPostsPagination;
  final PaginationData videoPostsPagination;
  final int selectedViewIndex;

  const AllSearchState({
    this.searchedFlickPosts,
    this.searchedMemories,
    this.searchedOffers,
    this.searchedPdfs,
    this.searchedPhotoPosts,
    this.searchedVideoPosts,
    this.flickPostsPagination = const PaginationData(),
    this.memoriesPagination = const PaginationData(),
    this.offersPagination = const PaginationData(),
    this.pdfsPagination = const PaginationData(),
    this.photoPostsPagination = const PaginationData(),
    this.videoPostsPagination = const PaginationData(),
    this.selectedViewIndex = 0,
  });

  AllSearchState copyWith({
    SearchedFlickPostsResponse? searchedFlickPosts,
    SearchedMemoriesResponse? searchedMemories,
    SearchedOffersResponse? searchedOffers,
    SearchedPdfsResponse? searchedPdfs,
    SearchedPhotoPostsResponse? searchedPhotoPosts,
    SearchedVideoPostsResponse? searchedVideoPosts,
    PaginationData? flickPostsPagination,
    PaginationData? memoriesPagination,
    PaginationData? offersPagination,
    PaginationData? pdfsPagination,
    PaginationData? photoPostsPagination,
    PaginationData? videoPostsPagination,
    int? selectedViewIndex,
  }) {
    return AllSearchState(
      searchedFlickPosts: searchedFlickPosts ?? this.searchedFlickPosts,
      searchedMemories: searchedMemories ?? this.searchedMemories,
      searchedOffers: searchedOffers ?? this.searchedOffers,
      searchedPdfs: searchedPdfs ?? this.searchedPdfs,
      searchedPhotoPosts: searchedPhotoPosts ?? this.searchedPhotoPosts,
      searchedVideoPosts: searchedVideoPosts ?? this.searchedVideoPosts,
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
        searchedFlickPosts,
        searchedMemories,
        searchedOffers,
        searchedPdfs,
        searchedPhotoPosts,
        searchedVideoPosts,
        flickPostsPagination,
        memoriesPagination,
        offersPagination,
        pdfsPagination,
        photoPostsPagination,
        videoPostsPagination,
        selectedViewIndex,
      ];
}
