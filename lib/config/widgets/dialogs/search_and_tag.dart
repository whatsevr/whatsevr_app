import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:extended_image/extended_image.dart';
import 'package:gap/gap.dart';
import 'package:rxdart/rxdart.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import 'package:whatsevr_app/config/api/external/models/pagination_data.dart';
import 'package:whatsevr_app/config/api/methods/text_search.dart';
import 'package:whatsevr_app/config/api/response_model/search/searched_users_communities.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/widgets/buttons/button.dart';
import 'package:whatsevr_app/config/widgets/tab_bar.dart';
import 'package:whatsevr_app/config/widgets/textfield/super_textform_field.dart';

class SearchAndTagUsersAndCommunityPage extends StatelessWidget {
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

  Widget _buildUsersList(BuildContext context, SearchState state) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: state.searchedUsersCommunities?.users?.length ?? 0,
      separatorBuilder: (context, index) => const Gap(4),
      itemBuilder: (context, index) {
        final user = state.searchedUsersCommunities?.users?[index];
        return ListTile(
          dense: true,
          visualDensity: VisualDensity.compact,
          onTap: () {
            context
                .read<SearchBloc>()
                .add(UpdateSelectedUsers(user?.uid ?? ''));
          },
          leading: CircleAvatar(
            backgroundImage: ExtendedNetworkImageProvider(
              user?.profilePicture ?? MockData.blankProfileAvatar,
            ),
          ),
          title: Text(
            '${user?.name}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text('@${user?.username}'),
          trailing: state.selectedUsersUid.contains(user?.uid)
              ? const Icon(Icons.check_circle, color: Colors.green)
              : const Icon(Icons.circle_outlined),
        );
      },
    );
  }

  Widget _buildCommunitiesList(BuildContext context, SearchState state) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: state.searchedUsersCommunities?.communities?.length ?? 0,
      separatorBuilder: (context, index) => const Gap(4),
      itemBuilder: (context, index) {
        final community = state.searchedUsersCommunities?.communities?[index];
        return ListTile(
          dense: true,
          visualDensity: VisualDensity.compact,
          onTap: () {
            context
                .read<SearchBloc>()
                .add(UpdateSelectedCommunities(community?.uid ?? ''));
          },
          leading: CircleAvatar(
            backgroundImage: ExtendedNetworkImageProvider(
              community?.profilePicture ?? MockData.blankCommunityAvatar,
            ),
          ),
          title: Text(
            '${community?.title}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text('@${community?.username}'),
          trailing: state.selectedCommunitiesUid.contains(community?.uid)
              ? const Icon(Icons.check_circle, color: Colors.green)
              : const Icon(Icons.circle_outlined),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget child = BlocProvider(
      create: (context) => SearchBloc(),
      child: Builder(
        builder: (context) {
          final ScrollController usersScrollController = ScrollController();
          usersScrollController.addListener(() {
            if (usersScrollController.position.pixels >=
                usersScrollController.position.maxScrollExtent) {
              context.read<SearchBloc>().add(LoadMoreResults());
            }
          });
          return ListView(
            controller: usersScrollController,
            children: [
              WhatsevrFormField.textFieldWithClearIcon(
                controller: context.read<SearchBloc>().searchController,
                hintText: 'Search for users or communities',
                onChanged: (value) {
                  context
                      .read<SearchBloc>()
                      .add(SearchUsersAndCommunities(value));
                },
              ),
              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      if (state.selectedUsersUid.isNotEmpty ||
                          state.selectedCommunitiesUid.isNotEmpty) ...[
                        const Gap(8),
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Selected ',
                                style: TextStyle(color: Colors.black),
                              ),
                              if (state.selectedUsersUid.isNotEmpty) ...[
                                TextSpan(
                                  text:
                                      '${state.selectedUsersUid.length} users',
                                  style: const TextStyle(color: Colors.blue),
                                ),
                              ],
                              if (state.selectedUsersUid.isNotEmpty &&
                                  state.selectedCommunitiesUid.isNotEmpty)
                                const TextSpan(
                                  text: ' and ',
                                  style: TextStyle(color: Colors.black),
                                ),
                              if (state.selectedCommunitiesUid.isNotEmpty) ...[
                                TextSpan(
                                  text:
                                      '${state.selectedCommunitiesUid.length} communities',
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
                            onDone?.call(
                              state.selectedUsersUid,
                              state.selectedCommunitiesUid,
                            );
                            Navigator.pop(context);
                          },
                        ),
                      ],
                      const Gap(8),
                      WhatsevrTabBarWithViews(
                        shrinkViews: true,
                        tabViews: [
                          ('Users', _buildUsersList(context, state)),
                          (
                            'Communities',
                            _buildCommunitiesList(context, state)
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          );
        },
      ),
    );

    if (scaffoldView) {
      return Scaffold(body: child);
    }
    return child;
  }
}

class SearchState extends Equatable {
  final SearchedUsersAndCommunitiesResponse? searchedUsersCommunities;
  final PaginationData usersAndCommunitiesPagination;
  final int selectedViewIndex;
  final List<String> selectedUsersUid;
  final List<String> selectedCommunitiesUid;

  const SearchState({
    this.searchedUsersCommunities,
    this.usersAndCommunitiesPagination = const PaginationData(),
    this.selectedViewIndex = 0,
    this.selectedUsersUid = const [],
    this.selectedCommunitiesUid = const [],
  });

  SearchState copyWith({
    SearchedUsersAndCommunitiesResponse? searchedUsersCommunities,
    PaginationData? usersAndCommunitiesPagination,
    int? selectedViewIndex,
    List<String>? selectedUsersUid,
    List<String>? selectedCommunitiesUid,
  }) {
    return SearchState(
      searchedUsersCommunities:
          searchedUsersCommunities ?? this.searchedUsersCommunities,
      usersAndCommunitiesPagination:
          usersAndCommunitiesPagination ?? this.usersAndCommunitiesPagination,
      selectedViewIndex: selectedViewIndex ?? this.selectedViewIndex,
      selectedUsersUid: selectedUsersUid ?? this.selectedUsersUid,
      selectedCommunitiesUid:
          selectedCommunitiesUid ?? this.selectedCommunitiesUid,
    );
  }

  @override
  List<Object?> get props => [
        searchedUsersCommunities,
        usersAndCommunitiesPagination,
        selectedViewIndex,
        selectedUsersUid,
        selectedCommunitiesUid,
      ];
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

class LoadMoreResults extends SearchEvent {
  const LoadMoreResults();

  @override
  List<Object> get props => [];
}

class ChangeTab extends SearchEvent {
  final int index;

  const ChangeTab(this.index);

  @override
  List<Object> get props => [index];
}

class UpdateSelectedUsers extends SearchEvent {
  final String userUid;

  const UpdateSelectedUsers(this.userUid);

  @override
  List<Object> get props => [userUid];
}

class UpdateSelectedCommunities extends SearchEvent {
  final String communityUid;

  const UpdateSelectedCommunities(this.communityUid);

  @override
  List<Object> get props => [communityUid];
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final TextEditingController searchController = TextEditingController();
  static const _debounceDuration = Duration(milliseconds: 300);

  SearchBloc() : super(const SearchState()) {
    on<SearchUsersAndCommunities>(
      _onSearchUsersAndCommunities,
      transformer: (events, mapper) =>
          events.debounceTime(_debounceDuration).asyncExpand(mapper),
    );
    on<LoadMoreResults>(_onLoadMore);
    on<ChangeTab>(_onChangeTab);
    on<UpdateSelectedUsers>(_onUpdateSelectedUsers);
    on<UpdateSelectedCommunities>(_onUpdateSelectedCommunities);
  }

  FutureOr<void> _onSearchUsersAndCommunities(
    SearchUsersAndCommunities event,
    Emitter<SearchState> emit,
  ) async {
    try {
      if (event.query.trim().isEmpty) {
        emit(state.copyWith(searchedUsersCommunities: null));
        return;
      }

      final response = await TextSearchApi.searchUsersAndCommunities(
        query: event.query,
        page: 1,
      );

      emit(
        state.copyWith(
          searchedUsersCommunities: response,
          usersAndCommunitiesPagination: PaginationData(
            currentPage: 1,
            noMoreData: response?.users?.isEmpty ?? true,
          ),
        ),
      );
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onLoadMore(
    LoadMoreResults event,
    Emitter<SearchState> emit,
  ) async {
    final currentPagination = state.usersAndCommunitiesPagination;

    if (currentPagination.noMoreData) return;

    try {
      final nextPage = currentPagination.currentPage + 1;
      final response = await TextSearchApi.searchUsersAndCommunities(
        query: searchController.text,
        page: nextPage,
      );

      if (response == null) {
        emit(
          state.copyWith(
            usersAndCommunitiesPagination:
                state.usersAndCommunitiesPagination.copyWith(noMoreData: true),
          ),
        );
        return;
      }

      emit(
        state.copyWith(
          searchedUsersCommunities: state.searchedUsersCommunities?.copyWith(
            users: [
              ...(state.searchedUsersCommunities?.users ?? []),
              ...(response.users ?? []),
            ],
            communities: [
              ...(state.searchedUsersCommunities?.communities ?? []),
              ...(response.communities ?? []),
            ],
          ),
          usersAndCommunitiesPagination: state.usersAndCommunitiesPagination
              .copyWith(currentPage: nextPage),
        ),
      );
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _onChangeTab(
    ChangeTab event,
    Emitter<SearchState> emit,
  ) {
    emit(state.copyWith(selectedViewIndex: event.index));
  }

  FutureOr<void> _onUpdateSelectedUsers(
    UpdateSelectedUsers event,
    Emitter<SearchState> emit,
  ) {
    final updatedList = List<String>.from(state.selectedUsersUid);
    if (updatedList.contains(event.userUid)) {
      updatedList.remove(event.userUid);
    } else {
      updatedList.add(event.userUid);
    }
    emit(state.copyWith(selectedUsersUid: updatedList));
  }

  FutureOr<void> _onUpdateSelectedCommunities(
    UpdateSelectedCommunities event,
    Emitter<SearchState> emit,
  ) {
    final updatedList = List<String>.from(state.selectedCommunitiesUid);
    if (updatedList.contains(event.communityUid)) {
      updatedList.remove(event.communityUid);
    } else {
      updatedList.add(event.communityUid);
    }
    emit(state.copyWith(selectedCommunitiesUid: updatedList));
  }
}
