import 'dart:io';
import 'dart:math';

int? calculateAge(DateTime birthDate) {
  final DateTime currentDate = DateTime.now();
  final int age = currentDate.year - birthDate.year;
  final int month1 = currentDate.month;
  final int month2 = birthDate.month;
  final int day1 = currentDate.day;
  final int day2 = birthDate.day;
  if (month2 > month1) {
    return age - 1;
  }
  if (month1 == month2) {
    if (day2 > day1) {
      return age - 1;
    }
  }
  return age;
}

Future<String?> getFileSize(File file) async {
  try {
    int bytes = await file.length();
    if (bytes <= 0) return '0 B';
    const List<String> suffixes = <String>[
      'B',
      'KB',
      'MB',
      'GB',
      'TB',
      'PB',
      'EB',
      'ZB',
      'YB'
    ];
    int i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(2)} ${suffixes[i]}';
  } catch (e) {
    return null;
  }
}

String formatCountToKMBTQ(int? count) {
  String formatWithNoTrailingZero(double value) {
    if (value % 1 == 0) {
      return value.toStringAsFixed(0); // No decimal place for whole numbers
    } else {
      return value
          .toStringAsFixed(1); // One decimal place for non-whole numbers
    }
  }

  if (count == null) {
    return '0';
  } else if (count >= 1e15) {
    return '${formatWithNoTrailingZero(count / 1e15)}Q'; // Quadrillion
  } else if (count >= 1e12) {
    return '${formatWithNoTrailingZero(count / 1e12)}T'; // Trillion
  } else if (count >= 1e9) {
    return '${formatWithNoTrailingZero(count / 1e9)}B'; // Billion
  } else if (count >= 1e6) {
    return '${formatWithNoTrailingZero(count / 1e6)}M'; // Million
  } else if (count >= 1e3) {
    return '${formatWithNoTrailingZero(count / 1e3)}K'; // Thousand
  } else {
    return count.toString(); // Small values returned as-is
  }
}

// Helper function to format numbers and remove ".0" if not needed.
