import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

Future<File> uint8BytesToFile(Uint8List bytes) async {
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
    throw Exception('Error converting bytes to file: $e');
  }
}

Future<Uint8List> fileToUint8List(File file) async {
  return await file.readAsBytes();
}
