import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:whatsevr_app/config/api/response_model/search/searched_communities.dart';
import 'package:whatsevr_app/config/api/response_model/search/searched_flick_posts.dart';
import 'package:whatsevr_app/config/api/response_model/search/searched_memories.dart';
import 'package:whatsevr_app/config/api/response_model/search/searched_offers.dart';

import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import 'package:whatsevr_app/config/api/external/models/pagination_data.dart';
import 'package:whatsevr_app/config/api/response_model/search/searched_pdfs.dart';
import 'package:whatsevr_app/config/api/response_model/search/searched_photo_posts.dart';
import 'package:whatsevr_app/config/api/response_model/search/searched_portfolios.dart';
import 'package:whatsevr_app/config/api/response_model/search/searched_users.dart';
import 'package:whatsevr_app/config/api/response_model/search/searched_video_posts.dart';

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:whatsevr_app/config/api/methods/text_search.dart';
part 'all_search_event.dart';
part 'all_search_state.dart';

class AllSearchBloc extends Bloc<AllSearchEvent, AllSearchState> {
  final TextEditingController searchController = TextEditingController();
  static const _debounceDuration = Duration(milliseconds: 300);

  AllSearchBloc() : super(const AllSearchState()) {
    on<SearchTextChangedEvent>(
      _onSearchTextChanged,
      transformer: (events, mapper) =>
          events.debounceTime(_debounceDuration).asyncExpand(mapper),
    );
    on<SearchUsersEvent>(_onSearchUsers);
    on<SearchPortfoliosEvent>(_onSearchPortfolios);
    on<SearchCommunitiesEvent>(_onSearchCommunities);
    on<SearchFlickPostsEvent>(_onSearchFlickPosts);
    on<SearchMemoriesEvent>(_onSearchMemories);
    on<SearchOffersEvent>(_onSearchOffers);
    on<SearchPdfsEvent>(_onSearchPdfs);
    on<SearchPhotoPostsEvent>(_onSearchPhotoPosts);
    on<SearchVideoPostsEvent>(_onSearchVideoPosts);
    on<SearchMoreUsers>(_onSearchMoreUsers);
    on<SearchMorePortfolios>(_onSearchMorePortfolios);
    on<SearchMoreCommunities>(_onSearchMoreCommunities);
    on<SearchMoreFlickPosts>(_onSearchMoreFlickPosts);
    on<SearchMoreMemories>(_onSearchMoreMemories);
    on<SearchMoreOffers>(_onSearchMoreOffers);
    on<SearchMorePdfs>(_onSearchMorePdfs);
    on<SearchMorePhotoPosts>(_onSearchMorePhotoPosts);
    on<SearchMoreVideoPosts>(_onSearchMoreVideoPosts);
    on<TabChangedEvent>(_onChangeTab);
  }

