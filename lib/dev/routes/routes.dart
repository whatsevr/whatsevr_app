import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../config/routes/routes_name.dart';
import '../developer_console_page.dart';
import '../talker.dart';
import 'routes_name.dart';

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
