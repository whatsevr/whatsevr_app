import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'package:whatsevr_app/app.dart';

import 'package:whatsevr_app/config/api/client.dart';
import 'package:whatsevr_app/config/services/file_upload.dart';

import 'config/services/auth_db.dart';
import 'config/services/file_download.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WakelockPlus.enable();
  AuthUserDb.initDB();
  ApiClient.init();
  FileUploadService.init();
  DownloadService.init();
  runApp(const WhatsevrApp());
}