  FutureOr<void> _onSearchUsers(
    SearchUsersEvent event,
    Emitter<AllSearchState> emit,
  ) async {
    try {
      if (event.query.trim().isEmpty) {
        emit(state.copyWith(searchedUsers: null));
        return;
      }

      final response = await TextSearchApi.searchUsers(
        query: event.query,
        page: event.page,
        pageSize: event.pageSize,
      );

      emit(state.copyWith(searchedUsers: response));
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onSearchPortfolios(
    SearchPortfoliosEvent event,
    Emitter<AllSearchState> emit,
  ) async {
    try {
      if (event.query.trim().isEmpty) {
        emit(state.copyWith(searchedPortfolios: null));
        return;
      }

      final response = await TextSearchApi.searchPortfolios(
        query: event.query,
        page: event.page,
        pageSize: event.pageSize,
      );

      emit(state.copyWith(searchedPortfolios: response));
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onSearchCommunities(
    SearchCommunitiesEvent event,
    Emitter<AllSearchState> emit,
  ) async {
    try {
      if (event.query.trim().isEmpty) {
        emit(state.copyWith(searchedCommunities: null));
        return;
      }

      final response = await TextSearchApi.searchCommunities(
        query: event.query,
        page: event.page,
        pageSize: event.pageSize,
      );

      emit(state.copyWith(searchedCommunities: response));
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onSearchFlickPosts(
    SearchFlickPostsEvent event,
    Emitter<AllSearchState> emit,
  ) async {
    try {
      if (event.query.trim().isEmpty) {
        emit(state.copyWith(searchedFlickPosts: null));
        return;
      }

      final response = await TextSearchApi.searchFlickPosts(
        query: event.query,
        page: event.page,
        pageSize: event.pageSize,
      );

      emit(state.copyWith(searchedFlickPosts: response));
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onSearchMemories(
    SearchMemoriesEvent event,
    Emitter<AllSearchState> emit,
  ) async {
    try {
      if (event.query.trim().isEmpty) {
        emit(state.copyWith(searchedMemories: null));
        return;
      }

      final response = await TextSearchApi.searchMemories(
        query: event.query,
        page: event.page,
        pageSize: event.pageSize,
      );

      emit(state.copyWith(searchedMemories: response));
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onSearchOffers(
    SearchOffersEvent event,
    Emitter<AllSearchState> emit,
  ) async {
    try {
      if (event.query.trim().isEmpty) {
        emit(state.copyWith(searchedOffers: null));
        return;
      }

      final response = await TextSearchApi.searchOffers(
        query: event.query,
        page: event.page,
        pageSize: event.pageSize,
      );

      emit(state.copyWith(searchedOffers: response));
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onSearchPdfs(
    SearchPdfsEvent event,
    Emitter<AllSearchState> emit,
  ) async {
    try {
      if (event.query.trim().isEmpty) {
        emit(state.copyWith(searchedPdfs: null));
        return;
      }

      final response = await TextSearchApi.searchPdfs(
        query: event.query,
        page: event.page,
        pageSize: event.pageSize,
      );

      emit(state.copyWith(searchedPdfs: response));
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onSearchPhotoPosts(
    SearchPhotoPostsEvent event,
    Emitter<AllSearchState> emit,
  ) async {
    try {
      if (event.query.trim().isEmpty) {
        emit(state.copyWith(searchedPhotoPosts: null));
        return;
      }

      final response = await TextSearchApi.searchPhotoPosts(
        query: event.query,
        page: event.page,
        pageSize: event.pageSize,
      );

      emit(state.copyWith(searchedPhotoPosts: response));
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onSearchVideoPosts(
    SearchVideoPostsEvent event,
    Emitter<AllSearchState> emit,
  ) async {
    try {
      if (event.query.trim().isEmpty) {
        emit(state.copyWith(searchedVideoPosts: null));
        return;
      }

      final response = await TextSearchApi.searchVideoPosts(
        query: event.query,
        page: event.page,
        pageSize: event.pageSize,
      );

      emit(state.copyWith(searchedVideoPosts: response));
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onSearchMoreUsers(
    SearchMoreUsers event,
    Emitter<AllSearchState> emit,
  ) async {
    try {
      if (state.usersPagination.noMoreData) return;
      final currentPage = state.usersPagination.currentPage;
      final response = await TextSearchApi.searchUsers(
        query: searchController.text,
        page: currentPage + 1,
      );

      emit(
        state.copyWith(
          searchedUsers: state.searchedUsers?.copyWith(
            users: [
              ...state.searchedUsers?.users ?? [],
              ...response?.users ?? [],
            ],
          ),
          usersPagination: PaginationData(
            currentPage: currentPage + 1,
            noMoreData: response?.lastPage ?? false,
          ),
        ),
      );
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onSearchMorePortfolios(
    SearchMorePortfolios event,
    Emitter<AllSearchState> emit,
  ) async {
    try {
      final currentPage = state.portfoliosPagination.currentPage;
      final response = await TextSearchApi.searchPortfolios(
        query: searchController.text,
        page: currentPage + 1,
      );

      emit(
        state.copyWith(
          searchedPortfolios: state.searchedPortfolios?.copyWith(
            portfolios: [
              ...state.searchedPortfolios?.portfolios ?? [],
              ...response?.portfolios ?? [],
            ],
          ),
          portfoliosPagination: PaginationData(
            currentPage: currentPage + 1,
            noMoreData: response?.lastPage ?? false,
          ),
        ),
      );
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onSearchMoreCommunities(
    SearchMoreCommunities event,
    Emitter<AllSearchState> emit,
  ) async {
    try {
      final currentPage = state.communitiesPagination.currentPage;
      final response = await TextSearchApi.searchCommunities(
        query: searchController.text,
        page: currentPage + 1,
      );

      emit(
        state.copyWith(
          searchedCommunities: state.searchedCommunities?.copyWith(
            communities: [
              ...state.searchedCommunities?.communities ?? [],
              ...response?.communities ?? [],
            ],
          ),
          communitiesPagination: PaginationData(
            currentPage: currentPage + 1,
            noMoreData: response?.lastPage ?? false,
          ),
        ),
      );
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onSearchMoreFlickPosts(
    SearchMoreFlickPosts event,
    Emitter<AllSearchState> emit,
  ) async {
    try {
      final currentPage = state.flickPostsPagination.currentPage;
      final response = await TextSearchApi.searchFlickPosts(
        query: searchController.text,
        page: currentPage + 1,
      );

      emit(
        state.copyWith(
          searchedFlickPosts: state.searchedFlickPosts?.copyWith(
            flicks: [
              ...state.searchedFlickPosts?.flicks ?? [],
              ...response?.flicks ?? [],
            ],
          ),
          flickPostsPagination: PaginationData(
            currentPage: currentPage + 1,
            noMoreData: response?.lastPage ?? false,
          ),
        ),
      );
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onSearchMoreMemories(
    SearchMoreMemories event,
    Emitter<AllSearchState> emit,
  ) async {
    try {
      final currentPage = state.memoriesPagination.currentPage;
      final response = await TextSearchApi.searchMemories(
        query: searchController.text,
        page: currentPage + 1,
      );

      emit(
        state.copyWith(
          searchedMemories: state.searchedMemories?.copyWith(
            memories: [
              ...state.searchedMemories?.memories ?? [],
              ...response?.memories ?? [],
            ],
          ),
          memoriesPagination: PaginationData(
            currentPage: currentPage + 1,
            noMoreData: response?.lastPage ?? false,
          ),
        ),
      );
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onSearchMoreOffers(
    SearchMoreOffers event,
    Emitter<AllSearchState> emit,
  ) async {
    try {
      final currentPage = state.offersPagination.currentPage;
      final response = await TextSearchApi.searchOffers(
        query: searchController.text,
        page: currentPage + 1,
      );

      emit(
        state.copyWith(
          searchedOffers: state.searchedOffers?.copyWith(
            offers: [
              ...state.searchedOffers?.offers ?? [],
              ...response?.offers ?? [],
            ],
          ),
          offersPagination: PaginationData(
            currentPage: currentPage + 1,
            noMoreData: response?.lastPage ?? false,
          ),
        ),
      );
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onSearchMorePdfs(
    SearchMorePdfs event,
    Emitter<AllSearchState> emit,
  ) async {
    try {
      final currentPage = state.pdfsPagination.currentPage;
      final response = await TextSearchApi.searchPdfs(
        query: searchController.text,
        page: currentPage + 1,
      );

      emit(
        state.copyWith(
          searchedPdfs: state.searchedPdfs?.copyWith(
            pdfs: [
              ...state.searchedPdfs?.pdfs ?? [],
              ...response?.pdfs ?? [],
            ],
          ),
          pdfsPagination: PaginationData(
            currentPage: currentPage + 1,
            noMoreData: response?.lastPage ?? false,
          ),
        ),
      );
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onSearchMorePhotoPosts(
    SearchMorePhotoPosts event,
    Emitter<AllSearchState> emit,
  ) async {
    try {
      final currentPage = state.photoPostsPagination.currentPage;
      final response = await TextSearchApi.searchPhotoPosts(
        query: searchController.text,
        page: currentPage + 1,
      );

      emit(
        state.copyWith(
          searchedPhotoPosts: state.searchedPhotoPosts?.copyWith(
            photoPosts: [
              ...state.searchedPhotoPosts?.photoPosts ?? [],
              ...response?.photoPosts ?? [],
            ],
          ),
          photoPostsPagination: PaginationData(
            currentPage: currentPage + 1,
            noMoreData: response?.lastPage ?? false,
          ),
        ),
      );
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onSearchMoreVideoPosts(
    SearchMoreVideoPosts event,
    Emitter<AllSearchState> emit,
  ) async {
    try {
      final currentPage = state.videoPostsPagination.currentPage;
      final response = await TextSearchApi.searchVideoPosts(
        query: searchController.text,
        page: currentPage + 1,
      );

      emit(
        state.copyWith(
          searchedVideoPosts: state.searchedVideoPosts?.copyWith(
            videoPosts: [
              ...state.searchedVideoPosts?.videoPosts ?? [],
              ...response?.videoPosts ?? [],
            ],
          ),
          videoPostsPagination: PaginationData(
            currentPage: currentPage + 1,
            noMoreData: response?.lastPage ?? false,
          ),
        ),
      );
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onChangeTab(
    TabChangedEvent event,
    Emitter<AllSearchState> emit,
  ) {
    emit(state.copyWith(selectedViewIndex: event.index));
  }

  FutureOr<void> _onSearchTextChanged(
    SearchTextChangedEvent event,
    Emitter<AllSearchState> emit,
  ) async {
    if (event.query.trim().isEmpty || event.query.length < 4) {
      return;
    }
    emit(AllSearchState());
    add(SearchUsersEvent(event.query));
    add(SearchPortfoliosEvent(event.query));
    add(SearchCommunitiesEvent(event.query));
    add(SearchFlickPostsEvent(event.query));
    add(SearchMemoriesEvent(event.query));
    add(SearchOffersEvent(event.query));
    add(SearchPdfsEvent(event.query));
    add(SearchPhotoPostsEvent(event.query));
    add(SearchVideoPostsEvent(event.query));
  }
}
