import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:whatsevr_app/src/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:whatsevr_app/src/features/dashboard/views/widgets/bottom_navigation.dart';
import 'package:whatsevr_app/src/features/explore/bloc/explore_bloc.dart';

import '../../account/bloc/account_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (BuildContext context) => DashboardBloc(),
        ),
        BlocProvider(
          lazy: false,
          create: (BuildContext context) =>
              ExploreBloc()..add(ExploreInitialEvent()),
        ),
        BlocProvider(
          lazy: false,
          create: (BuildContext context) =>
              AccountBloc()..add(AccountInitialEvent()),
        ),
      ],
      child: Builder(
        builder: (BuildContext context) {
          return buildPage(context);
        },
      ),
    );
  }

  Widget buildPage(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (BuildContext context, DashboardState state) {
        return Scaffold(
          body: state.currentDashboardView,
          bottomNavigationBar: const DashboardPageBottomNavigationBar(),
        );
      },
    );
  }
}
