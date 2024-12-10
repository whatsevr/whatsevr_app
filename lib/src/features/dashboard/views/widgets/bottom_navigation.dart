import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/game_icons.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/pepicons.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';
import 'package:whatsevr_app/config/services/auth_user_service.dart';
import 'package:whatsevr_app/config/themes/theme.dart';

import 'package:whatsevr_app/config/enums/post_creator_type.dart';
import 'package:whatsevr_app/config/widgets/dialogs/auth_dialogs.dart';
import 'package:whatsevr_app/config/widgets/dialogs/content_upload_button_sheet.dart';
import 'package:whatsevr_app/config/widgets/dialogs/showAppModalSheet.dart';
import 'package:whatsevr_app/config/widgets/whatsevr_icons.dart';
import 'package:whatsevr_app/src/features/account/views/page.dart';
import 'package:whatsevr_app/src/features/chat/chats/views/page.dart';
import 'package:whatsevr_app/src/features/explore/views/page.dart';
import 'package:whatsevr_app/src/features/flicks/views/page.dart';
import 'package:whatsevr_app/src/features/home/views/page.dart';
import 'package:whatsevr_app/src/features/notifications/views/page.dart';
import 'package:whatsevr_app/src/features/dashboard/bloc/dashboard_bloc.dart';

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
    final List<(Widget icon, VoidCallback? onTap, VoidCallback? onLongTap)>
        items = [
      (
        const Icon(WhatsevrIcons.iconExplore002Svg, size: 28),
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
        const Icon(WhatsevrIcons.iconWhatServ001Svg, size: 28),
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
        const Icon(WhatsevrIcons.postUploadIcon002, size: 28),
        () {
          final bool? isPortfolio =
              AuthUserService.supportiveData?.userInfo?.isPortfolio;
          if (isPortfolio == null) {
            SmartDialog.showToast('Please wait...');
            return;
          }
          showContentUploadBottomSheet(
            context,
            postCreatorType: isPortfolio
                ? EnumPostCreatorType.PORTFOLIO
                : EnumPostCreatorType.ACCOUNT,
          );
        },
        null
      ),
      (
        const Icon(WhatsevrIcons.flicksIcon001, size: 28),
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
        const Icon(WhatsevrIcons.message, size: 28),
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
        const Icon(WhatsevrIcons.notificationIcon001, size: 28),
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
        const Icon(WhatsevrIcons.account, size: 28),
        () {
          context.read<DashboardBloc>().add(
                TabChanged(
                  newView: AccountPage(
                    pageArgument: AccountPageArgument(
                      isEditMode: true,
                      userUid: AuthUserDb.getLastLoggedUserUid(),
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
        color: context.whatsevrTheme.surface,
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
          final List<Widget> children = <Widget>[
            for ((Widget, VoidCallback?, VoidCallback?) itm in items)
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
                  child: Theme(
                    data: ThemeData(
                      iconTheme: IconThemeData(
                        
                        color: selectedIndex == items.indexOf(itm)
                            ? context.whatsevrTheme.primary
                            : context.whatsevrTheme.disabled,
                      ),
                    ),
                    child: itm.$1,
                  ),
                ),
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
