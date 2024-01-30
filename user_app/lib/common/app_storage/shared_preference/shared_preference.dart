import 'package:shared_preferences/shared_preferences.dart';

///Manages storing and fetching of user preferred data
sealed class SharedPreference {
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  ///Store string value with specified storage key.
  static Future<void> saveString(String key, String value) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString(key, value);
  }

  ///Fetch string from specified storage key.
  static Future<String?> fetchString(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(key);
  }

  ///Store boolean value with specified storage key.
  static Future<void> saveBoolean(String key, bool value) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setBool(key, value);
  }

  ///Fetch boolean value from specified storage key.
  static Future<bool?> fetchBoolean(String key) async {
    final prefs = await _prefs;
    return prefs.getBool(key);
  }

  ///Store integer value with specified storage key.
  static Future<void> saveInt(String key, int value) async {
    final prefs = await _prefs;
    await prefs.setInt(key, value);
  }

  ///Fetch integer value from specified storage key.
  static Future<int?> fetchInt(String key) async {
    final prefs = await _prefs;
    return prefs.getInt(key);
  }

  ///Store double value with specified storage key.
  static Future<void> saveDouble(String key, double value) async {
    final prefs = await _prefs;
    await prefs.setDouble(key, value);
  }

  ///Fetch double value from specified storage key.
  static Future<double?> fetchDouble(String key) async {
    final prefs = await _prefs;
    return prefs.getDouble(key);
  }

  ///Delete all stored preferences.
  static Future<bool> deleteAll() async {
    final prefs = await _prefs;
    return await prefs.clear();
  }
}
