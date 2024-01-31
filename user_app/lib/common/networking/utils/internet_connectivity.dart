import 'package:internet_connection_checker/internet_connection_checker.dart';

/// Checks for internet connection
///
/// ```dart
/// if (await Internet.isAvailable) {
///    // perform api call
/// }
/// ```
sealed class Internet {
  static final _internetConnectionChecker = InternetConnectionChecker();

  static Future<bool> get isAvailable async {
    return await _internetConnectionChecker.hasConnection;
  }
}
