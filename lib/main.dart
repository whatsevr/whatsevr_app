import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'package:whatsevr_app/app.dart';

import 'package:whatsevr_app/config/api/client.dart';
import 'package:whatsevr_app/config/services/file_upload.dart';

import 'package:whatsevr_app/config/services/auth_db.dart';
import 'package:whatsevr_app/config/services/file_download.dart';
import 'package:whatsevr_app/dev/talker.dart';

import 'firebase_options.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      FlutterError.onError = (FlutterErrorDetails details) {
        catchUnhandledExceptions(details.exception, details.stack);
      };
      PlatformDispatcher.instance.onError = (error, stack) {
        catchUnhandledExceptions(error, stack);
        return true;
      };
      WakelockPlus.enable();
      await AuthUserDb.initDB();
      await ApiClient.init();
      FileUploadService.init();
      DownloadService.init();
      TalkerService.init();
      runApp(const WhatsevrApp());
    },
    catchUnhandledExceptions,
  );
}

void catchUnhandledExceptions(Object error, StackTrace? stack) {
  FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  debugPrintStack(stackTrace: stack, label: error.toString());
  TalkerService.instance.error(error.toString(), stack);
}
