import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/api/methods/users.dart';
import 'package:whatsevr_app/config/api/response_model/multiple_user_details.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';
import 'package:whatsevr_app/config/services/auth_user_service.dart';
import 'package:whatsevr_app/config/widgets/button.dart';
import 'package:whatsevr_app/config/widgets/content_mask.dart';
import 'package:whatsevr_app/config/widgets/loading_indicator.dart';
import 'package:whatsevr_app/config/widgets/showAppModalSheet.dart';
import 'package:whatsevr_app/config/widgets/super_textform_field.dart';
import 'package:whatsevr_app/generated/assets.dart';

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
                  AuthUserService.loginToApp(
                    userUid: user.uid!,
                    mobileNumber: user.mobileNumber,
                    emailId: user.emailId,
                  );
                },
                leading: CircleAvatar(
                  backgroundImage: ExtendedNetworkImageProvider(
                      user.profilePicture ?? MockData.blankProfileAvatar),
                ),
                title: Text(user.username ?? 'Unknown User'),
                subtitle: Text('${user.totalFollowers} Followers'),
                trailing: user.uid == currentUserId
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
              AuthUserService.loginWithOtpLessService(
                onLoginSuccess: (userUid, mobileNumber, emailId) {
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
      ),
    );
  }
}

class AccountDoestNotExistUi extends StatelessWidget {
  final String userUid;
  final String? mobileNumber;
  final String? emailId;
  const AccountDoestNotExistUi({
    super.key,
    required this.userUid,
    this.mobileNumber,
    this.emailId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Account does not exist with',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        if (mobileNumber != null) ...[
          const Gap(8),
          Text('$mobileNumber'),
        ],
        if (emailId != null) ...[
          const Gap(8),
          Text('$emailId'),
        ],
        const Gap(16),
        WhatsevrButton.filled(
          label: 'Create Account',
          onPressed: () {
            AppNavigationService.goBack();
            showAppModalSheet(
                child: CreateAccountUi(
              userUid: userUid,
              mobileNumber: mobileNumber,
              emailId: emailId,
            ));
          },
        ),
        const Gap(8),
        WhatsevrButton.outlined(
          label: 'Login With Different Account',
          onPressed: () {},
        ),
      ],
    );
  }
}

class CreateAccountUi extends StatelessWidget {
  final String userUid;
  final String? mobileNumber;
  final String? emailId;
  const CreateAccountUi({
    super.key,
    required this.userUid,
    this.mobileNumber,
    this.emailId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExtendedImage.asset(
          Assets.imagesWhatsevrAppLogo,
          width: 100,
          height: 100,
          shape: BoxShape.circle,
        ),
        const Gap(8),
        if (mobileNumber != null) ...[
          const Gap(8),
          WhatsevrFormField.generalTextField(
            controller: TextEditingController(text: mobileNumber),
            headingTitle: 'Mobile Number',
            readOnly: true,
            maxLines: 1,
          ),
        ],
        if (emailId != null) ...[
          const Gap(8),
          WhatsevrFormField.generalTextField(
            controller: TextEditingController(text: emailId),
            headingTitle: 'Email',
            readOnly: true,
            maxLines: 1,
          ),
        ],
        const Gap(12),
        WhatsevrFormField.generalTextField(
          headingTitle: 'Enter you name',
          maxLength: 50,
          maxLines: 1,
          keyboardType: TextInputType.name,
        ),
        const Gap(16),
        WhatsevrButton.filled(
          label: 'Create Account',
          onPressed: () {
            AppNavigationService.goBack();
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
        WhatsevrButton.outlined(
          label: 'Login With Different Account',
          onPressed: () {},
        ),
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
        WhatsevrButton.outlined(
          label: 'Login With Different Account',
          onPressed: () {},
        ),
      ],
    );
  }
}
