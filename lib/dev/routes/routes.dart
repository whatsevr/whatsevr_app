import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:whatsevr_app/config/routes/routes_name.dart';
import 'package:whatsevr_app/dev/routes/routes_name.dart';
import 'package:whatsevr_app/dev/developer_console_page.dart';

import '../talker.dart';

List<GoRoute> getDevRoutes() {
  return <GoRoute>[
    GoRoute(
      name: DeveloperRoutes.developerPage,
      path: DeveloperRoutes.developerPage,
      builder: (BuildContext context, GoRouterState state) {
        return const DeveloperConsolePage();
      },
    ),
    GoRoute(
      name: RoutesName.talkerMonitorPage,
      path: RoutesName.talkerMonitorPage,
      builder: (BuildContext context, GoRouterState state) {
        return TalkerScreen(
          talker: TalkerService.instance,
          appBarTitle: 'Console',
        );
      },
    ),
  ];
}
