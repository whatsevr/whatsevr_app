import 'package:background_downloader/background_downloader.dart';

import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';

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
      final task = DownloadTask(
        url: url,
        filename: filename,
        baseDirectory: BaseDirectory.applicationDocuments,
        updates: Updates.statusAndProgress,
        requiresWiFi: false,
        retries: 3,
        allowPause: true,
      );
      final taskStatus = await FileDownloader().download(
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
