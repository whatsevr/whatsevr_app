import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

Future<File> uint8BytesToFile(Uint8List bytes, String fileName) async {
  // Get the application documents directory
  Directory appDocDir = await getTemporaryDirectory();
  String appDocPath = appDocDir.path;

  // Create the file path
  File file = File('$appDocPath/$fileName');

  // Write the byte array to the file
  return await file.writeAsBytes(bytes);
}
