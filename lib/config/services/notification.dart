import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

@pragma('vm:entry-point')
void notificationTapWhenAppBackground(
    NotificationResponse notificationResponse) {
  // handle action
}

class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  Future<void> initialize(BuildContext context) async {
    // Initialize local notifications
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _plugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _handleNotificationClick,
      onDidReceiveBackgroundNotificationResponse:
          notificationTapWhenAppBackground,
    );

    // Initialize Firebase Messaging
    await _firebaseMessaging.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showRemoteNotification(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});

    // Setup timezone
    tz.initializeTimeZones();
  }

  // Show Firebase Push Notification
  Future<void> _showRemoteNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'chat_channel_id',
      'Notifications for chat messages',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await _plugin.show(
      message.notification.hashCode,
      message.notification?.title ?? '',
      message.notification?.body ?? '',
      platformChannelSpecifics,
      payload: message.data['payload'],
    );
  }

  // Show Local Chat Notification
  Future<void> showLocalNotification(
      String messageContent, String senderName) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'chat_channel_id',
      'Notifications for chat messages',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await _plugin.show(
      0,
      'Message from $senderName',
      messageContent,
      platformChannelSpecifics,
      payload: 'chat',
    );
  }

  // Handle Notification Click
  void _handleNotificationClick(NotificationResponse? payload) {
    if (payload == 'chat') {
      // Navigate to chat screen or handle notification click action
      // Navigator.of(context).push(MaterialPageRoute(
      //   builder: (context) => ChatScreen(), // Replace with your chat screen
      // ));
    }
  }

  /// Show Custom Notification based on type
  Future<void> showCustomNotification(
      String title, String body, String type) async {
    AndroidNotificationDetails androidDetails;

    switch (type) {
      case 'comment':
        androidDetails = AndroidNotificationDetails(
          'comments_channel',
          'Notifications for comments',
          importance: Importance.max,
          priority: Priority.high,
        );
        break;
      case 'like':
        androidDetails = AndroidNotificationDetails(
          'likes_channel',
          'Notifications for likes',
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
        );
        break;
      case 'new_video':
        androidDetails = AndroidNotificationDetails(
          'video_channel',
          'Notifications for new video uploads',
          importance: Importance.high,
          priority: Priority.high,
        );
        break;
      default:
        androidDetails = AndroidNotificationDetails(
          'general_channel',
          'General notifications',
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
        );
        break;
    }

    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidDetails,
    );

    await _plugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: type,
    );
  }

  /// Show Rich Media Notification (e.g., image)
  Future<void> showRichMediaNotification(
      String title, String body, String imageUrl) async {
    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(
      FilePathAndroidBitmap(imageUrl),
      contentTitle: title,
      summaryText: body,
    );

    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'rich_media_channel',
      'Notifications with media (images, videos)',
      importance: Importance.high,
      priority: Priority.high,
      styleInformation: bigPictureStyleInformation,
    );

    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await _plugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  /// Show Sticky Progress Notification
  Future<void> showStickyProgressNotification(
      String title, String description) async {
    const int progressMax = 100;
    int currentProgress = 0;

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'progress_channel_id',

      'Notifications with a progress bar',
      importance: Importance.low,
      priority: Priority.low,
      ongoing: true, // Sticky notification
      showProgress: true,
      maxProgress: progressMax,
    );

    for (currentProgress;
        currentProgress <= progressMax;
        currentProgress += 10) {
      final NotificationDetails platformChannelSpecifics =
          const NotificationDetails(
        android: androidPlatformChannelSpecifics,
      );

      await _plugin.show(
        1, // notification id
        title,
        '$description: $currentProgress%',
        platformChannelSpecifics,
        payload: 'progress',
      );

      // Simulate progress update
      await Future.delayed(const Duration(seconds: 1));
    }

    // Remove the notification after completion
    await _plugin.cancel(1);
  }

  /// Show Grouped Notifications (e.g., multiple likes or comments)
  Future<void> showGroupedNotification(
      String title, String body, int notificationId, String groupKey) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'grouped_channel',
      'Grouped Notifications',

      importance: Importance.high,
      priority: Priority.high,
      groupKey: groupKey, // Unique key for this group
    );

    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await _plugin.show(
      notificationId,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  /// Show Notification with Action Buttons (e.g., Like, Reply)
  Future<void> showNotificationWithAction(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'action_channel',
      'Notifications with action buttons',
      importance: Importance.high,
      priority: Priority.high,
      actions: <AndroidNotificationAction>[
        AndroidNotificationAction('reply_action', 'Reply'),
        AndroidNotificationAction('like_action', 'Like'),
      ],
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await _plugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  /// Show Silent Notification (no sound or alert)
  Future<void> showSilentNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'silent_channel',
      'Silent background notifications',
      importance: Importance.min,
      priority: Priority.min,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await _plugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  /// Schedule a Notification for a specific time (e.g., live stream reminders)
  Future<void> scheduleNotification(
      String title, String body, DateTime scheduledTime) async {
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'scheduled_channel',
      'Notifications for scheduled events',
      importance: Importance.high,
      priority: Priority.high,
    );

    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await _plugin.zonedSchedule(
      0,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  /// Subscribe to a Firebase topic
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
      print('Subscribed to topic: $topic');
    } catch (e) {
      print('Failed to subscribe to topic: $e');
    }
  }

  /// Unsubscribe from a Firebase topic
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
      print('Unsubscribed from topic: $topic');
    } catch (e) {
      print('Failed to unsubscribe from topic: $e');
    }
  }

  /// Get current Firebase Cloud Messaging (FCM) token
  Future<String?> getCurrentFcmToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      print('FCM Token: $token');
      return token;
    } catch (e) {
      print('Failed to get FCM token: $e');
      return null;
    }
  }

  /// Update Badge Count (for unread notifications)
  // Future<void> updateBadgeCount(int count) async {
  //   await _localNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>()
  //       ?.setBadgeCount(count);
  //
  //   await _localNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           IOSFlutterLocalNotificationsPlugin>()
  //       ?.setBadgeCount(count);
  // }

  /// Reset Badge Count
  // Future<void> resetBadgeCount() async {
  //   await updateBadgeCount(0); // Reset badge count to zero
  // }
}
