import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

// import 'package:media_kit/media_kit.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // MediaKit.ensureInitialized();
  WakelockPlus.enable();
  runApp(WhatsevrApp());
}
