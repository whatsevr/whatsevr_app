import 'package:flutter/material.dart';

import '../../../../config/routes/router.dart';
import '../../../../config/routes/routes_name.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        AppNavigationService.newRoute(RoutesName.dashboard);
      },
    );
    return const Scaffold(
      body: Center(
        child: Text('Whatsevr', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
