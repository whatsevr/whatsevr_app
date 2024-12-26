import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import 'package:whatsevr_app/config/api/methods/common_data.dart';
import 'package:whatsevr_app/config/api/methods/public_recommendations.dart';
import 'package:whatsevr_app/config/api/methods/users.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';
import 'package:whatsevr_app/main.dart';
import 'package:whatsevr_app/src/features/explore/views/page.dart';

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
    afterLoginServices();
    _preloadApiIntoCache();
  }

  FutureOr<void> tabChanged(TabChanged event, Emitter<DashboardState> emit) {
    emit(state.copyWith(currentDashboardView: event.newView));
  }

  void _preloadApiIntoCache() async {
    try {
      final userUid = AuthUserDb.getLastLoggedUserUid();

      // Fetch some data from the API and cache it
      await Future.wait([
        CommonDataApi.getAllCommonData(),
        PublicRecommendationApi.getVideoPosts(page: 1),
        PublicRecommendationApi.getVideoPosts(page: 2),
        PublicRecommendationApi.getVideoPosts(page: 3),
        PublicRecommendationApi.getFlickPosts(page: 1),
        PublicRecommendationApi.getFlickPosts(page: 2),
        PublicRecommendationApi.getFlickPosts(page: 3),
        PublicRecommendationApi.getOffers(page: 1),
        PublicRecommendationApi.getOffers(page: 2),
        PublicRecommendationApi.getOffers(page: 3),
        PublicRecommendationApi.getPhotoPosts(page: 1),
        PublicRecommendationApi.getPhotoPosts(page: 2),
        PublicRecommendationApi.getPhotoPosts(page: 3),
        PublicRecommendationApi.getMemories(page: 1),
        PublicRecommendationApi.getMemories(page: 2),
        PublicRecommendationApi.getMemories(page: 3),
        UsersApi.getProfileDetails(userUid: userUid!),
      ]);

      // Optional: Perform further operations after the preloading
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
  }
}
