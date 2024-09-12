import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'package:whatsevr_app/app.dart';

import 'package:whatsevr_app/config/api/client.dart';
import 'package:whatsevr_app/config/services/file_upload.dart';

import 'package:whatsevr_app/config/services/auth_db.dart';
import 'package:whatsevr_app/config/services/file_download.dart';
import 'package:whatsevr_app/config/talker.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WakelockPlus.enable();
  AuthUserDb.initDB();
  await ApiClient.init();
  FileUploadService.init();
  DownloadService.init();
  TalkerService.init();

  runApp(const WhatsevrApp());
}
