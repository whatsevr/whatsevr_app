import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_region/device_region.dart';

import '../../dev/talker.dart';
import '../api/external/models/business_validation_exception.dart';

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
    final deviceInfoPlugin = DeviceInfoPlugin();
    try {
      final androidInfo = await deviceInfoPlugin.androidInfo;
      final countryCode = await _getCurrentCountryCode();
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
    final deviceInfoPlugin = DeviceInfoPlugin();
    try {
      final iosInfo = await deviceInfoPlugin.iosInfo;
      final countryCode = await _getCurrentCountryCode();
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
      final countryCode = await DeviceRegion.getSIMCountryCode();
      return countryCode;
    } catch (e, stackTrace) {
      lowLevelCatch(e, stackTrace);
    }
    return null;
  }
}
