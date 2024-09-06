part of 'dashboard_bloc.dart';

sealed class DashboardEvent extends Equatable {
  const DashboardEvent();
}

class DashboardInitialEvent extends DashboardEvent {
  DashboardInitialEvent();
  @override
  List<Object> get props => <Object>[];
}

class TabChanged extends DashboardEvent {
  final Widget newView;

  const TabChanged({required this.newView});

  @override
  List<Object> get props => <Object>[newView];
}
