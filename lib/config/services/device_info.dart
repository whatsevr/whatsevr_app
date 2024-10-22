import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_region/device_region.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import 'package:whatsevr_app/dev/talker.dart';

class DeviceInfo {
  DeviceInfo({
    required this.deviceName,
    required this.countryCode,
    required this.isAndroid,
    required this.isIos,
  });

  final String? deviceName;
  final String? countryCode;
  final bool isAndroid;
  final bool isIos;

  Map<String, dynamic> toMap() {
    return {
      'deviceName': deviceName,
      'countryCode': countryCode,
      'isAndroid': isAndroid,
      'isIos': isIos,
    };
  }
}

class DeviceInfoService {
  DeviceInfoService._privateConstructor();

  static final DeviceInfoService _instance =
      DeviceInfoService._privateConstructor();

  static DeviceInfoService get instance => _instance;

  static DeviceInfo? _currentDeviceInfo;

  static DeviceInfo? get currentDeviceInfo => _currentDeviceInfo;

  static Future<void> setDeviceInfo() async {
    if (_currentDeviceInfo != null) {
      return;
    }

    if (Platform.isAndroid) {
      await _setAndroidDeviceInfo();
    } else if (Platform.isIOS) {
      await _setIOSDeviceInfo();
    }
    TalkerService.instance.info('Device Info: ${_currentDeviceInfo?.toMap()}');
  }

  static Future<void> _setAndroidDeviceInfo() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      final AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      final String? countryCode = await _getCurrentCountryCode();
      _currentDeviceInfo = DeviceInfo(
        deviceName: androidInfo.model,
        countryCode: countryCode,
        isAndroid: true,
        isIos: false,
      );
    } catch (e, stackTrace) {
      lowLevelCatch(e, stackTrace);
    }
  }

  static Future<void> _setIOSDeviceInfo() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      final IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
      final String? countryCode = await _getCurrentCountryCode();
      _currentDeviceInfo = DeviceInfo(
        deviceName: iosInfo.utsname.machine,
        countryCode: countryCode,
        isAndroid: false,
        isIos: true,
      );
    } catch (e, stackTrace) {
      lowLevelCatch(e, stackTrace);
    }
  }

  static Future<String?> _getCurrentCountryCode() async {
    try {
      final String? countryCode = await DeviceRegion.getSIMCountryCode();
      return countryCode;
    } catch (e, stackTrace) {
      lowLevelCatch(e, stackTrace);
    }
    return null;
  }
}
