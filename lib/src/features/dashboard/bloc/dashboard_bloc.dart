import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:whatsevr_app/config/services/permission.dart';

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
  ) {
    PermissionService.requestAllPermissions();
  }

  FutureOr<void> tabChanged(TabChanged event, Emitter<DashboardState> emit) {
    emit(state.copyWith(currentDashboardView: event.newView));
  }
}
