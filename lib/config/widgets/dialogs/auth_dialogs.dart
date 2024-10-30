import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:gap/gap.dart';

import '../../../generated/assets.dart';
import '../../api/methods/auth.dart';
import '../../api/methods/users.dart';
import '../../api/requests_model/auth/register.dart';
import '../../api/response_model/multiple_user_details.dart';
import '../../mocks/mocks.dart';
import '../../routes/router.dart';
import '../../routes/routes_name.dart';
import '../../services/auth_db.dart';
import '../../services/auth_user_service.dart';
import '../buttons/button.dart';
import '../content_mask.dart';
import '../textfield/super_textform_field.dart';

class SwitchUserDialogUi extends StatefulWidget {
  const SwitchUserDialogUi({super.key});

  @override
  State<SwitchUserDialogUi> createState() => _SwitchUserDialogUiState();
}

class _SwitchUserDialogUiState extends State<SwitchUserDialogUi> {
  MultipleUserDetailsResponse? multipleUserDetailsResponse;
  String? currentUserId;
  @override
  void initState() {
    super.initState();
    fetchOtherUsers();
  }

  void fetchOtherUsers() async {
    currentUserId = AuthUserDb.getLastLoggedUserUid();
    List<String>? allAuthUserUids = AuthUserDb.getAllAuthorisedUserUid();

    if (allAuthUserUids.isEmpty) return;
    allAuthUserUids = allAuthUserUids.toSet().toList();
    multipleUserDetailsResponse =
        await UsersApi.getMultipleUserDetails(userUids: allAuthUserUids);
    multipleUserDetailsResponse?.users?.sort((a, b) {
      if (a.totalFollowers == null || b.totalFollowers == null) return 0;
      return b.totalFollowers!.compareTo(a.totalFollowers!);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ContentMask(
          showMask: multipleUserDetailsResponse == null,
          customMask: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var _ in AuthUserDb.getAllAuthorisedUserUid() ?? [])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: double.infinity,
                  child: ListTile(
                    leading: const CircleAvatar(),
                    title: const Text('XXXXXXXXXXXXXXXXXXX'),
                    subtitle: const Text('XXXXXXXXX'),
                  ),
                ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (multipleUserDetailsResponse?.users?.isNotEmpty ?? false) ...[
                for (User user in multipleUserDetailsResponse?.users ?? [])
                  ListTile(
                    onTap: () async {
                      Navigator.pop(context);
                      AuthUserService.loginToApp(
                        userUid: user.uid!,
                        mobileNumber: user.mobileNumber,
                        emailId: user.emailId,
                      );
                    },
                    leading: CircleAvatar(
                      backgroundImage: ExtendedNetworkImageProvider(
                          user.profilePicture ?? MockData.blankProfileAvatar,),
                    ),
                    title: Text(user.username ?? 'Unknown User'),
                    subtitle: Text('${user.totalFollowers} Followers'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (user.uid == currentUserId)
                          const Icon(Icons.check_circle, color: Colors.black),
                        IconButton(
                          icon: const Icon(Icons.logout),
                          onPressed: () {
                            AuthUserDb.removeAuthorisedUserUid(user.uid!);
                            if (user.uid == currentUserId) {
                              Navigator.pop(context);
                              AuthUserDb.clearLastLoggedUserUid();
                              AppNavigationService.clearAllAndNewRoute(
                                  RoutesName.auth,);
                            } else {
                              setState(() {
                                final int index = multipleUserDetailsResponse!.users!
                                    .indexWhere(
                                        (element) => element.uid == user.uid,);
                                multipleUserDetailsResponse!.users!
                                    .removeAt(index);
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
              ],
              if ((multipleUserDetailsResponse?.users?.length ?? 0) > 1) ...[
                const Gap(16),
                WhatsevrButton.outlined(
                  label: 'Logout From All Accounts',
                  onPressed: () {
                    Navigator.pop(context);
                    AuthUserService.logOutAllUser(startFomBegin: true);
                  },
                ),
              ],
            ],
          ),
        ),
        WhatsevrButton.filled(
          label: 'Add New Account',
          onPressed: () {
            AuthUserService.loginWithOtpLessService(
              onLoginSuccess: (userUid, mobileNumber, emailId) {
                Navigator.pop(context);
                AuthUserService.loginToApp(
                  userUid: userUid,
                  mobileNumber: mobileNumber,
                  emailId: emailId,
                );
              },
              onLoginFailed: (errorMessage) {
                SmartDialog.showToast(errorMessage);
              },
            );
          },
        ),
        Gap(50),
      ],
    );
  }
}

class CreateAccountUi extends StatelessWidget {
  final String userUid;
  final String? mobileNumber;
  final String? emailId;
  CreateAccountUi({
    super.key,
    required this.userUid,
    this.mobileNumber,
    this.emailId,
  });
  final TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Gap(25),
        ExtendedImage.asset(
          Assets.imagesWhatsevrAppLogo,
          width: 100,
          height: 100,
          shape: BoxShape.circle,
        ),
        const Gap(25),
        const Text(
          'Create Account',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(25),
        if (mobileNumber != null) ...[
          const Gap(8),
          WhatsevrFormField.generalTextField(
            controller: TextEditingController(text: mobileNumber),
            headingTitle: 'Mobile Number',
            readOnly: true,
          ),
        ],
        if (emailId != null) ...[
          const Gap(8),
          WhatsevrFormField.generalTextField(
            controller: TextEditingController(text: emailId),
            headingTitle: 'Email',
            readOnly: true,
          ),
        ],
        const Gap(12),
        WhatsevrFormField.generalTextField(
          controller: nameController,
          headingTitle: 'Enter you name',
          maxLength: 50,
          keyboardType: TextInputType.name,
        ),
        const Gap(16),
        WhatsevrButton.filled(
          label: 'Continue',
          onPressed: () async {
            if (nameController.text.isEmpty) {
              SmartDialog.showToast('Name is required');
              return;
            }
            SmartDialog.showLoading(msg: 'Creating Account');
            (String?, int?)? registerInfo = await AuthApi.register(
              UserRegistrationRequest(
                userUid: userUid,
                mobileNumber: mobileNumber,
                emailId: emailId,
                name: nameController.text,
              ),
            );
            if (registerInfo?.$2 != HttpStatus.ok) {
              SmartDialog.showToast(
                  registerInfo?.$1 ?? 'Failed to create account',);
              return;
            }
            AuthUserService.loginToApp(
              userUid: userUid,
              mobileNumber: mobileNumber,
              emailId: emailId,
            );
          },
        ),
        const Gap(16),
      ],
    );
  }
}

class AccountBannedUi extends StatelessWidget {
  final String userUid;
  final String? mobileNumber;
  final String? emailId;
  const AccountBannedUi({
    super.key,
    required this.userUid,
    this.mobileNumber,
    this.emailId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Account is banned'),
        if (mobileNumber != null) ...[
          const Gap(8),
          Text('Mobile Number: $mobileNumber'),
        ],
        if (emailId != null) ...[
          const Gap(8),
          Text('Email: $emailId'),
        ],
        const Gap(16),
        WhatsevrButton.filled(
          label: 'Contact Support',
          onPressed: () {
            AppNavigationService.goBack();
          },
        ),
        const Gap(16),
      ],
    );
  }
}

class AccountIsDeactivatedStateUi extends StatelessWidget {
  final String userUid;
  final String? mobileNumber;
  final String? emailId;
  const AccountIsDeactivatedStateUi({
    super.key,
    required this.userUid,
    this.mobileNumber,
    this.emailId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Account is in deactivated state'),
        if (mobileNumber != null) ...[
          const Gap(8),
          Text('Mobile Number: $mobileNumber'),
        ],
        if (emailId != null) ...[
          const Gap(8),
          Text('Email: $emailId'),
        ],
        const Gap(16),
        WhatsevrButton.filled(
          label: 'Contact Support',
          onPressed: () {
            AppNavigationService.goBack();
          },
        ),
        const Gap(16),
      ],
    );
  }
}
