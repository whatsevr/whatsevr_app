import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../config/services/auth_db.dart';
import '../../../../config/widgets/buttons/button.dart';
import '../../../../config/widgets/dialogs/auth_dialogs.dart';
import '../../../../config/widgets/dialogs/showAppModalSheet.dart';
import '../../../../config/widgets/loading_indicator.dart';
import '../bloc/splash_bloc.dart';

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
            FutureBuilder(
              future: Future.delayed(const Duration(seconds: 3)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const WhatsevrLoadingIndicator();
                }
                return WhatsevrButton.filled(
                    shrink: true,
                    label: 'Login',
                    onPressed: () {
                      final localUids =
                          AuthUserDb.getAllAuthorisedUserUid();
                      if (localUids.isNotEmpty ?? false) {
                        showAppModalSheet(
                          dismissPrevious: true,
                          flexibleSheet: false,
                          child: SwitchUserDialogUi(),
                        );
                      } else {
                        context
                            .read<SplashBloc>()
                            .add(const InitiateAuthServiceEvent());
                      }
                    },);
              },
            ),
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
