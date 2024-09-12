import 'dart:io';

import 'package:video_thumbnail/video_thumbnail.dart';

Future<File> getThumbnailFile(File videoFile) async {
  final String? tempPath = await VideoThumbnail.thumbnailFile(
    video: videoFile.path,
    imageFormat: ImageFormat.JPEG,
    quality: 70,
  );
  return File(tempPath!);
}
