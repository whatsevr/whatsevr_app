import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:whatsevr_app/config/api/response_model/search/searched_flick_posts.dart';
import 'package:whatsevr_app/config/api/response_model/search/searched_memories.dart';
import 'package:whatsevr_app/config/api/response_model/search/searched_offers.dart';

import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import 'package:whatsevr_app/config/api/external/models/pagination_data.dart';
import 'package:whatsevr_app/config/api/response_model/search/searched_pdfs.dart';
import 'package:whatsevr_app/config/api/response_model/search/searched_photo_posts.dart';
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
    on<SearchFlickPosts>(
      _onSearchFlickPosts,
      transformer: (events, mapper) =>
          events.debounceTime(_debounceDuration).asyncExpand(mapper),
    );
    on<SearchMoreFlickPosts>(_onSearchMoreFlickPosts);
    on<SearchMemories>(
      _onSearchMemories,
      transformer: (events, mapper) =>
          events.debounceTime(_debounceDuration).asyncExpand(mapper),
    );
    on<SearchMoreMemories>(_onSearchMoreMemories);
    on<SearchOffers>(
      _onSearchOffers,
      transformer: (events, mapper) =>
          events.debounceTime(_debounceDuration).asyncExpand(mapper),
    );
    on<SearchMoreOffers>(_onSearchMoreOffers);
    on<SearchPdfs>(
      _onSearchPdfs,
      transformer: (events, mapper) =>
          events.debounceTime(_debounceDuration).asyncExpand(mapper),
    );
    on<SearchMorePdfs>(_onSearchMorePdfs);
    on<SearchPhotoPosts>(
      _onSearchPhotoPosts,
      transformer: (events, mapper) =>
          events.debounceTime(_debounceDuration).asyncExpand(mapper),
    );
    on<SearchMorePhotoPosts>(_onSearchMorePhotoPosts);
    on<SearchVideoPosts>(
      _onSearchVideoPosts,
      transformer: (events, mapper) =>
          events.debounceTime(_debounceDuration).asyncExpand(mapper),
    );
    on<SearchMoreVideoPosts>(_onSearchMoreVideoPosts);
    on<ChangeTab>(_onChangeTab);
  }

  FutureOr<void> _onSearchFlickPosts(
    SearchFlickPosts event,
    Emitter<AllSearchState> emit,
  ) async {
    try {
      if (event.query.trim().isEmpty) {
        emit(state.copyWith(searchedFlickPosts: null));
        return;
      }

      final response = await TextSearchApi.searchFlickPosts(
        query: event.query,
        page: 1,
      );

      emit(state.copyWith(
        searchedFlickPosts: response,
        flickPostsPagination: PaginationData(
          currentPage: 1,
          noMoreData: response?.lastPage ?? false,
        ),
      ));
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

      emit(state.copyWith(
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
      ));
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onSearchMemories(
    SearchMemories event,
    Emitter<AllSearchState> emit,
  ) async {
    try {
      if (event.query.trim().isEmpty) {
        emit(state.copyWith(searchedMemories: null));
        return;
      }

      final response = await TextSearchApi.searchMemories(
        query: event.query,
        page: 1,
      );

      emit(state.copyWith(
        searchedMemories: response,
        memoriesPagination: PaginationData(
          currentPage: 1,
          noMoreData: response?.lastPage ?? false,
        ),
      ));
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

      emit(state.copyWith(
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
      ));
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onSearchOffers(
    SearchOffers event,
    Emitter<AllSearchState> emit,
  ) async {
    try {
      if (event.query.trim().isEmpty) {
        emit(state.copyWith(searchedOffers: null));
        return;
      }

      final response = await TextSearchApi.searchOffers(
        query: event.query,
        page: 1,
      );

      emit(state.copyWith(
        searchedOffers: response,
        offersPagination: PaginationData(
          currentPage: 1,
          noMoreData: response?.lastPage ?? false,
        ),
      ));
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

      emit(state.copyWith(
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
      ));
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onSearchPdfs(
    SearchPdfs event,
    Emitter<AllSearchState> emit,
  ) async {
    try {
      if (event.query.trim().isEmpty) {
        emit(state.copyWith(searchedPdfs: null));
        return;
      }

      final response = await TextSearchApi.searchPdfs(
        query: event.query,
        page: 1,
      );

      emit(state.copyWith(
        searchedPdfs: response,
        pdfsPagination: PaginationData(
          currentPage: 1,
          noMoreData: response?.lastPage ?? false,
        ),
      ));
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

      emit(state.copyWith(
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
      ));
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onSearchPhotoPosts(
    SearchPhotoPosts event,
    Emitter<AllSearchState> emit,
  ) async {
    try {
      if (event.query.trim().isEmpty) {
        emit(state.copyWith(searchedPhotoPosts: null));
        return;
      }

      final response = await TextSearchApi.searchPhotoPosts(
        query: event.query,
        page: 1,
      );

      emit(state.copyWith(
        searchedPhotoPosts: response,
        photoPostsPagination: PaginationData(
          currentPage: 1,
          noMoreData: response?.lastPage ?? false,
        ),
      ));
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

      emit(state.copyWith(
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
      ));
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onSearchVideoPosts(
    SearchVideoPosts event,
    Emitter<AllSearchState> emit,
  ) async {
    try {
      if (event.query.trim().isEmpty) {
        emit(state.copyWith(searchedVideoPosts: null));
        return;
      }

      final response = await TextSearchApi.searchVideoPosts(
        query: event.query,
        page: 1,
      );

      emit(state.copyWith(
        searchedVideoPosts: response,
        videoPostsPagination: PaginationData(
          currentPage: 1,
          noMoreData: response?.lastPage ?? false,
        ),
      ));
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

      emit(state.copyWith(
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
      ));
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onChangeTab(
    ChangeTab event,
    Emitter<AllSearchState> emit,
  ) {
    emit(state.copyWith(selectedViewIndex: event.index));
  }
}
