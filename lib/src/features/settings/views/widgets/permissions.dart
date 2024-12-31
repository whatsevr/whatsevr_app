part of 'package:whatsevr_app/src/features/settings/views/page.dart';

class _PermissionsPage extends StatefulWidget {
  const _PermissionsPage({super.key});

  @override
  State<_PermissionsPage> createState() => _PermissionsPageState();
}

class _PermissionsPageState extends State<_PermissionsPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    setState(() => _isLoading = true);
    final permissions = await PermissionService.checkPermissionStatuses();
    if (!mounted) return;

    context.read<SettingsBloc>().add(
          UpdatePermissionsStatus(permissions: permissions),
        );
    setState(() => _isLoading = false);
  }

  Future<void> _handlePermissionRequest(Permission permission) async {
    final status = await PermissionService.requestPermission(permission);
    if (!mounted) return;

    if (!status) {
      final isPermanentlyDenied = await permission.isPermanentlyDenied;
      if (isPermanentlyDenied && mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Permission Required'),
            content: Text(
                'Please enable ${PermissionService.permissionNames[permission]} permission from settings to use this feature.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  PermissionService.openSettings();
                },
                child: const Text('Open Settings'),
              ),
            ],
          ),
        );
      }
    }
    _checkPermissions();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.whatsevrTheme;
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: WhatsevrAppBar(title: 'Permissions'),
          body: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  children: [
                    for (final permission
                        in PermissionService.permissionNames.entries)
                      SettingsTile(
                        title: permission.value,
                        onTap: () async {
                          final isGranted =
                              state.permissions[permission.key.toString()] ??
                                  false;
                          if (!isGranted) {
                            await _handlePermissionRequest(permission.key);
                          } else {
                            PermissionService.openSettings();
                          }
                        },
                        trailing: Text(
                          state.permissions[permission.key.toString()] ?? false
                              ? 'Allowed'
                              : 'Not allowed',
                          style: TextStyle(
                            color:
                                state.permissions[permission.key.toString()] ??
                                        false
                                    ? theme.primary
                                    : Colors.grey,
                          ),
                        ),
                      ),
                  ],
                ),
        );
      },
    );
  }
}
