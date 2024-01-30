import 'package:internet_connection_checker/internet_connection_checker.dart';

class Connectivity {
  static final _internetConnectionChecker = InternetConnectionChecker();

  static Future<bool> get isAvailable async {
    return await _internetConnectionChecker.hasConnection;
  }
}
