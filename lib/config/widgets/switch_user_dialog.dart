import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/api/methods/users.dart';
import 'package:whatsevr_app/config/api/response_model/multiple_user_details.dart';
import 'package:whatsevr_app/config/services/auth_user_service.dart';
import 'package:whatsevr_app/config/widgets/button.dart';
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
    // allAuthUserUids?.remove(AuthUserService.currentUser?.userUid);
    if (allAuthUserUids?.isEmpty ?? true) return;
    multipleUserDetailsResponse =
        await UsersApi.getMultipleUserDetails(userUids: allAuthUserUids!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    CurrentUser? currentUser = AuthUserService.currentUser;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (currentUser != null)
            ListTile(
              onTap: () {
                Navigator.pop(context);
              },
              leading: CircleAvatar(
                backgroundImage: ExtendedNetworkImageProvider(
                    currentUser.profilePictureUrl ?? ''),
              ),
              title: Text(currentUser.userName ?? 'Unknown User'),
              subtitle: Text('Current User'),
            ),
          if (multipleUserDetailsResponse?.users?.isNotEmpty ?? false) ...[
            const Gap(16),
            const Divider(),
            const Gap(16),
            for (User user in multipleUserDetailsResponse?.users ?? [])
              ListTile(
                onTap: () async {
                  Navigator.pop(context);
                  await AuthUserService.switchUser(user.uid);
                },
                leading: CircleAvatar(
                  backgroundImage:
                      ExtendedNetworkImageProvider(user.profilePicture ?? ''),
                ),
                title: Text(user.username ?? 'Unknown User'),
                subtitle: Text('${user.totalFollowers} Followers'),
              ),
          ],
          const Gap(16),
          WhatsevrButton.filled(
            label: 'Logout From All Accounts',
            onPressed: () {
              AuthUserService.logOutCurrentUser(restartApp: true);
            },
          ),
        ],
      ),
    );
  }
}
