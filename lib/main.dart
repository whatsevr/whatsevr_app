import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'package:whatsevr_app/app.dart';

import 'package:whatsevr_app/config/api/client.dart';
import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/services/file_upload.dart';

import 'config/services/auth_db.dart';
import 'config/services/file_download.dart';
import 'config/talker.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WakelockPlus.enable();
  AuthUserDb.initDB();
  ApiClient.init();
  FileUploadService.init();
  DownloadService.init();
  TalkerService.init();
  runApp(const WhatsevrApp());
}
