import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import 'package:whatsevr_app/config/api/external/models/pagination_data.dart';
import 'package:whatsevr_app/config/api/methods/community.dart';
import 'package:whatsevr_app/config/api/response_model/community/top_communities.dart';
import 'package:whatsevr_app/src/features/new_community/views/page.dart';

part 'new_community_event.dart';
part 'new_community_state.dart';

class NewCommunityBloc extends Bloc<NewCommunityEvent, NewCommunityState> {
  NewCommunityBloc()
      : super(NewCommunityState(
          topCommunities: const [],
          topCommunitiesPaginationData: PaginationData(),
        )) {
    on<NewCommunityInitialEvent>(_onInitialEvent);
    on<LoadTopCommunitiesEvent>(_loadTopCommunities);
    on<LoadMoreTopCommunitiesEvent>(_loadMoreTopCommunities);
  }

  FutureOr<void> _onInitialEvent(
      NewCommunityInitialEvent event, Emitter<NewCommunityState> emit) {
    add(const LoadTopCommunitiesEvent());
  }

  FutureOr<void> _loadTopCommunities(
      LoadTopCommunitiesEvent event, Emitter<NewCommunityState> emit) async {
    try {
      // Fetch the top communities from the API
      final TopCommunitiesResponse? topCommunities =
          await CommunityApi.topCommunities(page: 1);
      emit(state.copyWith(
        topCommunities: topCommunities?.topCommunities,
        topCommunitiesPaginationData:
            state.topCommunitiesPaginationData?.copyWith(
          currentPage: 1,
          isLoading: false,
          noMoreData: topCommunities?.lastPage,
        ),
      ));
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _loadMoreTopCommunities(LoadMoreTopCommunitiesEvent event,
      Emitter<NewCommunityState> emit) async {
    if (state.topCommunitiesPaginationData?.isLoading == true ||
        state.topCommunitiesPaginationData?.noMoreData == true) return;
    try {
      emit(state.copyWith(
          topCommunitiesPaginationData:
              state.topCommunitiesPaginationData?.copyWith(isLoading: true)));
      final TopCommunitiesResponse? topCommunities =
          await CommunityApi.topCommunities(page: event.page!);
      emit(state.copyWith(
        topCommunities: state.topCommunities! + topCommunities!.topCommunities!,
        topCommunitiesPaginationData:
            state.topCommunitiesPaginationData?.copyWith(
          currentPage: event.page,
          isLoading: false,
          noMoreData: topCommunities.lastPage,
        ),
      ));
    } catch (e, s) {
      emit(state.copyWith(
        topCommunitiesPaginationData:
            state.topCommunitiesPaginationData?.copyWith(
          isLoading: false,
        ),
      ));
      highLevelCatch(e, s);
    }
  }
}