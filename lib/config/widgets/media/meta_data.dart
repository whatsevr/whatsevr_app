import 'dart:io';
import 'dart:math';

import 'package:media_info/media_info.dart';
import 'package:whatsevr_app/utils/conversion.dart';

class FileMetaData {
  final String? name;
  final String? path;
  final String? extension;
  final String? mimeType;
  final int? size;
  final String? sizeInText;

  final int? width;
  final int? height;
  final double? aspectRatio;
  final double? frameRate;
  final int? duration;
  final String? durationInText;

  FileMetaData({
    this.name,
    this.path,
    this.extension,
    this.mimeType,
    this.size,
    this.sizeInText,
    this.width,
    this.height,
    this.aspectRatio,
    this.frameRate,
    this.duration,
    this.durationInText,
  });

  static Future<FileMetaData?> fromFile(File? file) async {
    if (file == null) {
      return null;
    }
    try {
      final Map<String, dynamic> mediaInfo =
          await MediaInfo().getMediaInfo(file.path);
      return FileMetaData(
        name: file.path.split('/').last,
        extension: file.path.split('.').last,
        width: mediaInfo['width'],
        height: mediaInfo['height'],
        aspectRatio: getAspectRatio(
          width: mediaInfo['width'],
          height: mediaInfo['height'],
        ),
        frameRate: mediaInfo['frameRate'],
        duration: mediaInfo['durationMs'],
        mimeType: mediaInfo['mimeType'],
        size: file.lengthSync(),
        sizeInText: await getFileSize(file),
        path: file.path,
        durationInText: await getDurationInText(mediaInfo['durationMs']),
      );
    } catch (e) {
      return null;
    }
  }

  static double? getAspectRatio({required int? width, required int? height}) {
    try {
      if (width == null || height == null) return null;
      return width / height;
    } catch (e) {
      return null;
    }
  }

  static Future<String?> getDurationInText(int? duration) async {
    try {
      if (duration == null) return null;
      final int hours = duration ~/ 3600000;
      final int minutes = (duration % 3600000) ~/ 60000;
      final int seconds = ((duration % 3600000) % 60000) ~/ 1000;
      return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    } catch (e) {
      return null;
    }
  }

  static Future<String?> getFileSize(File file) async {
    try {
      int bytes = await file.length();
      if (bytes <= 0) return '0 B';
      const List<String> suffixes = <String>[
        'B',
        'KB',
        'MB',
        'GB',
        'TB',
        'PB',
        'EB',
        'ZB',
        'YB'
      ];
      int i = (log(bytes) / log(1024)).floor();
      return '${(bytes / pow(1024, i)).toStringAsFixed(2)} ${suffixes[i]}';
    } catch (e) {
      return null;
    }
  }
}
