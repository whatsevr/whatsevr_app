import 'dart:async';

import 'package:equatable/equatable.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:gap/gap.dart';
import 'package:rxdart/rxdart.dart';
import 'package:whatsevr_app/config/api/external/models/pagination_data.dart';
import 'package:whatsevr_app/config/api/methods/text_search.dart';
import 'package:whatsevr_app/config/api/response_model/search/searched_users_communities.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/widgets/buttons/button.dart';
import 'package:whatsevr_app/config/widgets/textfield/super_textform_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchAndTagUsersAndCommunityPage extends StatefulWidget {
  final bool scaffoldView;
  final Function(
    List<String> selectedUsersUid,
    List<String> selectedCommunitiesUid,
  )? onDone;
  const SearchAndTagUsersAndCommunityPage({
    super.key,
    this.scaffoldView = false,
    required this.onDone,
  });

  @override
  State<SearchAndTagUsersAndCommunityPage> createState() =>
      _SearchAndTagUsersAndCommunityPageState();
}

class _SearchAndTagUsersAndCommunityPageState
    extends State<SearchAndTagUsersAndCommunityPage> {
  List<String> selectedUsersUid = [];
  List<String> selectedCommunitiesUid = [];

  @override
  Widget build(BuildContext context) {
    final Widget child = BlocProvider(
      create: (context) => SearchBloc(),
      child: Builder(
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WhatsevrFormField.textFieldWithClearIcon(
                controller: context.read<SearchBloc>().searchController,
                hintText: 'Search for users or communities',
                onChanged: (String value) {
                  context
                      .read<SearchBloc>()
                      .add(SearchUsersAndCommunities(value));
                },
              ),
              const Gap(8),
              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  final searchedItems = state.results;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (searchedItems?.users?.isNotEmpty ?? false) ...[
                        const Gap(8),
                        const Text('Users'),
                        const Gap(8),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: searchedItems?.users?.length ?? 0,
                          separatorBuilder: (BuildContext context, int index) {
                            return const Gap(4);
                          },
                          itemBuilder: (BuildContext context, int index) {
                            final User? user = searchedItems?.users?[index];
                            return ListTile(
                              dense: true,
                              visualDensity: VisualDensity.compact,
                              onTap: () {
                                if (selectedUsersUid.contains(user?.uid)) {
                                  selectedUsersUid.remove(user?.uid);
                                } else {
                                  selectedUsersUid.add(user?.uid ?? '');
                                }
                                setState(() {});
                              },
                              leading: CircleAvatar(
                                backgroundImage: ExtendedNetworkImageProvider(
                                  user?.profilePicture ??
                                      MockData.blankProfileAvatar,
                                ),
                              ),
                              title: Text(
                                '${user?.name}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text('@${user?.username}'),
                              trailing: selectedUsersUid.contains(user?.uid)
                                  ? const Icon(Icons.check_circle,
                                      color: Colors.green)
                                  : const Icon(Icons.circle_outlined),
                            );
                          },
                        ),
                      ],
                      if (searchedItems?.communities?.isNotEmpty ?? false) ...[
                        const Gap(8),
                        const Text('Communities'),
                        const Gap(8),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: searchedItems?.communities?.length ?? 0,
                          separatorBuilder: (BuildContext context, int index) {
                            return const Gap(4);
                          },
                          itemBuilder: (BuildContext context, int index) {
                            final Community? community =
                                searchedItems?.communities?[index];
                            return ListTile(
                              dense: true,
                              visualDensity: VisualDensity.compact,
                              onTap: () {
                                if (selectedCommunitiesUid
                                    .contains(community?.uid)) {
                                  selectedCommunitiesUid.remove(community?.uid);
                                } else {
                                  selectedCommunitiesUid
                                      .add(community?.uid ?? '');
                                }
                                setState(() {});
                              },
                              leading: CircleAvatar(
                                backgroundImage: ExtendedNetworkImageProvider(
                                  community?.profilePicture ??
                                      MockData.blankCommunityAvatar,
                                ),
                              ),
                              title: Text(
                                '${community?.title}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text('@${community?.username}'),
                              trailing: selectedCommunitiesUid
                                      .contains(community?.uid)
                                  ? const Icon(Icons.check_circle,
                                      color: Colors.green)
                                  : const Icon(Icons.circle_outlined),
                            );
                          },
                        ),
                      ],
                    ],
                  );
                },
              ),
              const Gap(8),
              if (selectedUsersUid.isNotEmpty ||
                  selectedCommunitiesUid.isNotEmpty) ...[
                const Gap(50),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Selected ',
                        style: TextStyle(color: Colors.black),
                      ),
                      if (selectedUsersUid.isNotEmpty) ...[
                        TextSpan(
                          text: '${selectedUsersUid.length} users',
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ],
                      if (selectedUsersUid.isNotEmpty &&
                          selectedCommunitiesUid.isNotEmpty)
                        const TextSpan(
                          text: ' and ',
                          style: TextStyle(color: Colors.black),
                        ),
                      if (selectedCommunitiesUid.isNotEmpty) ...[
                        TextSpan(
                          text: '${selectedCommunitiesUid.length} communities',
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ],
                    ],
                  ),
                ),
                const Gap(8),
                WhatsevrButton.filled(
                  label: 'Done',
                  onPressed: () {
                    widget.onDone
                        ?.call(selectedUsersUid, selectedCommunitiesUid);
                    Navigator.pop(context);
                  },
                ),
              ],
            ],
          );
        },
      ),
    );
    if (widget.scaffoldView) {
      return Scaffold(
        body: child,
      );
    }
    return child;
  }
}

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchUsersAndCommunities extends SearchEvent {
  final String query;

  const SearchUsersAndCommunities(this.query);

  @override
  List<Object> get props => [query];
}

