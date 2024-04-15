import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/whatsevr_app_logo.jpg',
              width: 100,
            ),
            const Text('Whatsevr', style: TextStyle(fontSize: 24)),
            const Gap(15),
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
