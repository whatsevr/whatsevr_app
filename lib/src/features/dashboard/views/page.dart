import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/akar_icons.dart';
import 'package:iconify_flutter/icons/heroicons.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/pepicons.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:whatsevr_app/src/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:whatsevr_app/src/features/flicks/views/page.dart';

import '../../account/views/page.dart';
import '../../activities/views/page.dart';
import '../../chats/views/page.dart';
import '../../explore/views/page.dart';
import '../../home/views/page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardBloc(),
      child: Builder(builder: (context) {
        return buildPage(context);
      }),
    );
  }

  Widget buildPage(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return Scaffold(
          body: state.currentDashboardView,
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Builder(
              builder: (context) {
                List<Widget> children = [
                  IconButton(
                    icon: Iconify(MaterialSymbols.explore),
                    onPressed: () {
                      context.read<DashboardBloc>().add(const TabChanged(
                            newView: ExplorePage(),
                          ));
                    },
                  ),
                  IconButton(
                    icon: Iconify(Heroicons.home_solid),
                    onPressed: () {
                      context.read<DashboardBloc>().add(const TabChanged(
                            newView: HomePage(),
                          ));
                    },
                  ),
                  IconButton(
                    icon: const Iconify(Ri.heart_add_fill),
                    onPressed: () {
                      context.read<DashboardBloc>().add(const TabChanged(
                            newView: ActivitiesPage(),
                          ));
                    },
                  ),
                  IconButton(
                    icon: Iconify(Pepicons.play_print),
                    onPressed: () {
                      context.read<DashboardBloc>().add(const TabChanged(
                            newView: FlicksPage(),
                          ));
                    },
                  ),
                  IconButton(
                    icon: Iconify(Ph.chat_circle_text_fill),
                    onPressed: () {
                      context.read<DashboardBloc>().add(const TabChanged(
                            newView: ChatsPage(),
                          ));
                    },
                  ),
                  IconButton(
                    icon: Iconify(Ic.twotone_notifications_none),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Iconify(AkarIcons.settings_horizontal),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Iconify(Ic.sharp_account_circle),
                    onPressed: () {
                      context.read<DashboardBloc>().add(TabChanged(
                            newView: AccountPage(),
                          ));
                    },
                  ),
                ];
                return SizedBox(
                  height: 60,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return children[index];
                    },
                    separatorBuilder: (context, index) {
                      return Gap(10);
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