class LoadMoreResults extends SearchEvent {}

// 1. Debouncing Search
// Currently missing debounce logic which could lead to excessive API calls
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final TextEditingController searchController = TextEditingController();
  static const _debounceDuration = Duration(milliseconds: 300);

  SearchBloc() : super(const SearchState()) {
    on<SearchUsersAndCommunities>(_mapSearchUsersAndCommunities,
        transformer: (events, mapper) =>
            events.debounceTime(_debounceDuration).asyncExpand(mapper));
    on<LoadMoreResults>(_mapLoadMoreResults);
  }

  // 2. Error Handling
  FutureOr<void> _mapSearchUsersAndCommunities(
      SearchUsersAndCommunities event, Emitter<SearchState> emit) async {
    try {
      if (event.query.trim().isEmpty) {
        emit(state.copyWith(results: null));
        return;
      }

      emit(state.copyWith(isLoading: true, error: null));

      final response = await TextSearchApi.searchUsersAndCommunities(
        query: event.query,
        page: 1,
      );

      emit(state.copyWith(
        results: response,
        isLoading: false,
        paginationData: PaginationData(
          currentPage: 1,
          noMoreData: response == null ||
              (response.users?.isEmpty ??
                  true && (response.communities?.isEmpty ?? true)),
        ),
      ));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, error: 'Search failed: ${e.toString()}'));
    }
  }

  // 3. Improved Pagination Logic
  FutureOr<void> _mapLoadMoreResults(
      LoadMoreResults event, Emitter<SearchState> emit) async {
    if (state.paginationData.noMoreData || state.isLoading) return;

    try {
      emit(state.copyWith(isLoadingMore: true));

      final nextPage = state.paginationData.currentPage + 1;
      final response = await TextSearchApi.searchUsersAndCommunities(
        query: searchController.text,
        page: nextPage,
      );

      final bool noMoreData = response == null ||
          (response.users?.isEmpty ??
              true && (response.communities?.isEmpty ?? true));

      if (noMoreData) {
        emit(state.copyWith(
          isLoadingMore: false,
          paginationData: state.paginationData.copyWith(noMoreData: true),
        ));
        return;
      }

      final updatedResults = state.results?.copyWith(
        users: [...(state.results?.users ?? []), ...(response.users ?? [])],
        communities: [
          ...(state.results?.communities ?? []),
          ...(response.communities ?? [])
        ],
      );

      emit(state.copyWith(
        results: updatedResults,
        isLoadingMore: false,
        paginationData: state.paginationData.copyWith(currentPage: nextPage),
      ));
    } catch (e) {
      emit(state.copyWith(
          isLoadingMore: false,
          error: 'Failed to load more results: ${e.toString()}'));
    }
  }
}

// 4. Enhanced State Management
class SearchState extends Equatable {
  final SearchedUsersAndCommunitiesResponse? results;
  final PaginationData paginationData;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;

  const SearchState({
    this.results,
    this.paginationData = const PaginationData(),
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
  });

  SearchState copyWith({
    SearchedUsersAndCommunitiesResponse? results,
    PaginationData? paginationData,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
  }) {
    return SearchState(
      results: results ?? this.results,
      paginationData: paginationData ?? this.paginationData,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
    );
  }

  @override
  List<Object?> get props =>
      [results, paginationData, isLoading, isLoadingMore, error];
}
