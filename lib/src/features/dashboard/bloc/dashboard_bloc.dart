import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import 'package:whatsevr_app/config/api/methods/common_data.dart';
import 'package:whatsevr_app/config/api/methods/recommendations.dart';
import 'package:whatsevr_app/config/api/methods/users.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';
import 'package:whatsevr_app/config/services/permission.dart';

import 'package:whatsevr_app/src/features/explore/views/page.dart';

import '../../../../main.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardState(currentDashboardView: ExplorePage())) {
    on<DashboardInitialEvent>(_onInitialEvent);
    on<TabChanged>(tabChanged);
  }
  FutureOr<void> _onInitialEvent(
    DashboardInitialEvent event,
    Emitter<DashboardState> emit,
  ) async {
    await PermissionService.requestAllPermissions();
    afterLoginServices();
    _preloadApiIntoCache();
  }

  FutureOr<void> tabChanged(TabChanged event, Emitter<DashboardState> emit) {
    emit(state.copyWith(currentDashboardView: event.newView));
  }

  void _preloadApiIntoCache() async {
    try {
      final userUid = await AuthUserDb.getLastLoggedUserUid();

      // Fetch some data from the API and cache it
      await Future.wait([
        CommonDataApi.getAllCommonData(),
        RecommendationApi.publicVideoPosts(page: 1),
        RecommendationApi.publicVideoPosts(page: 2),
        RecommendationApi.publicVideoPosts(page: 3),
        RecommendationApi.publicFlickPosts(page: 1),
        RecommendationApi.publicFlickPosts(page: 2),
        RecommendationApi.publicFlickPosts(page: 3),
        UsersApi.getProfileDetails(userUid: userUid!),
      ]);

      // Optional: Perform further operations after the preloading
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
  }
}
