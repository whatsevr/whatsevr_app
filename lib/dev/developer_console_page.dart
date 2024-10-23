import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';

import 'package:whatsevr_app/config/services/auth_user_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../config/routes/router.dart';
import '../config/routes/routes_name.dart';
import '../config/services/device_info.dart';

class DeveloperConsolePage extends StatefulWidget {
  const DeveloperConsolePage({super.key});

  @override
  State<DeveloperConsolePage> createState() => _DeveloperConsolePageState();
}

class _DeveloperConsolePageState extends State<DeveloperConsolePage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Developer Console'),
        backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            _buildActionsCard(),
            const SizedBox(height: 8),
            _buildDeviceInfoCard(),
            const SizedBox(height: 8),
            _buildLoggedUserInfoCard(),
            const SizedBox(height: 8),
            _buildAllAuthorizedUsersCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceInfoCard() {
    return Card(
      color: Colors.red,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          ListTile(
            leading:
                Icon(FontAwesomeIcons.mobileAlt, color: Colors.blue, size: 20),
            title: Text('Device Information',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14)),
          ),
          for ((String, String) itm in <(String, String)>[
            (
              'Device Name',
              DeviceInfoService.currentDeviceInfo?.deviceName ?? 'Unknown'
            ),
            (
              'Country Code',
              DeviceInfoService.currentDeviceInfo?.countryCode ?? 'Unknown'
            ),
            (
              'Device Type',
              DeviceInfoService.currentDeviceInfo?.isAndroid ?? false
                  ? 'Android'
                  : DeviceInfoService.currentDeviceInfo?.isIos ?? false
                      ? 'iOS'
                      : 'Unknown',
            ),
          ])
            ListTile(
              title: Text(itm.$1,
                  style: TextStyle(color: Colors.white, fontSize: 12)),
              subtitle: Text(itm.$2,
                  style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
        ],
      ),
    );
  }

  Widget _buildLoggedUserInfoCard() {
    return Card(
      color: Colors.red,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          ListTile(
            leading: Icon(FontAwesomeIcons.user, color: Colors.blue, size: 20),
            title: Text('Logged User Information',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14)),
          ),
          for ((String, String) itm in <(String, String)>[
            ('User UID', AuthUserDb.getLastLoggedUserUid() ?? 'Unknown'),
          ])
            ListTile(
              title: Text(itm.$1,
                  style: TextStyle(color: Colors.white, fontSize: 12)),
              subtitle: Text(itm.$2,
                  style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
        ],
      ),
    );
  }

  Widget _buildAllAuthorizedUsersCard() {
    return Card(
      color: Colors.red,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          ListTile(
            leading: Icon(FontAwesomeIcons.users, color: Colors.blue, size: 20),
            title: Text('All Authorized Users',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14)),
          ),
          for (String? userUid
              in AuthUserDb.getAllAuthorisedUserUid() ?? <String?>[])
            ListTile(
              title: Text(userUid ?? 'Unknown',
                  style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
        ],
      ),
    );
  }

  Widget _buildActionsCard() {
    return Card(
      color: Colors.red,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          ListTile(
            leading: Icon(FontAwesomeIcons.cogs, color: Colors.blue, size: 20),
            title: const Text('Actions',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14)),
          ),
          for ((String, Future<void>? Function()) itm
              in <(String, Future<void>? Function())>[
            (
              'Monitoring Console',
              () async {
                await AppNavigationService.newRoute(
                  RoutesName.talkerMonitorPage,
                );
              }
            ),
            ('Test Function', () async {}),
          ])
            ListTile(
              title: TextButton(
                onPressed: itm.$2,
                child: Text(itm.$1,
                    style: TextStyle(color: Colors.white, fontSize: 12)),
              ),
            ),
        ],
      ),
    );
  }
}
