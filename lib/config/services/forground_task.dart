import 'dart:async';
import 'dart:io';

import 'package:flutter_foreground_task/flutter_foreground_task.dart';

class WhatsevrForegroundService extends TaskHandler {
  @override
  Future<void> onStart(DateTime timestamp) async {}

  @override
  void onDestroy(DateTime timestamp) {
    print('onDestroy');
  }

  @override
  void onReceiveData(Object data) {
    // You can handle received data if needed.
  }

  @override
  void onRepeatEvent(DateTime timestamp) {}

  static Future<void> requestPermissions() async {
    final notificationPermission =
        await FlutterForegroundTask.checkNotificationPermission();
    if (notificationPermission != NotificationPermission.granted) {
      await FlutterForegroundTask.requestNotificationPermission();
    }

    if (Platform.isAndroid) {
      if (!await FlutterForegroundTask.isIgnoringBatteryOptimizations) {
        await FlutterForegroundTask.requestIgnoreBatteryOptimization();
      }
    }
  }

  static void registerNotificationChannel() {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'foreground_service',
        channelName: 'Foreground Service Notification',
        channelDescription:
            'This notification appears when the foreground service is running.',
        channelImportance: NotificationChannelImportance.LOW,
        priority: NotificationPriority.LOW,
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: true,
        playSound: false,
      ),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.once(),
        autoRunOnBoot: true,
        autoRunOnMyPackageReplaced: true,
        allowWakeLock: true,
        allowWifiLock: true,
      ),
    );
  }

  static Future<void> startService({
    required String notificationText,
    required void Function() callback,
  }) async {
    if (await FlutterForegroundTask.isRunningService) {
      await FlutterForegroundTask.restartService();
    } else {
      await FlutterForegroundTask.startService(
        serviceId: 256,
        notificationTitle: 'Whatsevr',
        notificationText: notificationText,
        callback: () {
          callback();
        },
      );
    }
    FlutterForegroundTask.sendDataToTask(
      ForegroundTask(
        title: 'Whatsevr',
        callback: () {
          callback();
        },
      ),
    );
  }

  static Future<void> stopService() async {
    await FlutterForegroundTask.stopService();
  }
}

class ForegroundTask {
  final String title;
  final Function callback;

  ForegroundTask({
    required this.title,
    required this.callback,
  });
}
