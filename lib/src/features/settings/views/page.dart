import 'package:animate_do/animate_do.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/services/auth_user_service.dart';
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
                    trailing: Switch(
                      value: state.isBusinessPortfolio,
                      onChanged: (value) {
                        context.read<SettingsBloc>().add(
                              UpdatePrivacySettings(
                                isProfileVisible: value,
                                isActivityStatusVisible:
                                    state.isActivityStatusVisible,
                                messageRequests:
                                    state.messageRequestsPreference,
                              ),
                            );
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    decoration: BoxDecoration(
                      color: theme.surface,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: theme.shadow.withOpacity(0.02),
                          blurRadius: 6,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        dividerColor: Colors.transparent,
                      ),
                      child: ExpansionTile(
                        leading: Icon(
                          _getAvailabilityIcon(state.availabilityStatus),
                          color: _getAvailabilityColor(
                            state.availabilityStatus,
                            theme,
                          ),
                          size: 20,
                        ),
                        title: Text(
                          'Availability Status',
                          style: theme.body.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                        subtitle: Text(
                          state.availabilityStatus,
                          style: theme.bodySmall.copyWith(
                            color: theme.textLight,
                            fontSize: 13,
                          ),
                        ),
                        children: [
                          _buildAvailabilityOption(
                            context,
                            'Available',
                            Icons.check_circle_outline,
                            theme.success,
                            state,
                          ),
                          _buildAvailabilityOption(
                            context,
                            'Limited Availability',
                            Icons.access_time,
                            theme.warning,
                            state,
                          ),
                          _buildAvailabilityOption(
                            context,
                            'Away',
                            Icons.not_interested,
                            theme.error,
                            state,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SettingsTile(
                    icon: Icons.block_outlined,
                    title: 'Blocked Users',
                    subtitle: 'Manage blocked users',
                    onTap: () {
                      // Navigate to blocked users page
                    },
                  ),
                  SettingsTile(
                    icon: Icons.fingerprint,
                    title: 'Biometric Lock',
                    subtitle: 'Secure app access with biometrics',
                    trailing: Switch(
                      value: state.isBiometricEnabled,
                      onChanged: (value) {
                        context.read<SettingsBloc>().add(
                              UpdateSecuritySettings(
                                isBiometricEnabled: value,
                                isTwoFactorEnabled: state.isTwoFactorEnabled,
                              ),
                            );
                      },
                      activeColor: theme.primary,
                    ),
                  ),
                  SettingsTile(
                    title: 'Permissions',
                    onTap: () {
                      AppNavigationService.pushPage(
                        screen: BlocProvider.value(
                          value: context.read<SettingsBloc>(),
                          child: _PermissionsPage(),
                        ),
                      );
                    },
                    trailing: Icon(Icons.arrow_forward_ios_outlined),
                  )
                ],
              ),
              SettingsSection(
                title: 'Notification Preferences',
                children: [
                  SettingsTile(
                    icon: Icons.notifications_outlined,
                    title: 'Push Notifications',
                    trailing: Switch(
                      value: state.isPushNotificationsEnabled,
                      onChanged: (value) {
                        context.read<SettingsBloc>().add(
                              UpdateNotificationPreferences(
                                isPushEnabled: value,
                                isEmailEnabled:
                                    state.isEmailNotificationsEnabled,
                                isPostEnabled: state.isPostNotificationsEnabled,
                              ),
                            );
                      },
                      activeColor: theme.primary,
                    ),
                  ),
                  SettingsTile(
                    icon: Icons.mail_outline,
                    title: 'Email Notifications',
                    trailing: Switch(
                      value: state.isEmailNotificationsEnabled,
                      onChanged: (value) {
                        context.read<SettingsBloc>().add(
                              UpdateNotificationPreferences(
                                isPushEnabled: state.isPushNotificationsEnabled,
                                isEmailEnabled: value,
                                isPostEnabled: state.isPostNotificationsEnabled,
                              ),
                            );
                      },
                      activeColor: theme.primary,
                    ),
                  ),
                  for (final type in state.notificationTypes.entries)
                    SettingsTile(
                      icon: _getNotificationIcon(type.key),
                      title: _getNotificationTitle(type.key),
                      subtitle: _getNotificationSubtitle(type.key),
                      trailing: Switch(
                        value: type.value,
                        onChanged: (value) {
                          context.read<SettingsBloc>().add(
                                UpdateNotificationType(
                                  type: type.key,
                                  enabled: value,
                                ),
                              );
                        },
                        activeColor: theme.primary,
                      ),
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

  String _getNotificationSubtitle(String type) {
    switch (type) {
      case 'global':
        return 'Updates, alerts and important messages';
      case 'account':
        return 'Security and account-related notifications';
      case 'promotional':
        return 'Offers, news and promotional content';
      default:
        return '';
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

  Widget _buildAvailabilityOption(
    BuildContext context,
    String status,
    IconData icon,
    Color color,
    SettingsState state,
  ) {
    return ListTile(
      leading: Icon(icon, color: color, size: 20),
      title: Text(status),
      selected: state.availabilityStatus == status,
      onTap: () {
        context.read<SettingsBloc>().add(UpdateAvailabilityStatus(status));
      },
    );
  }

  IconData _getAvailabilityIcon(String status) {
    switch (status) {
      case 'Available':
        return Icons.check_circle_outline;
      case 'Limited Availability':
        return Icons.access_time;
      case 'Away':
        return Icons.not_interested;
      default:
        return Icons.circle_outlined;
    }
  }

  Color _getAvailabilityColor(String status, AppTheme theme) {
    switch (status) {
      case 'Available':
        return Colors.green;
      case 'Limited Availability':
        return Colors.orange;
      case 'Away':
        return Colors.red;
      default:
        return theme.primary;
    }
  }
}

IconData _getPermissionIcon(String permission) {
  switch (permission) {
    case 'camera':
      return Icons.camera_alt_outlined;
    case 'storage':
      return Icons.folder_outlined;
    case 'location':
      return Icons.location_on_outlined;
    case 'microphone':
      return Icons.mic_outlined;
    default:
      return Icons.settings;
  }
}

String _getPermissionTitle(String permission) {
  return permission.substring(0, 1).toUpperCase() + permission.substring(1);
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
              fontSize: 16, // Smaller font size
              fontWeight: FontWeight.w600,
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

  const SettingsTile({
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.icon,
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
              horizontal: 14,
              vertical: 12,
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
                  Transform.scale(
                    scale: 0.8, // Make switches smaller
                    child: trailing!,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
