import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

// import 'package:media_kit/media_kit.dart';
import 'package:whatsevr_app/app.dart';

import 'config/api/client.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WakelockPlus.enable();
  ApiClient.init();
  runApp(const WhatsevrApp());
}
