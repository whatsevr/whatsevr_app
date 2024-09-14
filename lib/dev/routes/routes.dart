import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsevr_app/dev/routes/routes_name.dart';
import 'package:whatsevr_app/dev/sandbox.dart';

List<GoRoute> getDevRoutes() {
  return [
    GoRoute(
      name: DeveloperRoutes.developerPage,
      path: DeveloperRoutes.developerPage,
      builder: (BuildContext context, GoRouterState state) {
        return DeveloperPage();
      },
    ),
  ];
}
