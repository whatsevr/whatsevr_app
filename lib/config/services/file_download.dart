import 'package:background_downloader/background_downloader.dart';

class DownloadService {
  static void init() {
    FileDownloader().configureNotification(
      running: TaskNotification('Downloading', 'file: {filename}'),
      progressBar: true,
      tapOpensFile: true,
    );
  }

  static Future<void> downloadFile(String url, String filename) async {
    final DownloadTask task = DownloadTask(
      url: url,
      filename: filename,
      baseDirectory: BaseDirectory.applicationDocuments,
      updates: Updates.statusAndProgress,
      requiresWiFi: false,
      retries: 3,
      allowPause: true,
    );
    await FileDownloader().download(task,
        onProgress: (progress) => print('Progress: ${progress * 100}%'),
        onStatus: (status) => print('Status: $status'));
    await FileDownloader().moveToSharedStorage(task, SharedStorage.downloads);
  }
}
