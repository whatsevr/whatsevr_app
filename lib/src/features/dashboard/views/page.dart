import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

import 'package:iconify_flutter/icons/heroicons.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/pepicons.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:whatsevr_app/src/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:whatsevr_app/src/features/explore/bloc/explore_bloc.dart';
import 'package:whatsevr_app/src/features/flicks/views/page.dart';
import 'package:whatsevr_app/src/features/notifications/views/page.dart';

import 'package:whatsevr_app/config/widgets/content_upload_button_sheet.dart';
import 'package:whatsevr_app/src/features/account/views/page.dart';
import 'package:whatsevr_app/src/features/chats/views/page.dart';
import 'package:whatsevr_app/src/features/explore/views/page.dart';
import 'package:whatsevr_app/src/features/home/views/page.dart';
import 'package:iconify_flutter/icons/game_icons.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => DashboardBloc(),
        ),
        BlocProvider(
          create: (context) => ExploreBloc()..add(ExploreInitialEvent()),
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
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Builder(
              builder: (BuildContext context) {
                List<Widget> children = <Widget>[
                  IconButton(
                    icon: const Iconify(
                      MaterialSymbols.explore,
                      size: 30,
                    ),
                    onPressed: () {
                      context.read<DashboardBloc>().add(
                            const TabChanged(
                              newView: ExplorePage(),
                            ),
                          );
                    },
                  ),
                  IconButton(
                    icon: Iconify(
                      GameIcons.nest_eggs,
                      size: 30,
                    ),
                    onPressed: () {
                      context.read<DashboardBloc>().add(
                            const TabChanged(
                              newView: HomePage(),
                            ),
                          );
                    },
                  ),
                  IconButton(
                    icon: const Iconify(
                      Ri.heart_add_fill,
                      size: 30,
                    ),
                    onPressed: () {
                      showContentUploadBottomSheet(context);
                    },
                  ),
                  IconButton(
                    icon: const Iconify(
                      Pepicons.play_print,
                      size: 30,
                    ),
                    onPressed: () {
                      context.read<DashboardBloc>().add(
                            const TabChanged(
                              newView: FlicksPage(),
                            ),
                          );
                    },
                  ),
                  IconButton(
                    icon: const Iconify(
                      Ph.chat_circle_text_fill,
                      size: 30,
                    ),
                    onPressed: () {
                      context.read<DashboardBloc>().add(
                            const TabChanged(
                              newView: ChatsPage(),
                            ),
                          );
                    },
                  ),
                  IconButton(
                    icon: const Iconify(
                      Ic.twotone_notifications_none,
                      size: 30,
                    ),
                    onPressed: () {
                      context.read<DashboardBloc>().add(
                            const TabChanged(
                              newView: NotificationsPage(),
                            ),
                          );
                    },
                  ),
                  IconButton(
                    icon: const Iconify(
                      Ic.sharp_account_circle,
                      size: 30,
                    ),
                    onPressed: () {
                      context.read<DashboardBloc>().add(
                            TabChanged(
                              newView: AccountPage(),
                            ),
                          );
                    },
                  ),
                ];
                return SizedBox(
                  height: 45,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return children[index];
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Gap(10);
                    },
                    itemCount: children.length,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
