import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'config/routes/router.dart';

class WhatsevrApp extends StatelessWidget {
  const WhatsevrApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter routeConfig = AppNavigationService.allRoutesConfig(context, null);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Whatsevr',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
        //flipkart
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      routerConfig: routeConfig,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        scrollbars: false,
        dragDevices: PointerDeviceKind.values.toSet(),
      ),
      builder: FlutterSmartDialog.init(
        builder: (BuildContext context, Widget? child) {
          return SafeArea(child: child!);
        },
      ),
    );
  }
}
