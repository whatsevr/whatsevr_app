import 'package:get_time_ago/get_time_ago.dart';
import 'package:intl/intl.dart';

import 'package:whatsevr_app/dev/talker.dart';

String? calculateAgeInYearsAndMonth(DateTime birthDate) {
  try {
    final currentDate = DateTime.now();
    final years = currentDate.year - birthDate.year;
    final months = currentDate.month - birthDate.month;
    final days = currentDate.day - birthDate.day;

    if (years < 0) {
      return null;
    }

    if (months < 0) {
      return '$years years';
    }

    if (months == 0) {
      return '$years years';
    }

    if (days < 0) {
      return '$years years ${months - 1} months';
    }

    return '$years years $months months';
  } catch (e) {
    TalkerService.instance.error('Error calculating age: $e');
    return null;
  }
}

String? formatCountToKMBTQ(int? count) {
  try {
    String formatWithNoTrailingZero(double value) {
      if (value % 1 == 0) {
        return value.toStringAsFixed(0); // No decimal place for whole numbers
      } else {
        return value
            .toStringAsFixed(1); // One decimal place for non-whole numbers
      }
    }

    if (count == null) {
      return null;
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
  } catch (e) {
    TalkerService.instance.error('Error formatting count: $e');
    return null;
  }
}

String? getDurationInText(int? duration) {
  if (duration == null) return null;
  try {
    final hours = duration ~/ 3600;
    final minutes = (duration % 3600) ~/ 60;
    final seconds = duration % 60;
    if (hours > 0) {
      return '$hours h ${minutes > 0 ? '$minutes m' : ''} ${seconds > 0 ? '$seconds sec' : ''}';
    } else if (minutes > 0) {
      return '$minutes m ${seconds > 0 ? '$seconds s' : ''}';
    } else {
      return '$seconds s';
    }
  } catch (e) {
    TalkerService.instance.error('Error formatting duration: $e');
    return null;
  }
}

String? ddMMyyyy(DateTime? date) {
  if (date == null) return null;
  return DateFormat('dd/MM/yyyy').format(date);
}

String? ddMonthyy(DateTime? date) {
  if (date == null) return null;
  return DateFormat('dd MMM yyyy').format(date);
}

String ddMMMTime(DateTime date) {
  return DateFormat('dd MMM, hh:mm a').format(date);
}

class GetTimeAgoMessages implements Messages {
  /// Prefix added before the time message.
  @override
  String prefixAgo() => '';

  /// Suffix added after the time message.
  @override
  String suffixAgo() => 'ago';

  /// Message when the elapsed time is less than 15 seconds.
  @override
  String justNow(int seconds) => '$seconds sec';

  /// Message for when the elapsed time is less than a minute.
  @override
  String secsAgo(int seconds) => '$seconds sec';

  /// Message for when the elapsed time is about a minute.
  @override
  String minAgo(int minutes) => '$minutes min';

  /// Message for when the elapsed time is in minutes.
  @override
  String minsAgo(int minutes) => '$minutes min';

  /// Message for when the elapsed time is about an hour.
  @override
  String hourAgo(int minutes) => '$minutes min';

  /// Message for when the elapsed time is in hours.
  @override
  String hoursAgo(int hours) => '$hours hr';

  /// Message for when the elapsed time is about a day.
  @override
  String dayAgo(int hours) => '1 day';

  /// Message for when the elapsed time is in days.
  @override
  String daysAgo(int days) => '$days days';

  /// Word separator to be used when joining the parts of the message.
  @override
  String wordSeparator() => ' ';
}
