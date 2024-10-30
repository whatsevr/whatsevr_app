import 'package:animate_do/animate_do.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../config/api/response_model/community/user_communities.dart';
import '../../../../config/mocks/mocks.dart';
import '../../../../config/routes/router.dart';
import '../../../../config/routes/routes_name.dart';
import '../../../../config/widgets/app_bar.dart';
import '../../../../config/widgets/pad_horizontal.dart';
import '../../new_community/views/page.dart';
import 'bloc/settings_bloc.dart';

part 'package:whatsevr_app/src/features/settings/views/widgets/my_communities.dart';

class SettingsPageArgument {
  const SettingsPageArgument();
}

class SettingsPage extends StatelessWidget {
  final SettingsPageArgument pageArgument;
  const SettingsPage({super.key, required this.pageArgument});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SettingsBloc()..add(InitialEvent()),
      child: buildPage(context),
    );
  }

  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: const WhatsevrAppBar(
        title: 'Settings',
      ),
      body: PadHorizontal(
        child: ListView(
          children: <Widget>[
            const Gap(8),
            _YourCommunities(),
            const Gap(8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Expanded(
                        child: Text(
                          'Show rating when someone views your profile',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Switch(
                        value: true,
                        onChanged: (bool value) {},
                      ),
                    ],
                  ),
                  const Gap(8),
                  const Text(
                    'This will show a rating when someone views your profile.',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(8),
            const Text(
              'Device Permissions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(8),
            Builder(
              builder: (BuildContext context) {
                final List<Widget> children = <Widget>[
                  for (int i = 0; i < 5; i++)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              const Text(
                                'Camera',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              Switch(
                                value: true,
                                onChanged: (bool value) {},
                              ),
                            ],
                          ),
                          const Gap(8),
                          const Text(
                            'Allow Whatsevr to access your camera to take photos and record videos.',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                ];
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: children.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const Gap(8),
                  itemBuilder: (BuildContext context, int index) =>
                      children[index],
                );
              },
            ),
            const Gap(16),
            const Text(
              'For Professionals',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Professional Mode',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(8),
                  Text(
                    'Enable professional mode to access advanced features.',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(16),
            const Text(
              'Support',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Contact Us',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(8),
                  Text(
                    'If you have any questions or need help, please contact us',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'About Us',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(8),
                  Text(
                    'If you have any questions or need help, please contact us',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(16),
            const Text(
              'Accounts in this Device',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Add Account',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(8),
                  Text(
                    'Add another account to this device',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Log Out',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Log Out of All Accounts',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
