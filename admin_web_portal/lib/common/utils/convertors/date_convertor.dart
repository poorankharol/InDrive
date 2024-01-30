/// Handling conversions between UTC and local time.
///
/// Usage:
/// ```dart
/// Get the current UTC time
///    DateTime nowUtc = DateTime.now().toUtc();
///
///    Convert UTC time to local time
///    DateTime nowLocal = utcToLocal(nowUtc);
///    print("Local time: ${DateFormat.yMd().add_jm().format(nowLocal)}");
///
///    Convert local time back to UTC
///    DateTime backToUtc = localToUtc(nowLocal);
///    print("UTC time: ${DateFormat.yMd().add_jm().format(backToUtc)}");
/// ```
///
class DateConverter {
  // Converts a UTC DateTime object to local time.
  static DateTime utcToLocal(DateTime utcDateTime) {
    return utcDateTime.toLocal();
  }

  // Converts a local DateTime object to UTC.
  static DateTime localToUtc(DateTime localDateTime) {
    return localDateTime.toUtc();
  }
}
