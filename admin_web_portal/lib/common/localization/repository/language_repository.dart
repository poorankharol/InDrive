abstract class LanguageRepository {
  /// Fetching locale from shared preferences.
  ///
  /// Returns:
  ///     Language Code.
  Future<String> fetchLocale();

  /// Save locale in shared preferences.
  Future<bool> saveLocale(String languageCode);
}
