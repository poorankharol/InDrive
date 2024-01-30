abstract class LanguageEvent{
  final String? languageCode;

  const LanguageEvent({this.languageCode});
}

class FetchCurrentAppLanguage extends LanguageEvent{
  const FetchCurrentAppLanguage();
}

class SaveAppLanguage extends LanguageEvent{
  const SaveAppLanguage(String languageCode) : super(languageCode: languageCode);
}