import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/akar_icons.dart';
import 'package:iconify_flutter/icons/fa6_solid.dart';
import 'package:iconify_flutter/icons/game_icons.dart';
import 'package:iconify_flutter/icons/heroicons.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/pepicons.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:whatsevr_app/src/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:whatsevr_app/src/features/flicks/views/page.dart';
import 'package:whatsevr_app/src/features/notifications/views/page.dart';

import '../../../../../config/mocks/mocks.dart';
import '../../../../../config/widgets/content_upload_button_sheet.dart';
import '../../../account/views/page.dart';
import '../../../chats/views/page.dart';
import '../../../explore/views/page.dart';
import '../../../home/views/page.dart';

class DashboardPageBottomNavigationBar extends StatelessWidget {
  const DashboardPageBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            for ((Widget, VoidCallback) itm in _navigationItems(context))
              IconButton(
                icon: itm.$1,
                onPressed: itm.$2,
              ),
          ];
          return SizedBox(
            height: 45,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return children[index];
              },
              separatorBuilder: (context, index) {
                return const Gap(10);
              },
              itemCount: children.length,
            ),
          );
        },
      ),
    );
  }
}

List<(Widget, VoidCallback)> _navigationItems(BuildContext context) {
  return [
    (
      Iconify(
        MaterialSymbols.explore,
        size: 30,
      ),
      () {
        context.read<DashboardBloc>().add(const TabChanged(
              newView: ExplorePage(),
            ));
      },
    ),
    (
      Iconify(
        GameIcons.nest_eggs,
        size: 30,
      ),
      () {
        context.read<DashboardBloc>().add(const TabChanged(
              newView: HomePage(),
            ));
      },
    ),
    (
      Iconify(
        Ri.heart_add_fill,
        size: 30,
      ),
      () {
        showContentUploadBottomSheet(context);
      },
    ),
    (
      Iconify(
        Pepicons.play_print,
        size: 30,
      ),
      () {
        context.read<DashboardBloc>().add(const TabChanged(
              newView: FlicksPage(),
            ));
      },
    ),
    (
      Iconify(
        Ph.chat_circle_text_fill,
        size: 30,
      ),
      () {
        context.read<DashboardBloc>().add(const TabChanged(
              newView: ChatsPage(),
            ));
      },
    ),
    (
      Iconify(
        Ic.twotone_notifications_none,
        size: 30,
      ),
      () {
        context.read<DashboardBloc>().add(const TabChanged(
              newView: NotificationsPage(),
            ));
      },
    ),
    (
      Iconify(
        Ic.sharp_account_circle,
        size: 30,
      ),
      () {
        context.read<DashboardBloc>().add(TabChanged(
              newView: AccountPage(),
            ));
      },
    ),
  ];
}