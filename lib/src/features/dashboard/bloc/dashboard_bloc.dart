import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../explore/views/page.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardState(currentDashboardView: ExplorePage())) {
    on<TabChanged>(tabChanged);
  }

  FutureOr<void> tabChanged(TabChanged event, Emitter<DashboardState> emit) {
    emit(state.copyWith(currentDashboardView: event.newView));
  }
}