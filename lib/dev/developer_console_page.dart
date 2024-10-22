import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:username_generator/username_generator.dart';
import 'package:whatsevr_app/config/widgets/slider.dart';
import '../config/routes/router.dart';
import '../config/routes/routes_name.dart';
import '../config/services/device_info.dart';
import '../config/widgets/dynamic_height_views.dart';
import '../utils/username.dart';

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
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          ExpansionTile(
            title: const Text('Device Info'),
            children: [
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
                  title: Text(itm.$1),
                  subtitle: Text(itm.$2),
                ),
            ],
          ),
          for ((String, Future<void>? Function()) itm
              in <(String, Future<void>? Function())>[
            (
              'Debugger',
              () async {
                await AppNavigationService.newRoute(
                  RoutesName.talkerMonitorPage,
                );
              }
            ),
            ('Test', () async {}),
          ])
            TextButton(
              onPressed: itm.$2,
              child: Text(itm.$1),
            ),
        ],
      ),
    );
  }
}
