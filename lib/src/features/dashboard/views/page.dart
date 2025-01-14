import 'package:double_back_to_exit/double_back_to_exit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:whatsevr_app/config/global_bloc/follow_unfollow_bloc/follow_unfollow_bloc.dart';
import 'package:whatsevr_app/config/global_bloc/join_leave_community/join_leave_community_bloc.dart';
import 'package:whatsevr_app/config/global_bloc/react_unreact_bloc/react_unreact_bloc.dart';
import 'package:whatsevr_app/src/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:whatsevr_app/src/features/dashboard/views/widgets/bottom_navigation.dart';
import 'package:whatsevr_app/src/features/explore/bloc/explore_bloc.dart';
import 'package:whatsevr_app/src/features/home/bloc/home_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ReactUnreactBloc>().add(FetchReactions());
    context.read<FollowUnfollowBloc>().add(FetchFollowedUsers());
    context.read<JoinLeaveCommunityBloc>().add(FetchUserCommunities());
    return DoubleBackToExit(
      snackBarMessage: 'Press back again to exit',
      snackbarBackgroundColor: Colors.white,
      snackbarTextStyle: const TextStyle(color: Colors.black),
      onDoubleBack: () {
        FlutterForegroundTask.minimizeApp();
        return false;
      },
      child: MultiBlocProvider(
        providers: [
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
          BlocProvider(
            lazy: false,
            create: (BuildContext context) =>
                HomeBloc()..add(HomeInitialEvent()),
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
          body: state.currentDashboardView,
          bottomNavigationBar: const DashboardPageBottomNavigationBar(),
        );
      },
    );
  }
}
