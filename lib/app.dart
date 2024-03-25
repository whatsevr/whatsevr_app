import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'config/routes/router.dart';

class WhatsevrApp extends StatefulWidget {
  const WhatsevrApp({super.key});

  @override
  State<WhatsevrApp> createState() => _WhatsevrAppState();
}

class _WhatsevrAppState extends State<WhatsevrApp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

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
