import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/routes/routes_name.dart';

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

  GoRouter routeConfig = AppNavigationService.allRoutesConfig(null);
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Whatsevr',
      theme: ThemeData(
        primaryColor: Colors.blue,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.grey,
          selectionColor: Colors.grey,
          selectionHandleColor: Colors.grey,
        ),
        useMaterial3: true,
        //flipkart
        textTheme: GoogleFonts.openSansTextTheme(),
      ),
      routerConfig: routeConfig,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        scrollbars: false,
        dragDevices: PointerDeviceKind.values.toSet(),
      ),
      builder: FlutterSmartDialog.init(
        builder: (BuildContext context, Widget? child) {
          return SafeArea(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: GestureDetector(
                onLongPress: () {
                  AppNavigationService.newRoute(RoutesName.takerDebug);
                },
                child: Banner(
                  color: Colors.red,
                  message: "Debug",
                  location: BannerLocation.topEnd,
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0 * 0.85,
                    fontWeight: FontWeight.w900,
                    height: 1.0,
                  ),
                  child: child,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
