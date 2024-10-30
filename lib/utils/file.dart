import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import '../config/api/external/models/business_validation_exception.dart';
import '../dev/talker.dart';

Future<File?> uint8BytesToFile(Uint8List bytes) async {
  try {
    // Get the application documents directory
    final Directory appDocDir = await getTemporaryDirectory();
    final String appDocPath = appDocDir.path;
    final String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    // Create the file path
    final File file = File('$appDocPath/$fileName');

    // Write the byte array to the file
    return await file.writeAsBytes(bytes);
  } catch (e) {
    TalkerService.instance.error('Error converting bytes to file: $e');
    return null;
  }
}

Future<Uint8List?> fileToUint8List(File file) async {
  try {
    return await file.readAsBytes();
  } catch (e) {
    TalkerService.instance.error('Error converting file to bytes: $e');
    return null;
  }
}

Future<File?> compressImage(
  File? file, {
  int quality = 70,
  int maxWidth = 1080,
  int maxHeight = 1080,
}) async {
  try {
    if (file == null) return null;
    final XFile? result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      '${(await getTemporaryDirectory()).path}/compressed_image_${DateTime.now().millisecondsSinceEpoch}.${file.path.split('.').last}',
      quality: quality,
      minWidth: 500,
      minHeight: 500,
    );
    if (result == null) return null;
    return File(result.path);
  } catch (e, stackTrace) {
    lowLevelCatch(e, stackTrace);
    return null;
  }
}
