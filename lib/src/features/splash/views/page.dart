import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/src/features/splash/bloc/splash_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (BuildContext context) => SplashBloc()..add(const InitialEvent()),
      child: Builder(
        builder: (BuildContext context) {
          return buildPage(context);
        },
      ),
    );
  }

  Widget buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            const Gap(30),
            ExtendedImage.asset(
              'assets/images/whatsevr_app_logo.jpg',
              width: 100,
            ),
            const Spacer(),
            const CupertinoActivityIndicator(),
            const Gap(30),
            const Text(
              'WhatsEvr',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Ver 1.0.0',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            const Gap(30),
          ],
        ),
      ),
    );
  }
}
