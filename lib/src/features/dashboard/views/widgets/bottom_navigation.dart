import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:gap/gap.dart';
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
        Icon(WhatsevrIcons.iconExplore002Svg, size: 28.sp),
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
        Icon(WhatsevrIcons.iconWhatServ001Svg, size: 28.sp),
        () {
          context.read<DashboardBloc>().add(
                TabChanged(
                  newView: HomePage(),
                ),
              );
        },
        null
      ),
      (
        Icon(WhatsevrIcons.postUploadIcon002, size: 28.sp),
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
        Icon(WhatsevrIcons.flicksIcon001, size: 28.sp),
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
        Icon(WhatsevrIcons.message, size: 28.sp),
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
        Icon(WhatsevrIcons.notificationIcon001, size: 28.sp),
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
        Icon(WhatsevrIcons.account, size: 28.sp),
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
            spreadRadius: 5.r,
            blurRadius: 7.r,
            offset: Offset(0, 3.h),
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
                  padding: EdgeInsets.all(8.0.r),
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
          //    return SizedBox(
          //   height: 48.h,
          //   child: FittedBox(
          //     child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: [
          //       for (int i = 0; i < children.length; i++) ...[
          //         children[i],
          //         if (i < children.length - 1) Gap(10.w),
          //       ],
          //     ],
          //   ),
          //   ),
          // );
          return SizedBox(
            height: 50.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return children[index];
              },
              separatorBuilder: (BuildContext context, int index) {
                return Gap(25.r);
              },
              itemCount: children.length,
            ),
          );
        },
      ),
    );
  }
}
