import 'package:double_back_to_exit/double_back_to_exit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:nested/nested.dart';

import '../../explore/bloc/explore_bloc.dart';
import '../bloc/dashboard_bloc.dart';
import 'widgets/bottom_navigation.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DoubleBackToExit(
      snackBarMessage: 'Press back again to exit',
      snackbarBackgroundColor: Colors.white,
      snackbarTextStyle: const TextStyle(color: Colors.black),
      onDoubleBack: () {
        FlutterForegroundTask.minimizeApp();
        return false;
      },
      child: MultiBlocProvider(
        providers: <SingleChildWidget>[
          BlocProvider(
            lazy: false,
            create: (BuildContext context) =>
                DashboardBloc()..add(const DashboardInitialEvent()),
          ),
          BlocProvider(
            lazy: false,
            create: (BuildContext context) =>
                ExploreBloc()..add(ExploreInitialEvent()),
          ),
        ],
        child: Builder(
          builder: (BuildContext context) {
            return buildPage(context);
          },
        ),
      ),
    );
  }

  Widget buildPage(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (BuildContext context, DashboardState state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: state.currentDashboardView,
          bottomNavigationBar: const DashboardPageBottomNavigationBar(),
        );
      },
    );
  }
}
