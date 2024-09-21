String? calculateAgeInYearsAndMonth(DateTime birthDate) {
  final DateTime currentDate = DateTime.now();
  final int years = currentDate.year - birthDate.year;
  final int months = currentDate.month - birthDate.month;
  final int days = currentDate.day - birthDate.day;

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
