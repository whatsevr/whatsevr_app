import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:whatsevr_app/config/services/device_info.dart';

class PermissionService {
  static final Map<Permission, String> _androidPermissions = {
    Permission.notification: 'Notifications',
    Permission.camera: 'Camera',
    Permission.photos: 'Photos',
    Permission.videos: 'Videos',
    Permission.audio: 'Audio',
    Permission.storage: 'Storage',
    Permission.location: 'Location',
    Permission.microphone: 'Microphone',
  };

  static final Map<Permission, String> _iosPermissions = {
    Permission.notification: 'Notifications',
    Permission.camera: 'Camera',
    Permission.photos: 'Photos',
    Permission.location: 'Location',
    Permission.microphone: 'Microphone',
    Permission.mediaLibrary: 'Media Library',
  };

  static Map<Permission, String> get permissionNames {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return _iosPermissions;
    }

    // For Android, check version and filter permissions accordingly
    return DeviceInfoService.currentDeviceInfo?.isAndroid13OrHigher == true
        ? Map.fromEntries(
            _androidPermissions.entries
                .where((entry) => entry.key != Permission.storage),
          )
        : _androidPermissions;
  }

  static String getPermissionStatusMessage(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        return 'Permission granted';
      case PermissionStatus.denied:
        return 'Permission denied';
      case PermissionStatus.permanentlyDenied:
        return 'Permission permanently denied, please open settings';
      case PermissionStatus.restricted:
        return 'Permission restricted';
      case PermissionStatus.limited:
        return 'Permission limited';
      default:
        return 'Unknown status';
    }
  }

  static Future<Map<Permission, PermissionStatus>>
      requestAllPermissions() async {
    try {
      final Map<Permission, PermissionStatus> statuses = {};

      if (defaultTargetPlatform == TargetPlatform.iOS) {
        for (var permission in _iosPermissions.keys) {
          statuses[permission] = await permission.request();
        }
      } else {
        // Android platform
        if (DeviceInfoService.currentDeviceInfo?.isAndroid13OrHigher == true) {
          final mediaPermissions = [
            Permission.photos,
            Permission.videos,
            Permission.audio,
            ...permissionNames.keys.where(
              (p) =>
                  p != Permission.storage &&
                  ![Permission.photos, Permission.videos, Permission.audio]
                      .contains(p),
            ),
          ];
          for (var permission in mediaPermissions) {
            statuses[permission] = await permission.request();
          }
        } else {
          final permissions = permissionNames.keys.where(
            (p) => ![
              Permission.photos,
              Permission.videos,
              Permission.audio,
            ].contains(p),
          );
          for (var permission in permissions) {
            statuses[permission] = await permission.request();
          }
        }
      }
      return statuses;
    } catch (e) {
      debugPrint('Error requesting permissions: $e');
      return {};
    }
  }

  static Future<Map<String, bool>> checkPermissionStatuses() async {
    final Map<String, bool> permissions = {};
    final currentPermissions = await _getCurrentPlatformPermissions();

    for (var permission in currentPermissions.keys) {
      permissions[permission.toString()] = await permission.isGranted;
    }

    return permissions;
  }

  static Future<Map<Permission, String>>
      _getCurrentPlatformPermissions() async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return _iosPermissions;
    }

    final isAndroid13Plus =
        DeviceInfoService.currentDeviceInfo?.isAndroid13OrHigher == true;
    if (isAndroid13Plus) {
      return Map.fromEntries(
        _androidPermissions.entries
            .where((entry) => entry.key != Permission.storage),
      );
    }

    return _androidPermissions;
  }

  static Future<bool> requestPermission(Permission permission) async {
    final status = await permission.request();
    return status.isGranted;
  }

  static Future<bool> checkPermission(Permission permission) async {
    return await permission.isGranted;
  }

  static Future<bool> checkPermissionGroup(List<Permission> permissions) async {
    try {
      for (var permission in permissions) {
        if (!await permission.isGranted) {
          return false;
        }
      }
      return true;
    } catch (e) {
      debugPrint('Error checking permission group: $e');
      return false;
    }
  }

  static Future<void> handlePermanentlyDenied(Permission permission) async {
    if (await permission.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  static Future<bool> shouldShowRationale(Permission permission) async {
    if (defaultTargetPlatform != TargetPlatform.android) return false;
    return await permission.shouldShowRequestRationale;
  }

  static void openSettings() {
    openAppSettings();
  }

  // Helper method to get all media permissions
  static List<Permission> get mediaPermissions => [
        Permission.photos,
        Permission.videos,
        Permission.audio,
        if (defaultTargetPlatform == TargetPlatform.iOS)
          Permission.mediaLibrary,
      ];
}
