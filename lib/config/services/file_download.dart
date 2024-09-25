import 'package:background_downloader/background_downloader.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

import '../api/external/models/business_validation_exception.dart';

class DownloadService {
  static void init() {
    FileDownloader().configureNotification(
      running: const TaskNotification('Downloading', 'file: {filename}'),
      progressBar: true,
      tapOpensFile: true,
    );
  }

  static Future<void> downloadFile(String url, String filename) async {
    try {
      final DownloadTask task = DownloadTask(
        url: url,
        filename: filename,
        baseDirectory: BaseDirectory.applicationDocuments,
        updates: Updates.statusAndProgress,
        requiresWiFi: false,
        retries: 3,
        allowPause: true,
      );
      var taskStatus = await FileDownloader().download(
        task,
        onProgress: (double progress) => print('Progress: ${progress * 100}%'),
        onStatus: (TaskStatus status) => print('Status: $status'),
      );
      if (taskStatus.status != TaskStatus.complete) {
        throw BusinessException('Failed to download file');
      }
      await FileDownloader().moveToSharedStorage(task, SharedStorage.downloads);
    } catch (e) {
      lowLevelCatch(e, StackTrace.current);
    }
  }
}
