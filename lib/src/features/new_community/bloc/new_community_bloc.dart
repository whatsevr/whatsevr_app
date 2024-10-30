import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../../../config/api/external/models/business_validation_exception.dart';
import '../../../../config/api/external/models/pagination_data.dart';
import '../../../../config/api/methods/community.dart';
import '../../../../config/api/requests_model/community/create_community.dart';
import '../../../../config/api/response_model/community/top_communities.dart';
import '../../../../config/services/auth_db.dart';
import '../views/page.dart';

part 'new_community_event.dart';
part 'new_community_state.dart';

class NewCommunityBloc extends Bloc<NewCommunityEvent, NewCommunityState> {
  final TextEditingController communityNameController = TextEditingController();
  final TextEditingController communityStatusController =
      TextEditingController();
  NewCommunityBloc()
      : super(NewCommunityState(
          topCommunities: const [],
          topCommunitiesPaginationData: PaginationData(),
        ),) {
    on<NewCommunityInitialEvent>(_onInitialEvent);
    on<LoadTopCommunitiesEvent>(_loadTopCommunities);
    on<LoadMoreTopCommunitiesEvent>(_loadMoreTopCommunities);
    on<ChangeApproveJoiningRequestEvent>(_changeApproveJoiningRequest);
    on<CreateCommunityEvent>(_createCommunity);
  }

  FutureOr<void> _onInitialEvent(
      NewCommunityInitialEvent event, Emitter<NewCommunityState> emit,) {
    add(const LoadTopCommunitiesEvent());
  }

  FutureOr<void> _loadTopCommunities(
      LoadTopCommunitiesEvent event, Emitter<NewCommunityState> emit,) async {
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
      ),);
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _loadMoreTopCommunities(LoadMoreTopCommunitiesEvent event,
      Emitter<NewCommunityState> emit,) async {
    if (state.topCommunitiesPaginationData?.isLoading == true ||
        state.topCommunitiesPaginationData?.noMoreData == true) return;
    try {
      emit(state.copyWith(
          topCommunitiesPaginationData:
              state.topCommunitiesPaginationData?.copyWith(isLoading: true),),);
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
      ),);
    } catch (e, s) {
      emit(state.copyWith(
        topCommunitiesPaginationData:
            state.topCommunitiesPaginationData?.copyWith(
          isLoading: false,
        ),
      ),);
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _changeApproveJoiningRequest(
      ChangeApproveJoiningRequestEvent event, Emitter<NewCommunityState> emit,) {
    emit(state.copyWith(
        approveJoiningRequest: !(state.approveJoiningRequest ?? false),),);
  }

  FutureOr<void> _createCommunity(
      CreateCommunityEvent event, Emitter<NewCommunityState> emit,) async {
    try {
      if (communityNameController.text.isEmpty) {
        throw BusinessException('Community name is required');
      }
      if (communityStatusController.text.isEmpty) {
        throw BusinessException('Community status is required');
      }
      if (state.approveJoiningRequest == null) {
        throw BusinessException('Approve joining request is required');
      }
      SmartDialog.showLoading(msg: 'Creating community...');
      final (String? message, int? statusCode)? response =
          await CommunityApi.createCommunity(
        post: CreateCommunityRequest(
          title: communityNameController.text,
          status: communityStatusController.text,
          adminUserUid: AuthUserDb.getLastLoggedUserUid(),
          requireJoiningApproval: state.approveJoiningRequest!,
        ),
      );
      if (response?.$2 != 200) {
        throw BusinessException(response?.$1 ?? 'Failed to create community');
      }
      communityNameController.clear();
      communityStatusController.clear();
      emit(state.copyWith(approveJoiningRequest: false));
      SmartDialog.dismiss();
      SmartDialog.showToast('${response?.$1}');
      event.onCompleted.call();
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }
}
