import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:whatsevr_app/config/routes/router.dart';

import 'package:whatsevr_app/dev/dragable_bubble.dart';

import 'constants.dart';

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
        toastBuilder: (msg) => _toastUi(msg),
        loadingBuilder: (String msg) => _loaderUi(msg),
        builder: (BuildContext context, Widget? child) {
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Stack(
              children: <Widget>[
                SafeArea(
                  child: child!,
                ),
                if (kTestingMode) const DraggableWidget(),
              ],
            ),
          );
        },
      ),
    );
  }
}

Center _loaderUi(String msg) {
  return Center(
    child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CupertinoActivityIndicator(),
            const Gap(12),
            Text(msg),
          ],
        )),
  );
}

Container _toastUi(String msg) {
  return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Text(msg));
}
