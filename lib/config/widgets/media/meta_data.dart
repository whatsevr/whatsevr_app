import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:media_info/media_info.dart';

import 'package:whatsevr_app/config/widgets/showAppModalSheet.dart';
import 'package:whatsevr_app/dev/talker.dart';

import '../../../constants.dart';

class FileMetaData {
  final String name;
  final String path;
  final String extension;
  final String? mimeType;
  final int? size;
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
    required this.size,
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
      'size': size,
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
      final mediaInfo = await MediaInfo().getMediaInfo(file.path);

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
      return FileMetaData(
        name: file.path.split('/').last,
        path: file.path,
        extension: file.path.split('.').last,
        mimeType: mimeType,
        size: size,
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
        durationInText:
            await getDurationInText(mediaInfo['durationMs'] as int?),
        isOrientationPortrait:
            width != null && height != null && width < height,
        isOrientationLandscape:
            width != null && height != null && width > height,
        isOrientationSquare: width != null && height != null && width == height,
      );
    } catch (e) {
      TalkerService.instance.error('Error getting file metadata: $e');
      return null;
    }
  }

  static (int? sec, int? min, int? hour) getDurationInSecMinHour(
      int? duration) {
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

  static Future<String?> getDurationInText(int? duration) async {
    if (duration == null) return null;
    try {
      final int hours = duration ~/ 3600000;
      final int minutes = (duration % 3600000) ~/ 60000;
      final int seconds = ((duration % 3600000) % 60000) ~/ 1000;
      return '${hours.toString().padLeft(2, '0')}:'
          '${minutes.toString().padLeft(2, '0')}:'
          '${seconds.toString().padLeft(2, '0')}';
    } catch (e) {
      print("Error formatting duration: $e");
      return null;
    }
  }

  static String getFileSize(int bytes) {
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
      'YB'
    ];
    int i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(2)} ${suffixes[i]}';
  }

  static showMetaData(FileMetaData? metaData) {
    if (!kTestingMode) return;
    if (metaData == null) return;
    Map<String, dynamic> data = metaData.toMap();
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
