import 'package:animate_do/animate_do.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';
import 'package:whatsevr_app/config/services/auth_user_service.dart';
import 'package:whatsevr_app/config/services/device_info.dart';
import 'package:whatsevr_app/config/services/permission.dart';
import 'package:whatsevr_app/config/themes/theme.dart';
import 'package:whatsevr_app/config/widgets/whatsevr_icons.dart';
import 'package:whatsevr_app/src/features/community/views/page.dart';

import 'package:whatsevr_app/config/api/response_model/community/user_communities.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/routes/routes_name.dart';
import 'package:whatsevr_app/config/widgets/app_bar.dart';
import 'package:whatsevr_app/src/features/new_community/views/page.dart';
import 'package:whatsevr_app/src/features/settings/views/bloc/settings_bloc.dart';
import 'package:whatsevr_app/src/features/update_user_profile/views/page.dart';

part 'package:whatsevr_app/src/features/settings/views/widgets/my_communities.dart';
part 'package:whatsevr_app/src/features/settings/views/widgets/permissions.dart';
part 'package:whatsevr_app/src/features/settings/views/widgets/active_login_sessions.dart';
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
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        final theme = context.whatsevrTheme;
        return Scaffold(
          appBar: WhatsevrAppBar(
            title: 'Settings',
            backgroundColor: theme.appBar,
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            children: [
              const Gap(4),
              _buildProfileCard(context),
              _YourCommunities(),
              SettingsSection(
                title: 'Account & Privacy',
                children: [
                  SettingsTile(
                    icon: Icons.lock_outline,
                    title: 'Business Portfolio',
                    subtitle: 'Grow your business and professional services',
                    onTap: () {
                      AppNavigationService.pushPage(
                        screen: BlocProvider.value(
                          value: context.read<SettingsBloc>(),
                          child: _PermissionsPage(),
                        ),
                      );
                    },
                  ),
                  SettingsTile(
                    icon: Icons.block_outlined,
                    title: 'Blocked Users',
                    onTap: () {
                      AppNavigationService.pushPage(
                        screen: BlocProvider.value(
                          value: context.read<SettingsBloc>(),
                          child: _PermissionsPage(),
                        ),
                      );
                    },
                  ),
                  SettingsTile(
                    icon: Icons.fingerprint,
                    title: 'Biometric Lock',
                    onTap: () {
                      AppNavigationService.pushPage(
                        screen: BlocProvider.value(
                          value: context.read<SettingsBloc>(),
                          child: _PermissionsPage(),
                        ),
                      );
                    },
                  ),
                  SettingsTile(
                    icon: Icons.login,
                    title: 'Active Login Sessions',
                    onTap: () {
                      AppNavigationService.pushPage(
                        screen: BlocProvider.value(
                          value: context.read<SettingsBloc>(),
                          child: const _ActiveLoginSessionsPage(),
                        ),
                      ); 
                    },
                  ),
                  SettingsTile(
                    title: 'Device Permissions',
                    icon: Icons.mobile_friendly,
                    onTap: () {
                      AppNavigationService.pushPage(
                        screen: BlocProvider.value(
                          value: context.read<SettingsBloc>(),
                          child: _PermissionsPage(),
                        ),
                      );
                    },
                  )
                ],
              ),
              SettingsSection(
                title: 'Activity Alerts',
                children: [
                  for (final type in state.notificationTypes.entries)
                    SettingsTile(
                      icon: _getNotificationIcon(type.key),
                      title: _getNotificationTitle(type.key),
                      onTap: () {
                        AppNavigationService.pushPage(
                          screen: BlocProvider.value(
                            value: context.read<SettingsBloc>(),
                            child: _PermissionsPage(),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case 'global':
        return Icons.notifications_outlined;
      case 'account':
        return Icons.person_outline;
      case 'promotional':
        return Icons.campaign_outlined;
      default:
        return Icons.notifications_outlined;
    }
  }

  String _getNotificationTitle(String type) {
    switch (type) {
      case 'global':
        return 'Global Notifications';
      case 'account':
        return 'Account Notifications';
      case 'promotional':
        return 'Promotional Notifications';
      default:
        return type;
    }
  }

  Widget _buildProfileCard(BuildContext context) {
    final theme = context.whatsevrTheme;
    final user = AuthUserService.supportiveData?.userInfo;
    return Container(
      margin: const EdgeInsets.only(bottom: 12), // Reduced margin
      padding: const EdgeInsets.all(12), // Reduced padding
      decoration: BoxDecoration(
        color: theme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: theme.shadow.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          AdvancedAvatar(
            size: 50, // Slightly smaller avatar
            image: ExtendedImage.network(
              user?.profilePicture ?? MockData.blankProfileAvatar,
              cache: true,
            ).image,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: theme.primary,
            ),
          ),
          const Gap(12), // Reduced gap
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user?.name}',
                  style: theme.subtitle,
                ),
                const Gap(4),
                Text(
                  '@${user?.username}',
                  style: theme.bodySmall.copyWith(color: theme.textLight),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(WhatsevrIcons.editPencil02, color: theme.primary),
            onPressed: () {
              AppNavigationService.newRoute(
                RoutesName.updateUserProfile,
                extras: UserProfileUpdatePageArgument(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const SettingsSection({
    required this.title,
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.whatsevrTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 4,
          ), // Reduced padding
          child: Text(
            title,
            style: theme.subtitle.copyWith(
              fontSize: 12, // Smaller font size
            ),
          ),
        ),
        ...children,
        const Gap(4), // Reduced gap
      ],
    );
  }
}

class SettingsTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final IconData? icon;
  final bool showTrailingArrow;
  const SettingsTile({
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.icon,
    this.showTrailingArrow = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.whatsevrTheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 6), // Reduced margin
      decoration: BoxDecoration(
        color: theme.surface,
        borderRadius: BorderRadius.circular(10), // Slightly reduced radius
        boxShadow: [
          BoxShadow(
            color: theme.shadow.withOpacity(0.02),
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ), // Adjusted padding
            child: Row(
              children: [
                if (icon != null) ...[
                  Icon(icon, color: theme.primary, size: 20), // Smaller icon
                  const Gap(12), // Reduced gap
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.body.copyWith(
                          fontWeight:
                              FontWeight.w500, // Slightly reduced weight
                          fontSize: 15, // Smaller font size
                        ),
                      ),
                      if (subtitle != null) ...[
                        const Gap(2), // Reduced gap
                        Text(
                          subtitle!,
                          style: theme.bodySmall.copyWith(
                            color: theme.textLight,
                            fontSize: 13, // Smaller font size
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (trailing != null)
                trailing!,
                    if (showTrailingArrow) ...[
                      const Gap(12), // Reduced gap
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 14,
                      ),
                    ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
