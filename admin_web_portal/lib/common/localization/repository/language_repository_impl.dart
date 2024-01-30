import '../../app_storage/app_storage.dart';
import '../../app_storage/constants/app_storage_keys.dart';
import '../constants/languages.dart';
import 'language_repository.dart';

class LanguageRepositoryImpl implements LanguageRepository {
  @override
  Future<String> fetchLocale() async {
    var savedLanguageCode = await AppStorage.fetchString(
        key: AppStorageKey.appLanguage, secured: true);
    var languageCode = savedLanguageCode ?? Languages.english;
    return Future.value(languageCode);
  }

  @override
  Future<bool> saveLocale(String languageCode) async {
    try {
      await AppStorage.saveSecurely(
          key: AppStorageKey.appLanguage, value: languageCode);
      return Future.value(true);
    } catch (error) {
      return Future.value(false);
    }
  }
}
