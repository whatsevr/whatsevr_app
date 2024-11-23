import 'dart:async';
import 'dart:io';

import 'package:flutter_foreground_task/flutter_foreground_task.dart';

import 'package:whatsevr_app/dev/talker.dart';
import 'package:whatsevr_app/config/api/client.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import 'package:whatsevr_app/config/api/methods/posts.dart';
import 'package:whatsevr_app/config/api/requests_model/create_video_post.dart';
import 'package:whatsevr_app/config/services/file_upload.dart';
import 'package:whatsevr_app/config/services/long_running_task/task_models/posts.dart';

@pragma('vm:entry-point')
void startCallback() {
  // The setTaskHandler function must be called to handle the task in the background.
  FlutterForegroundTask.setTaskHandler(WhatsevrLongTaskController());
}

class WhatsevrLongTaskController extends TaskHandler {
  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    TalkerService.instance.info('Foreground service started.');
  }

  @override
  void onReceiveData(dynamic data) async {
    if (data is Map<String, dynamic>) {
      try {
        // Deserialize the task data based on its type.
        final taskData = LongRunningTask.fromMap(data);

        switch (taskData.taskType) {
          case 'new-video-post-task':
            await _handleVideoPostTask(taskData as VideoPostTaskDataForLRT);
            break;

          default:
            throw Exception('Foreground service Unknown task type received.');
        }
      } catch (e, s) {
        lowLevelCatch(e, s);
      }
    } else {
      TalkerService.instance.error('Foreground service Invalid data received.');
    }
    stop();
  }

  Future<void> _handleVideoPostTask(VideoPostTaskDataForLRT taskData) async {
    try {
      await ApiClient.init();
      FileUploadService.init();
      // Upload video and thumbnail
      final videoUrl = await FileUploadService.uploadFilesToSupabase(
        File(taskData.videoFilePath!),
        userUid: taskData.userUid!,
        fileRelatedTo: 'video-post',
      );
      if (videoUrl == null) {
        TalkerService.instance.error('Failed to upload video file.');
        return;
      }
      final thumbnailUrl = await FileUploadService.uploadFilesToSupabase(
        File(taskData.thumbnailFilePath!),
        userUid: taskData.userUid!,
        fileRelatedTo: 'video-post-thumbnail',
      );
      if (thumbnailUrl == null) {
        TalkerService.instance.error('Failed to upload thumbnail file.');
        return;
      }

      final response = await PostApi.createVideoPost(
        post: CreateVideoPostRequest(
          title: taskData.title,
          description: taskData.description,
          userUid: taskData.userUid,
          hashtags: taskData.hashtags,
          location: taskData.location,
          postCreatorType: taskData.postCreatorType,
          thumbnail: thumbnailUrl,
          videoUrl: videoUrl,
          taggedUserUids: taskData.taggedUserUids,
          creatorLatLongWkb: taskData.creatorLatLongWkb,
          addressLatLongWkb: taskData.addressLatLongWkb,
          taggedCommunityUids: taskData.taggedCommunityUids,
          videoDurationInSec: taskData.videoDurationInSec,
        ),
      );

      if (response?.$2 == 200) {
        TalkerService.instance.info('Video post created successfully.');
        FlutterForegroundTask.wakeUpScreen();
        FlutterForegroundTask.updateService(
          notificationTitle: 'Video Post Created',
          notificationText: 'Your video post has been created successfully.',
        );
      } else {
        TalkerService.instance.error('Failed to create video post.');
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
  }

  @override
  Future<void> onDestroy(DateTime timestamp) async {
    TalkerService.instance.info('Foreground service destroyed.');
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
        channelId: 'whatsevr-foreground_service-7653',
        channelName: 'Whatsevr Foreground Service Notification',
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
    TalkerService.instance
        .info('Foreground Service Notification channel registered.');
  }

  static Future<void> startServiceWithTaskData({
    required LongRunningTask taskData,
    required Function onTaskAssignFail,
    required Function onTaskAssigned,
  }) async {
    try {
      if (await FlutterForegroundTask.isRunningService) {
        await FlutterForegroundTask.restartService();
      } else {
        await FlutterForegroundTask.startService(
          serviceId: 256,
          notificationTitle: 'Whatsevr is processing your request.',
          notificationText: 'Do not close the app.',
          callback: startCallback,
        );
      }
      if (await FlutterForegroundTask.isRunningService) {
        FlutterForegroundTask.sendDataToTask(taskData.toMap());
        onTaskAssigned();
      } else {
        onTaskAssignFail();
      }
      // Send the serialized task data to the foreground service.
    } catch (e, s) {
      onTaskAssignFail();
      lowLevelCatch(e, s);
    }
  }

  static Future<void> stop() async {
    TalkerService.instance.info('Trying to stop foreground service.');
    await FlutterForegroundTask.stopService();
  }
}
