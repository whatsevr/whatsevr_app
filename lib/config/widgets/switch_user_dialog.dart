import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/api/methods/users.dart';
import 'package:whatsevr_app/config/api/response_model/multiple_user_details.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/services/auth_user_service.dart';
import 'package:whatsevr_app/config/widgets/button.dart';
import 'package:whatsevr_app/config/widgets/content_mask.dart';
import 'package:whatsevr_app/config/widgets/loading_indicator.dart';
import 'package:whatsevr_app/config/widgets/showAppModalSheet.dart';

void showSwitchUserDialog() {
  showAppModalSheet(draggableScrollable: false, child: _Ui());
}

class _Ui extends StatefulWidget {
  const _Ui({super.key});

  @override
  State<_Ui> createState() => _UiState();
}

class _UiState extends State<_Ui> {
  MultipleUserDetailsResponse? multipleUserDetailsResponse;

  @override
  void initState() {
    super.initState();
    fetchOtherUsers();
  }

  void fetchOtherUsers() async {
    List<String>? allAuthUserUids =
        AuthUserService.currentUser?.allAuthUserUids;

    if (allAuthUserUids?.isEmpty ?? true) return;
    allAuthUserUids = allAuthUserUids?.toSet().toList();
    multipleUserDetailsResponse =
        await UsersApi.getMultipleUserDetails(userUids: allAuthUserUids!);
    multipleUserDetailsResponse?.users?.sort((a, b) {
      if (a.totalFollowers == null || b.totalFollowers == null) return 0;
      return b.totalFollowers!.compareTo(a.totalFollowers!);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ContentMask(
      showMask: multipleUserDetailsResponse == null,
      customMask: WhatsevrLoadingIndicator(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (multipleUserDetailsResponse?.users?.isNotEmpty ?? false) ...[
            for (User user in multipleUserDetailsResponse?.users ?? [])
              ListTile(
                onTap: () async {
                  Navigator.pop(context);
                  await AuthUserService.switchUser(user.uid);
                },
                leading: CircleAvatar(
                  backgroundImage: ExtendedNetworkImageProvider(
                      user.profilePicture ?? MockData.blankProfileAvatar),
                ),
                title: Text(user.username ?? 'Unknown User'),
                subtitle: Text('${user.totalFollowers} Followers'),
                trailing: user.uid == AuthUserService.currentUser?.userUid
                    ? const Icon(Icons.check_circle, color: Colors.black)
                    : null,
              ),
          ],
          const Gap(16),
          WhatsevrButton.outlined(
            label: 'Logout From All Accounts',
            onPressed: () {
              AuthUserService.logOutAllUser(startFomBegin: true);
            },
          ),
          WhatsevrButton.filled(
            label: 'Add New Account',
            onPressed: () {
              AuthUserService.logOutCurrentUser(startFomBegin: true);
            },
          ),
        ],
      ),
    );
  }
}
