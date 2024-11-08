part of 'all_search_bloc.dart';

sealed class AllSearchEvent extends Equatable {
  const AllSearchEvent();

  @override
  List<Object> get props => [];
}

class SearchTextChangedEvent extends AllSearchEvent {
  final String query;

  const SearchTextChangedEvent(this.query);

  @override
  List<Object> get props => [query];
}

class SearchUsersEvent extends AllSearchEvent {
  final String query;
  final int page;
  final int pageSize;

  const SearchUsersEvent(this.query, {this.page = 1, this.pageSize = 20});

  @override
  List<Object> get props => [query, page, pageSize];
}

class SearchPortfoliosEvent extends AllSearchEvent {
  final String query;
  final int page;
  final int pageSize;

  const SearchPortfoliosEvent(this.query, {this.page = 1, this.pageSize = 20});

  @override
  List<Object> get props => [query, page, pageSize];
}

class SearchCommunitiesEvent extends AllSearchEvent {
  final String query;
  final int page;
  final int pageSize;

  const SearchCommunitiesEvent(this.query, {this.page = 1, this.pageSize = 20});

  @override
  List<Object> get props => [query, page, pageSize];
}

class SearchFlickPostsEvent extends AllSearchEvent {
  final String query;
  final int page;
  final int pageSize;

  const SearchFlickPostsEvent(this.query, {this.page = 1, this.pageSize = 20});

  @override
  List<Object> get props => [query, page, pageSize];
}

class SearchMemoriesEvent extends AllSearchEvent {
  final String query;
  final int page;
  final int pageSize;

  const SearchMemoriesEvent(this.query, {this.page = 1, this.pageSize = 20});

  @override
  List<Object> get props => [query, page, pageSize];
}

class SearchOffersEvent extends AllSearchEvent {
  final String query;
  final int page;
  final int pageSize;

  const SearchOffersEvent(this.query, {this.page = 1, this.pageSize = 20});

  @override
  List<Object> get props => [query, page, pageSize];
}

class SearchPdfsEvent extends AllSearchEvent {
  final String query;
  final int page;
  final int pageSize;

  const SearchPdfsEvent(this.query, {this.page = 1, this.pageSize = 20});

  @override
  List<Object> get props => [query, page, pageSize];
}

class SearchPhotoPostsEvent extends AllSearchEvent {
  final String query;
  final int page;
  final int pageSize;

  const SearchPhotoPostsEvent(this.query, {this.page = 1, this.pageSize = 20});

  @override
  List<Object> get props => [query, page, pageSize];
}

class SearchVideoPostsEvent extends AllSearchEvent {
  final String query;
  final int page;
  final int pageSize;

  const SearchVideoPostsEvent(this.query, {this.page = 1, this.pageSize = 20});

  @override
  List<Object> get props => [query, page, pageSize];
}

class SearchFlickPosts extends AllSearchEvent {
  final String query;

  const SearchFlickPosts(this.query);

  @override
  List<Object> get props => [query];
}

class SearchMemories extends AllSearchEvent {
  final String query;

  const SearchMemories(this.query);

  @override
  List<Object> get props => [query];
}

class SearchOffers extends AllSearchEvent {
  final String query;

  const SearchOffers(this.query);

  @override
  List<Object> get props => [query];
}

class SearchPdfs extends AllSearchEvent {
  final String query;

  const SearchPdfs(this.query);

  @override
  List<Object> get props => [query];
}

class SearchPhotoPosts extends AllSearchEvent {
  final String query;

  const SearchPhotoPosts(this.query);

  @override
  List<Object> get props => [query];
}

class SearchVideoPosts extends AllSearchEvent {
  final String query;

  const SearchVideoPosts(this.query);

  @override
  List<Object> get props => [query];
}

class SearchMoreUsers extends AllSearchEvent {
  const SearchMoreUsers();
}

class SearchMorePortfolios extends AllSearchEvent {
  const SearchMorePortfolios();
}

class SearchMoreCommunities extends AllSearchEvent {
  const SearchMoreCommunities();
}

class SearchMoreFlickPosts extends AllSearchEvent {
  const SearchMoreFlickPosts();
}

class SearchMoreMemories extends AllSearchEvent {
  const SearchMoreMemories();
}

class SearchMoreOffers extends AllSearchEvent {
  const SearchMoreOffers();
}

class SearchMorePdfs extends AllSearchEvent {
  const SearchMorePdfs();
}

class SearchMorePhotoPosts extends AllSearchEvent {
  const SearchMorePhotoPosts();
}

class SearchMoreVideoPosts extends AllSearchEvent {
  const SearchMoreVideoPosts();
}

class TabChangedEvent extends AllSearchEvent {
  final int index;

  const TabChangedEvent(this.index);

  @override
  List<Object> get props => [index];
}
