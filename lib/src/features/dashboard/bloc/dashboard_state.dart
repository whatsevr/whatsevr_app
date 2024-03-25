part of 'dashboard_bloc.dart';

class DashboardState extends Equatable {
  final Widget currentDashboardView;
  const DashboardState({required this.currentDashboardView});

  DashboardState copyWith({
    Widget? currentDashboardView,
  }) {
    return DashboardState(
      currentDashboardView: currentDashboardView ?? this.currentDashboardView,
    );
  }

  @override
  List<Object> get props => [currentDashboardView];
}
