import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/game_icons.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/pepicons.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:whatsevr_app/config/widgets/dialogs/auth_dialogs.dart';
import 'package:whatsevr_app/config/widgets/dialogs/showAppModalSheet.dart';
import 'package:whatsevr_app/src/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:whatsevr_app/src/features/flicks/views/page.dart';
import 'package:whatsevr_app/src/features/notifications/views/page.dart';

import 'package:whatsevr_app/config/widgets/dialogs/content_upload_button_sheet.dart';
import 'package:whatsevr_app/src/features/account/views/page.dart';
import 'package:whatsevr_app/src/features/chats/views/page.dart';
import 'package:whatsevr_app/src/features/explore/views/page.dart';
import 'package:whatsevr_app/src/features/home/views/page.dart';

import 'package:whatsevr_app/config/enums/post_creator_type.dart';

class DashboardPageBottomNavigationBar extends StatefulWidget {
  const DashboardPageBottomNavigationBar({
    super.key,
  });

  @override
  State<DashboardPageBottomNavigationBar> createState() =>
      _DashboardPageBottomNavigationBarState();
}

class _DashboardPageBottomNavigationBarState
    extends State<DashboardPageBottomNavigationBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<(Widget icon, VoidCallback? onTap, VoidCallback? onLongTap)> items = [
      (
        const Iconify(MaterialSymbols.explore, size: 30),
        () {
          context.read<DashboardBloc>().add(
                TabChanged(
                  newView: ExplorePage(),
                ),
              );
        },
        null
      ),
      (
        const Iconify(GameIcons.nest_eggs, size: 30),
        () {
          context.read<DashboardBloc>().add(
                const TabChanged(
                  newView: HomePage(),
                ),
              );
        },
        null
      ),
      (
        const Iconify(Ri.heart_add_fill, size: 30),
        () {
          showContentUploadBottomSheet(
            context,
            postCreatorType: EnumPostCreatorType.ACCOUNT,
          );
        },
        null
      ),
      (
        const Iconify(Pepicons.play_print, size: 30),
        () {
          context.read<DashboardBloc>().add(
                TabChanged(
                  newView: FlicksPage(),
                ),
              );
        },
        null
      ),
      (
        const Iconify(Ph.chat_circle_text_fill, size: 30),
        () {
          context.read<DashboardBloc>().add(
                const TabChanged(
                  newView: ChatsPage(),
                ),
              );
        },
        null
      ),
      (
        const Iconify(Ic.twotone_notifications_none, size: 30),
        () {
          context.read<DashboardBloc>().add(
                const TabChanged(
                  newView: NotificationsPage(),
                ),
              );
        },
        null
      ),
      (
        const Iconify(Ic.sharp_account_circle, size: 30),
        () {
          context.read<DashboardBloc>().add(
                TabChanged(
                  newView: AccountPage(
                    pageArgument: AccountPageArgument(
                      isEditMode: true,
                    ),
                  ),
                ),
              );
        },
        () {
          showAppModalSheet(flexibleSheet: false, child: SwitchUserDialogUi());
        },
      ),
    ];
    return Container(
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
            for ((Widget, VoidCallback?, VoidCallback?) itm in items)
              Stack(
                alignment: Alignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      itm.$2?.call();
                      setState(() {
                        selectedIndex = items.indexOf(itm);
                      });
                    },
                    onLongPress: itm.$3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: itm.$1,
                    ),
                  ),
                  if (selectedIndex == items.indexOf(itm))
                    const Positioned(
                      bottom: 0,
                      child: Icon(
                        Icons.circle,
                        color: Colors.black,
                        size: 8,
                      ),
                    ),
                ],
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
    );
  }
}
