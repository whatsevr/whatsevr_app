part of 'dashboard_bloc.dart';

sealed class DashboardEvent extends Equatable {
  const DashboardEvent();
}

class TabChanged extends DashboardEvent {
  final Widget newView;

  const TabChanged({required this.newView});

  @override
  List<Object> get props => <Object>[newView];
}
