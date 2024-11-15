import 'dart:async';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get_time_ago/get_time_ago.dart';

import 'package:path_provider/path_provider.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:whatsevr_app/app.dart';
import 'package:whatsevr_app/config/api/client.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';
import 'package:whatsevr_app/config/services/auth_user_service.dart';
import 'package:whatsevr_app/config/services/device_info.dart';
import 'package:whatsevr_app/config/services/file_download.dart';
import 'package:whatsevr_app/config/services/file_upload.dart';
import 'package:whatsevr_app/config/services/long_running_task/controller.dart';
import 'package:whatsevr_app/config/services/notification.dart';
import 'package:whatsevr_app/config/services/permission.dart';
import 'package:whatsevr_app/constants.dart';
import 'package:whatsevr_app/dev/talker.dart';
import 'package:whatsevr_app/firebase_options.dart';
import 'package:whatsevr_app/utils/conversion.dart';

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
      TalkerService.init();
      await DeviceInfoService.setDeviceInfo();
      WakelockPlus.enable();
      await AuthUserDb.initDB();
      await ApiClient.init();
      FileUploadService.init();
      DownloadService.init();
      FlutterForegroundTask.initCommunicationPort();
      final storage = await HydratedStorage.build(
        storageDirectory: await getApplicationDocumentsDirectory(),
      );
      HydratedBloc.storage = storage;
      runApp(WhatsevrApp());

      afterRunAppServices();
    },
    catchUnhandledExceptions,
  );
}

void catchUnhandledExceptions(Object error, StackTrace? stack) {
  FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  TalkerService.instance.error(error.toString(), stack);
  if (kTestingMode) {
    SmartDialog.showToast(
      error.toString(),
      builder: (context) {
        return Container(
          color: Colors.red,
          padding: EdgeInsets.all(12),
          child: Text(
            '$error',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}

void afterLoginServices() async {
  TalkerService.instance.info('Executing after login services.');
  AuthUserService.getSupportiveDataForLoggedUser();
  await PermissionService.requestAllPermissions();
  WhatsevrLongTaskController.registerNotificationChannel();
  NotificationService().init();
}

void afterRunAppServices() {

  GetTimeAgo.setDefaultLocale('en');
  GetTimeAgo.setCustomLocaleMessages('en', GetTimeAgoMessages());
}
