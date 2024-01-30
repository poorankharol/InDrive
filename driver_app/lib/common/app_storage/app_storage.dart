import 'secure_storage/secure_storage.dart';
import 'shared_preference/shared_preference.dart';

sealed class AppStorage {
  /// Save any [value] of type [`String`, `bool`, `int` and `double`] into secured storage with specified [key].
  static Future<void> saveSecurely<T>(
      {required String key, required T value}) async {
    if (value is String) {
      return await SecureStorage.saveString(key, value);
    }
    if (value is bool) {
      return SecureStorage.saveBoolean(key, value);
    }
    if (value is int) {
      return SecureStorage.saveInt(key, value);
    }
    if (value is double) {
      return SecureStorage.saveDouble(key, value);
    }
  }

  /// Save any [value] of type [`String`, `bool`, `int` and `double`] into shared preferences with specified [key].
  static Future<void> save<T>({required String key, required T value}) async {
    if (value is String) {
      return SharedPreference.saveString(key, value);
    }
    if (value is bool) {
      return SharedPreference.saveBoolean(key, value);
    }
    if (value is int) {
      return SharedPreference.saveInt(key, value);
    }
    if (value is double) {
      return SharedPreference.saveDouble(key, value);
    }
  }

  /// Fetch string value from app storage
  ///
  /// Set [secured] as true if value is stored securely
  static Future<String?> fetchString({
    required String key,
    bool secured = false,
  }) async {
    if (secured) {
      return SecureStorage.fetchString(key);
    }
    return SharedPreference.fetchString(key);
  }

  /// Fetch boolean value from app storage
  ///
  /// Set [secured] as true if value is stored securely
  static Future<bool?> fetchBoolean({
    required String key,
    bool secured = false,
  }) async {
    if (secured) {
      return SecureStorage.fetchBoolean(key);
    }
    return SharedPreference.fetchBoolean(key);
  }

  /// Fetch integer value from app storage
  ///
  /// Set [secured] as true if value is stored securely
  static Future<int?> fetchInt({
    required String key,
    bool secured = false,
  }) async {
    if (secured) {
      return SecureStorage.fetchInt(key);
    }
    return SharedPreference.fetchInt(key);
  }

  /// Fetch double value from app storage
  ///
  /// Set [secured] as true if value is stored securely
  static Future<double?> fetchDouble({
    required String key,
    bool secured = false,
  }) async {
    if (secured) {
      return SecureStorage.fetchDouble(key);
    }
    return SharedPreference.fetchDouble(key);
  }

  /// Delete all securely stored data from application
  static Future<void> deleteAllSecuredData() async {
    return await SecureStorage.deleteAll();
  }

  /// Delete all non-securely stored data from application
  static Future<bool> deleteAllData() async {
    return await SharedPreference.deleteAll();
  }
}
