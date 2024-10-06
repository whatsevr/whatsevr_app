import 'package:flutter/material.dart';
import '../config/routes/router.dart';
import '../config/routes/routes_name.dart';

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
            ('Cloudinary Video', () async {}),
            ('Story Editor', () async {}),
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
