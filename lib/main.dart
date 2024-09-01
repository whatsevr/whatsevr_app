import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'package:whatsevr_app/app.dart';

import 'config/api/client.dart';
import 'config/services/file_upload.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WakelockPlus.enable();
  ApiClient.init();
  FileUploadService.init();
  runApp(const WhatsevrApp());
}
