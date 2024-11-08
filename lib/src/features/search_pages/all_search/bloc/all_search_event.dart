part of 'all_search_bloc.dart';

sealed class AllSearchEvent extends Equatable {
  const AllSearchEvent();

  @override
  List<Object> get props => [];
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

class ChangeTab extends AllSearchEvent {
  final int index;

  const ChangeTab(this.index);

  @override
  List<Object> get props => [index];
}
