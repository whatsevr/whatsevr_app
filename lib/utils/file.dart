import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:whatsevr_app/dev/talker.dart';

Future<File?> uint8BytesToFile(Uint8List bytes) async {
  try {
    // Get the application documents directory
    Directory appDocDir = await getTemporaryDirectory();
    String appDocPath = appDocDir.path;
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    // Create the file path
    File file = File('$appDocPath/$fileName');

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
