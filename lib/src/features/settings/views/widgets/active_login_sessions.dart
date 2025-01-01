part of '../page.dart';

class _ActiveLoginSessionsPage extends StatelessWidget {
  const _ActiveLoginSessionsPage();

  @override
  Widget build(BuildContext context) {
    context.read<SettingsBloc>().add(LoadLoginSessionsEvent());
    final theme = context.whatsevrTheme;
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        final sessions = state.loginSessionsResponse?.activeLoginSessions ?? [];

        return Scaffold(
          backgroundColor: theme.background,
          appBar: WhatsevrAppBar(
            title: 'Active Sessions',
            backgroundColor: theme.appBar,
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            children: [
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: theme.primary.withOpacity(0.1),
                      borderRadius: theme.borderRadiusFull,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: theme.success,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const Gap(4),
                        Text(
                          '${sessions.length} Active Sessions',
                          style: theme.bodySmall.copyWith(
                            color: theme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Gap(8),
              if (sessions.isEmpty)
                Center(
                  child: Text(
                    'No active sessions',
                    style: theme.bodySmall.copyWith(color: theme.textLight),
                  ),
                )
              else
                ...sessions.map(
                  (session) => _buildSessionCard(
                    context,
                    deviceName: session.agentName ?? 'Unknown Device',
                    loginTime: session.createdAt ?? DateTime.now(),
                    isCurrentDevice: session.agentId ==
                        DeviceInfoService.currentDeviceInfo?.deviceId,
                    deviceType: session.agentType ?? 'Unknown',
                    sessionId: session.uid ?? '',
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSessionCard(
    BuildContext context, {
    required String deviceName,
    required DateTime loginTime,
    required bool isCurrentDevice,
    required String deviceType,
    required String sessionId,
  }) {
    final theme = context.whatsevrTheme;

    return BlocBuilder<SettingsBloc, SettingsState>(
      buildWhen: (previous, current) =>
          previous.loginSessionsResponse != current.loginSessionsResponse,
      builder: (context, state) {
        // Check if this session still exists
        final sessionExists = state.loginSessionsResponse?.activeLoginSessions
                ?.any((session) => session.uid == sessionId) ??
            false;

        if (!sessionExists && !isCurrentDevice) {
          return const SizedBox.shrink(); // Don't show logged out sessions
        }

        return Container(
          margin: const EdgeInsets.only(bottom: 8), // Reduced margin
          child: Material(
            color: theme.surface,
            borderRadius: theme.borderRadiusLarge,
            child: InkWell(
              borderRadius: theme.borderRadiusLarge,
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(10), // Reduced padding
                decoration: BoxDecoration(
                  borderRadius: theme.borderRadiusLarge,
                  border: Border.all(
                    color: isCurrentDevice ? theme.primary : theme.divider,
                    width: isCurrentDevice ? 1.5 : 0.5, // Thinner borders
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6), // Reduced padding
                          decoration: BoxDecoration(
                            color: theme.primary.withOpacity(0.1),
                            borderRadius: theme.borderRadiusLarge,
                          ),
                          child: Icon(
                            _getDeviceIcon(deviceType),
                            color: theme.primary,
                            size: 18, // Smaller icon
                          ),
                        ),
                        const Gap(8), // Reduced gap
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                deviceName,
                                style: theme.subtitle.copyWith(
                                  fontSize: 16,
                                ),
                              ),
                              const Gap(2), // Minimal gap
                              Text(
                                deviceType,
                                style: theme.bodySmall.copyWith(
                                  color: theme.textLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isCurrentDevice)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: theme.success.withOpacity(0.1),
                              borderRadius: theme.borderRadiusLarge,
                            ),
                            child: Text(
                              'Current',
                              style: theme.caption.copyWith(
                                color: theme.success,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const Gap(8), // Reduced gap
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.access_time_rounded,
                              size: 14, // Smaller icon
                              color: theme.textLight,
                            ),
                            const Gap(4), // Reduced gap
                            Text(
                              _formatDateTime(loginTime),
                              style: theme.bodySmall.copyWith(
                                color: theme.textLight,
                              ),
                            ),
                          ],
                        ),
                        if (!isCurrentDevice)
                          TextButton.icon(
                            onPressed: () =>
                                _showLogoutDialog(context, sessionId),
                            style: TextButton.styleFrom(
                              foregroundColor: theme.error,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                            ),
                            icon: const Icon(Icons.logout_rounded, size: 14),
                            label: const Text('Logout'),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  IconData _getDeviceIcon(String deviceType) {
    switch (deviceType.toLowerCase()) {
      case 'ios':
        return Icons.phone_iphone_rounded;
      case 'android':
        return Icons.phone_android_rounded;
      case 'web':
        return Icons.computer_rounded;
      default:
        return Icons.devices_rounded;
    }
  }

  void _showLogoutDialog(BuildContext context, String sessionId) {
    final theme = context.whatsevrTheme;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'Logout Device',
          style: theme.h3,
        ),
        content: Text(
          'This will terminate the session on this device. Are you sure?',
          style: theme.body,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: theme.buttonText.copyWith(
                color: theme.textLight,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              context.read<SettingsBloc>().add(LogoutDeviceEvent(sessionId));
              Navigator.pop(context);
            },
            child: Text(
              'Logout',
              style: theme.buttonText.copyWith(
                color: theme.error,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }
}
