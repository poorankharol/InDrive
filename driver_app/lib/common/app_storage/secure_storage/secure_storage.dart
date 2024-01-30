import 'package:flutter_secure_storage/flutter_secure_storage.dart';

///Manages storing and fetching of secured data
sealed class SecureStorage {
  static const _storage = FlutterSecureStorage();

  ///Save secured string value for specified storage key.
  static Future<void> saveString(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  ///Fetch secured string from specified storage key.
  static Future<String?> fetchString(String key) async {
    return _storage.read(key: key);
  }

  ///Save secured boolean value for specified storage key.
  static Future<void> saveBoolean(String key, bool value) async {
    await _storage.write(
      key: key,
      value: value.toString(),
    );
  }

  ///Fetch secured boolean value from specified storage key.
  static Future<bool?> fetchBoolean(String key) async {
    final optionalValue = await _storage.read(key: key);
    if (optionalValue != null) {
      return bool.tryParse(optionalValue);
    }
    return null;
  }

  ///Save secured integer value for specified storage key.
  static Future<void> saveInt(String key, int value) async {
    await _storage.write(key: key, value: value.toString());
  }

  ///Fetch secured integer value from storage key.
  static Future<int?> fetchInt(String key) async {
    final optionalValue = await _storage.read(key: key);
    if (optionalValue != null) {
      return int.tryParse(optionalValue);
    }
    return null;
  }

  ///Save secured double value for specified storage key.
  static Future<void> saveDouble(String key, double value) async {
    await _storage.write(key: key, value: value.toString());
  }

  ///Fetch secured double value from storage key.
  static Future<double?> fetchDouble(String key) async {
    final optionalValue = await _storage.read(key: key);
    if (optionalValue != null) {
      return double.tryParse(optionalValue);
    }
    return null;
  }

  ///Delete all saved secured data.
  static Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}
