import 'package:intl/intl.dart';

/// This class provides various functions for converting and manipulating dates.
///
/// ```
/// Usage:
///   DateFormatter.formatDate(DateTime.now(), 'yyyy-MM-dd HH:mm');
///
///   DateTime tomorrow = DateFormatter.addDays(nowLocal, 1);
///   DateConverter.formatDate(tomorrow, 'yyyy-MM-dd');
///
///   String dateString = "2024-11-21 15:30";
///   DateTime parsedDateTime = DateFormatter.parseDate(dateString, 'yyyy-MM-dd HH:mm');
///   print("Parsed date: ${parsedDateTime}");
///
///   Calculate the difference in days between two dates
///   DateTime date1 = DateTime(2023, 10, 24);
///   DateTime date2 = DateTime(2024, 01, 11);
///   int daysDiff = DateConverter.daysBetween(date1, date2);
///   print("Days between dates: $daysDiff");
/// ```
sealed class DateFormatter {
  static const String formatOne = "dd MMMM yyyy";
  static const String formatTwo = "MM-dd-yyyy";
  static const String formatThree = "MMMM dd,yyyy | hh:mm aa";
  static const String formatFour = "MM/dd/yyyy hh:mm aa";
  static const String timeFormatOne = "hh:mm aa";

  /// Formats a String object as a string using a specific format.
  static String formatDate(String dateString, {required String formatPattern}) {
    var date = DateTime.tryParse(dateString);
    return DateFormat(formatPattern).format(date!);
  }

  // Formats a DateTime object as a string using a specific format.
  static String formatDateTime(DateTime dateTime, String formatPattern) {
    return DateFormat(formatPattern).format(dateTime);
  }

  /// Parses a string into a DateTime object using a specific format.
  static DateTime parseDate(String dateString, String formatPattern) {
    return DateFormat(formatPattern).parse(dateString);
  }

  /// Adds or subtracts a specified number of days from a DateTime object.
  static DateTime addDays(DateTime dateTime, int daysToAdd) {
    return dateTime.add(Duration(days: daysToAdd));
  }

  /// Gets the difference between two DateTime objects in days.
  static int daysBetween(DateTime dateTime1, DateTime dateTime2) {
    return dateTime1.difference(dateTime2).inDays;
  }
}
