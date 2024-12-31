import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_region/device_region.dart';

import 'package:whatsevr_app/dev/talker.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import 'package:whatsevr_app/utils/aes.dart';

class DeviceInfo {
  DeviceInfo({
    required this.deviceId,
    required this.deviceName,
    required this.countryCode,
    required this.deviceOs,
    required this.isAndroid,
    required this.isAndroid13OrHigher,
    required this.isIos,
  });
  final String? deviceId;
  final String? deviceName;
  final String? countryCode;
  final String? deviceOs;
  final bool isAndroid;
  final bool isAndroid13OrHigher;
  final bool isIos;

  Map<String, dynamic> toMap() {
    return {
      'deviceId': deviceId,
      'deviceName': deviceName,
      'countryCode': countryCode,
      'deviceOs': deviceOs,
      'isAndroid': isAndroid,
      'isAndroid13OrHigher': isAndroid13OrHigher,
      'isIos': isIos,
    };
  }
}

class DeviceInfoService {
  DeviceInfoService._privateConstructor();

  static final DeviceInfoService _instance =
      DeviceInfoService._privateConstructor();
  static final AesService _aesService = AesService();

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
      final deviceData =
          '${androidInfo.id}_${androidInfo.fingerprint}_${androidInfo.bootloader}';
      final uniquedeviceId = _aesService.encrypt(deviceData);

      _currentDeviceInfo = DeviceInfo(
        deviceId: uniquedeviceId,
        deviceName: '${androidInfo.manufacturer} ${androidInfo.model}',
        countryCode: countryCode,
        deviceOs: 'android',
        isAndroid: true,
        isAndroid13OrHigher: androidInfo.version.sdkInt >= 33,
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
      final deviceData =
          '${iosInfo.identifierForVendor ?? ''}_${iosInfo.systemName}_${iosInfo.name}_${iosInfo.model}';
      final uniqueDeviceId = _aesService.encrypt(deviceData);

      _currentDeviceInfo = DeviceInfo(
        deviceId: uniqueDeviceId,
        deviceName: '${iosInfo.name} ${iosInfo.model}',
        countryCode: countryCode,
        deviceOs: 'ios',
        isAndroid: false,
        isAndroid13OrHigher: false,
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
