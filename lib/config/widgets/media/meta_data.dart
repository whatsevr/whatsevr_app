import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:media_info/media_info.dart';
import 'package:path_provider/path_provider.dart';

import 'package:whatsevr_app/constants.dart';
import 'package:whatsevr_app/dev/talker.dart';
import 'package:whatsevr_app/utils/conversion.dart';
import 'package:whatsevr_app/config/widgets/dialogs/showAppModalSheet.dart';

class FileMetaData {
  final String name;
  final String path;
  final String extension;
  final String? mimeType;
  final int? sizeInBytes;
  final String? sizeInText;
  final bool? isImage;
  final bool? isVideo;
  final bool? isAudio;
  final bool? isGif;
  final bool? isOrientationPortrait;
  final bool? isOrientationLandscape;
  final bool? isOrientationSquare;
  final int? width;
  final int? height;
  final double? aspectRatio;
  final double? frameRate;
  final int? durationInMs;
  final int? durationInSec;
  final int? durationInMin;
  final int? durationInHour;
  final String? durationInText;

  FileMetaData({
    required this.name,
    required this.path,
    required this.extension,
    this.mimeType,
    required this.sizeInBytes,
    required this.sizeInText,
    required this.isImage,
    required this.isVideo,
    required this.isAudio,
    required this.isGif,
    required this.isOrientationPortrait,
    required this.isOrientationLandscape,
    required this.isOrientationSquare,
    this.width,
    this.height,
    this.aspectRatio,
    this.frameRate,
    this.durationInMs,
    this.durationInSec,
    this.durationInMin,
    this.durationInHour,
    this.durationInText,
  });
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'path': path,
      'extension': extension,
      'mimeType': mimeType,
      'sizeInBytes': sizeInBytes,
      'sizeInText': sizeInText,
      'isImage': isImage,
      'isVideo': isVideo,
      'isAudio': isAudio,
      'isGif': isGif,
      'isOrientationPortrait': isOrientationPortrait,
      'isOrientationLandscape': isOrientationLandscape,
      'isOrientationSquare': isOrientationSquare,
      'width': width,
      'height': height,
      'aspectRatio': aspectRatio,
      'frameRate': frameRate,
      'durationInMs': durationInMs,
      'durationInSec': durationInSec,
      'durationInMin': durationInMin,
      'durationInHour': durationInHour,
      'durationInText': durationInText,
    };
  }

  static Future<FileMetaData?> fromFile(File? file) async {
    if (file == null) return null;

    try {
      TalkerService.instance.info('Getting file metadata for ${file.path}');
      if (!file.existsSync()) {
        TalkerService.instance.error('File does not exist: ${file.path}');
        return null;
      }
      Map<String, dynamic>? mediaInfo;
      try {
        mediaInfo = await MediaInfo().getMediaInfo(file.path);
      } catch (e) {
        TalkerService.instance.error(
          'Error getting media info so trying to get media info for renamed file',
        );

        ///in case package:media_info was unable to get media info for the file for complex file name
        final File? renamedFile = await _simplifyFileNameAndPutToTempDir(
          file.path,
        );
        mediaInfo = await MediaInfo().getMediaInfo(renamedFile!.path);
        file = renamedFile;
      }
      final width = mediaInfo['width'] as int?;
      final height = mediaInfo['height'] as int?;
      final aspectRatio = getAspectRatio(width: width, height: height);
      final mimeType = mediaInfo['mimeType'] as String?;
      final isImage = mimeType?.startsWith('image') ?? false;
      final isVideo = mimeType?.startsWith('video') ?? false;
      final isAudio = mimeType?.startsWith('audio') ?? false;
      final isGif = mimeType == 'image/gif';

      // Calculating file size and hash
      final size = await file.length();
      final sizeInText = getFileSize(size);
      final (sec, min, hour) =
          getDurationInSecMinHour(mediaInfo['durationMs'] as int?);
      final int? durationInSec = sec;
      final int? durationInMin = min;
      final int? durationInHour = hour;
      final FileMetaData fileMetaData = FileMetaData(
        name: file.path.split('/').last,
        path: file.path,
        extension: file.path.split('.').last,
        mimeType: mimeType,
        sizeInBytes: size,
        sizeInText: sizeInText,
        isImage: isImage,
        isVideo: isVideo,
        isAudio: isAudio,
        isGif: isGif,
        width: width,
        height: height,
        aspectRatio: aspectRatio,
        frameRate: mediaInfo['frameRate'] as double?,
        durationInMs: mediaInfo['durationMs'] as int?,
        durationInSec: durationInSec,
        durationInMin: durationInMin,
        durationInHour: durationInHour,
        durationInText: getDurationInText(durationInSec),
        isOrientationPortrait:
            width != null && height != null && width < height,
        isOrientationLandscape:
            width != null && height != null && width > height,
        isOrientationSquare: width != null && height != null && width == height,
      );
      TalkerService.instance.info(fileMetaData.toMap());
      return fileMetaData;
    } catch (e) {
      TalkerService.instance.error('Error getting file metadata: $e');
      return null;
    }
  }

  static (int? sec, int? min, int? hour) getDurationInSecMinHour(
    int? duration,
  ) {
    if (duration == null) return (null, null, null);
    final int sec = duration ~/ 1000;
    final int min = sec ~/ 60;
    final int hour = min ~/ 60;
    return (sec, min, hour);
  }

  static double? getAspectRatio({required int? width, required int? height}) {
    if (width == null || height == null || height == 0) return null;
    return width / height;
  }

  static String? getFileSize(int? bytes) {
    if (bytes == null) return null;
    if (bytes <= 0) return '0 B';
    const suffixes = <String>[
      'B',
      'KB',
      'MB',
      'GB',
      'TB',
      'PB',
      'EB',
      'ZB',
      'YB',
    ];
    final int i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(2)} ${suffixes[i]}';
  }

  static void showMetaData(FileMetaData? metaData) {
    if (!kTestingMode) return;
    if (metaData == null) return;
    final Map<String, dynamic> data = metaData.toMap();
    showAppModalSheet(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'File Metadata',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const Gap(12),
          Table(
            border: TableBorder.all(),
            children: [
              for (var entry in data.entries)
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(entry.key),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(entry.value.toString()),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}

Future<File?> _simplifyFileNameAndPutToTempDir(String sourceFilePath) async {
  try {
    // Check if the source file exists
    final sourceFile = File(sourceFilePath);
    final String fileExtension = sourceFile.path.split('.').last;
    if (!await sourceFile.exists()) {
      debugPrint('Source file does not exist.');
      return null;
    }

    // Get the temporary directory
    final Directory tempDir = await getTemporaryDirectory();
    final String tempPath = tempDir.path;

    // Create a unique filename using the current timestamp
    final String newFileName =
        'temp_whatsevr_${DateTime.now().millisecondsSinceEpoch}.$fileExtension';

    // Create the new file path in the temporary directory
    final newFilePath = '$tempPath/$newFileName';

    // Copy the file and rename it
    final newFile = await sourceFile.copy(newFilePath);
    debugPrint('File copied and renamed to: ${newFile.path}');

    return newFile;
  } catch (e) {
    debugPrint('Error occurred while copying and renaming the file: $e');
    return null;
  }
}
