import 'dart:typed_data';
import 'package:geobase/geobase.dart';
import 'package:whatsevr_app/dev/talker.dart';

/// Utility class for handling Well-Known Binary (WKB) format conversions
/// for geographic points.
class WKBUtil {
  // Private constructor to prevent instantiation
  const WKBUtil._();

  /// Maximum valid latitude value
  static const double _maxLatitude = 90.0;

  /// Maximum valid longitude value
  static const double _maxLongitude = 180.0;

  /// Converts latitude and longitude to WKB hex string.
  /// Returns null if coordinates are invalid or conversion fails.
  static String? getWkbString({required double? lat, required double? long}) {
    if (!_isValidCoordinates(lat, long)) {
      TalkerService.instance
          .warning('Invalid coordinates: lat=$lat, long=$long');
      return null;
    }

    try {
      final point = Point.build([long!, lat!]);
      final wkbBytes = point.toBytes(format: WKB.geometry);
      return _bytesToHexString(wkbBytes);
    } catch (e, stackTrace) {
      TalkerService.instance.error(
        'Error converting coordinates to WKB',
        e,
        stackTrace,
      );
      return null;
    }
  }

  /// Converts WKB hex string to latitude and longitude tuple.
  /// Original method signature maintained for compatibility.
  static (double lat, double long)? getLatLong(String? wkbString) {
    if (!_isValidWkbString(wkbString)) {
      TalkerService.instance.warning('Invalid WKB string: $wkbString');
      return null;
    }

    try {
      final wkbBytes = Uint8List.fromList(_hexStringToBytes(wkbString!));
      final point = Point.decode(wkbBytes, format: WKB.geometry);
      final coords = point.position;

      final long = coords[0];
      final lat = coords[1];

      if (!_isValidCoordinates(lat, long)) {
        throw FormatException('Decoded coordinates out of valid range');
      }

      return (lat, long);
    } catch (e, stackTrace) {
      TalkerService.instance.error(
        'Error parsing WKB string',
        e,
        stackTrace,
      );
      return null;
    }
  }

  /// Private helper methods - add underscore
  static bool _isValidCoordinates(double? lat, double? long) {
    if (lat == null || long == null) return false;
    return lat.abs() <= _maxLatitude &&
        long.abs() <= _maxLongitude &&
        !lat.isNaN &&
        !long.isNaN;
  }

  static bool _isValidWkbString(String? wkb) {
    if (wkb == null || wkb.isEmpty) return false;
    return RegExp(r'^[0-9A-Fa-f]+$').hasMatch(wkb) && wkb.length % 2 == 0;
  }

  static String _bytesToHexString(List<int> bytes) {
    return bytes
        .map((b) => b.toRadixString(16).padLeft(2, '0'))
        .join()
        .toUpperCase();
  }

  static List<int> _hexStringToBytes(String hex) {
    final normalized = hex.toLowerCase();
    return List<int>.generate(
      hex.length ~/ 2,
      (i) => int.parse(normalized.substring(i * 2, i * 2 + 2), radix: 16),
    );
  }
}
