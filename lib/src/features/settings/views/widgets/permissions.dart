part of 'package:whatsevr_app/src/features/settings/views/page.dart';

class _PermissionsPage extends StatelessWidget {
  const _PermissionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.whatsevrTheme;
    return BlocBuilder<SettingsBloc, SettingsState>
    (
      builder: (context, state) {
        return Scaffold(
          appBar: WhatsevrAppBar(title: 'Permissions'),
          body: Column(
            children: [
              for (final permission in state.permissions.entries)
                SettingsTile(
                  icon: _getPermissionIcon(permission.key),
                  title: _getPermissionTitle(permission.key),
                  subtitle: 'Allow access to ${permission.key}',
                  trailing: Switch(
                    value: permission.value,
                    onChanged: (value) {
                      context.read<SettingsBloc>().add(
                            UpdatePermission(
                              permission: permission.key,
                              isEnabled: value,
                            ),
                          );
                    },
                    activeColor: theme.primary,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
