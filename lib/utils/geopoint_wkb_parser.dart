import 'dart:typed_data';

import 'package:geobase/geobase.dart';

import '../dev/talker.dart';

class WKBUtil {
  WKBUtil._();

  static String? getWkbString({required double? lat, required double? long}) {
    if (lat == null || long == null) {
      return null;
    }
    try {
      final point = Point.build([long, lat]);

      final wkbBytes = point.toBytes(format: WKB.geometry);

      return _bytesToHexString(wkbBytes);
    } catch (e) {
      TalkerService.instance.error('Error getting WKB string: $e');
      return null;
    }
  }

  static (double lat, double long)? getLatLong(String? wkbString) {
    if (wkbString == null) {
      return null;
    }
    try {
      final wkbBytes =
          Uint8List.fromList(_hexStringToBytes(wkbString));

      final point = Point.decode(wkbBytes, format: WKB.geometry);

      final coords = point.position;
      final long = coords[0];
      final lat = coords[1];

      return (lat, long);
    } catch (e) {
      TalkerService.instance
          .error('Error getting lat long from WKB string: $e');
      return null;
    }
  }

  static String _bytesToHexString(List<int> bytes) {
    final buffer = StringBuffer();
    for (var byte in bytes) {
      buffer.write(byte.toRadixString(16).padLeft(2, '0'));
    }
    return buffer.toString().toUpperCase();
  }

  static List<int> _hexStringToBytes(String hex) {
    final length = hex.length;
    final bytes = <int>[];
    for (var i = 0; i < length; i += 2) {
      bytes.add(int.parse(hex.substring(i, i + 2), radix: 16));
    }
    return bytes;
  }
}
