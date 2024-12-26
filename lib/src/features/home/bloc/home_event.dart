part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomeInitialEvent extends HomeEvent {
  @override
  List<Object> get props => <Object>[];
}

class LoadVideosEvent extends HomeEvent {
  @override
  List<Object> get props => <Object>[];
}

class LoadMoreVideosEvent extends HomeEvent {
  final int? page;
  const LoadMoreVideosEvent({required this.page});
  @override
  List<Object?> get props => <Object?>[page];
}

class LoadMemoriesEvent extends HomeEvent {
  @override
  List<Object> get props => <Object>[];
}

class LoadMoreMemoriesEvent extends HomeEvent {
  final int? page;
  const LoadMoreMemoriesEvent({required this.page});
  @override
  List<Object?> get props => <Object?>[page];
}

class LoadOffersEvent extends HomeEvent {
  @override
  List<Object> get props => <Object>[];
}

class LoadMoreOffersEvent extends HomeEvent {
  final int? page;
  const LoadMoreOffersEvent({required this.page});
  @override
  List<Object?> get props => <Object?>[page];
}

class LoadPhotoPostsEvent extends HomeEvent {
  @override
  List<Object> get props => <Object>[];
}

class LoadMorePhotoPostsEvent extends HomeEvent {
  final int? page;
  const LoadMorePhotoPostsEvent({required this.page});
  @override
  List<Object?> get props => <Object?>[page];
}

class LoadMixContentEvent extends HomeEvent {
  @override
  List<Object> get props => <Object>[];
}

class LoadMoreMixContentEvent extends HomeEvent {
  final int? page;
  const LoadMoreMixContentEvent({required this.page});
  @override
  List<Object?> get props => <Object?>[page];
}
