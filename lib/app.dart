import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:whatsevr_app/config/routes/router.dart';

import 'package:whatsevr_app/dev/dragable_bubble.dart';
import 'package:whatsevr_app/dev/talker.dart';

class WhatsevrApp extends StatefulWidget {
  const WhatsevrApp({super.key});

  @override
  State<WhatsevrApp> createState() => _WhatsevrAppState();
}

class _WhatsevrAppState extends State<WhatsevrApp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  GoRouter routeConfig = AppNavigationService.allRoutes();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'WhatsEvr',
      theme: ThemeData(
        primaryColor: Colors.blue,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.grey,
          selectionColor: Colors.grey,
          selectionHandleColor: Colors.grey,
        ),
        useMaterial3: true,
        //flipkart
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      routerConfig: routeConfig,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        scrollbars: false,
        dragDevices: PointerDeviceKind.values.toSet(),
      ),
      builder: FlutterSmartDialog.init(
        builder: (BuildContext context, Widget? child) {
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Stack(
              children: <Widget>[
                SafeArea(
                  child: WhatsevrTalkerWrapper(child: child!),
                ),
                DraggableWidget(),
              ],
            ),
          );
        },
      ),
    );
  }
}
