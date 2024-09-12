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
    const List<String> suffixes = <String>['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
    int i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(2)} ${suffixes[i]}';
  } catch (e) {
    return null;
  }
}
