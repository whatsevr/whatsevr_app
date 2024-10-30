import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  Future<void> init() async {
    await AwesomeNotifications().initialize(
      'resource://drawable/res_app_icon', // Replace with your app icon path
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic Notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Color(0xFF9D50DD),
          ledColor: Colors.white,
        ),
        NotificationChannel(
          channelKey: 'media_channel',
          channelName: 'Media Notifications',
          channelDescription: 'Notification channel for media tests',
          defaultColor: Color(0xFF9D50DD),
          ledColor: Colors.white,
          playSound: true,
          enableVibration: true,
          importance: NotificationImportance.High,
        ),
        NotificationChannel(
          channelKey: 'scheduled_channel',
          channelName: 'Scheduled Notifications',
          channelDescription: 'Channel for scheduled notifications',
          defaultColor: Color(0xFF9D50DD),
          ledColor: Colors.white,
          importance: NotificationImportance.Max,
          enableVibration: true,
          playSound: true,
        ),
        NotificationChannel(
          channelKey: 'big_picture_channel',
          channelName: 'Big Picture Notifications',
          channelDescription: 'Channel for big picture notifications',
          defaultColor: Color(0xFF9D50DD),
          ledColor: Colors.white,
          importance: NotificationImportance.High,
        ),
      ],
    );
  }

  Future<void> showBasicNotification(String title, String body) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'basic_channel',
        title: title,
        body: body,
        notificationLayout: NotificationLayout.Default,
      ),
    );
  }

  Future<void> showBigPictureNotification(
      String title, String body, String imageUrl,) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'big_picture_channel',
        title: title,
        body: body,
        bigPicture: imageUrl,
        notificationLayout: NotificationLayout.BigPicture,
      ),
    );
  }

  Future<void> showMediaNotification(
      String title, String body, String imageUrl,) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'media_channel',
        title: title,
        body: body,
        bigPicture: imageUrl,
        notificationLayout: NotificationLayout.MediaPlayer,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'PLAY',
          label: 'Play',
        ),
        NotificationActionButton(
          key: 'PAUSE',
          label: 'Pause',
        ),
      ],
    );
  }

  Future<void> showBigTextNotification(String title, String bigText) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'basic_channel',
        title: title,
        body: bigText,
        notificationLayout: NotificationLayout.BigText,
      ),
    );
  }

  Future<void> showInboxNotification(
      String title, List<String> messages,) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'basic_channel',
        title: title,
        body: messages.join('\n'),
        notificationLayout: NotificationLayout.Inbox,
        payload: {'messages': messages.join(', ')},
      ),
    );
  }

  Future<void> showMessagingNotification(String groupKey, String chatTitle,
      List<Map<String, String>> messages,) async {
    // Formatting the messages as a string for the payload
    final String formattedMessages =
        messages.map((msg) => '${msg['sender']}: ${msg['message']}').join('\n');

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'basic_channel',
        title: chatTitle,
        body: 'You have new messages',
        groupKey: groupKey,
        notificationLayout: NotificationLayout.Messaging,
        payload: {'messages': formattedMessages},
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'REPLY',
          label: 'Reply',
          requireInputText: true,
        ),
      ],
    );
  }

  Future<void> showNotificationWithActionButtons(
      String title, String body,) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'basic_channel',
        title: title,
        body: body,
        notificationLayout: NotificationLayout.Default,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'OPEN',
          label: 'Open',
        ),
        NotificationActionButton(
          key: 'DISMISS',
          label: 'Dismiss',
        ),
      ],
    );
  }

  Future<void> showScheduledNotification(
      String title, String body, DateTime scheduledDate,) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'scheduled_channel',
        title: title,
        body: body,
      ),
      schedule: NotificationCalendar.fromDate(date: scheduledDate),
    );
  }

  Future<void> showProgressNotification(
      String title, String body, int progress,) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'basic_channel',
        title: title,
        body: body,
        notificationLayout: NotificationLayout.ProgressBar,
        progress: progress,
        locked: true,
      ),
    );
  }

  Future<void> cancelAllNotifications() async {
    await AwesomeNotifications().cancelAll();
  }

  Future<void> resetBadgeCount() async {
    await AwesomeNotifications().resetGlobalBadge();
  }

  int createUniqueId() {
    return DateTime.now().millisecondsSinceEpoch.remainder(100000);
  }
}
