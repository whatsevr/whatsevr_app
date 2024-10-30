import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<void> requestAllPermissions() async {
    final statuses = await <Permission>[
      Permission.notification,
      Permission.storage,
      Permission.camera,
      Permission.mediaLibrary,
      Permission.location,
    ].request();
    debugPrint('$statuses');
  }
}
