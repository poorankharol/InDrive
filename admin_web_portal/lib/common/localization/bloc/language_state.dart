import 'dart:ui';

abstract class LanguageState{
  final Locale? locale;
  final String? errorMessage;
  const LanguageState({this.locale,this.errorMessage});
}

class UpdateAppLanguage extends LanguageState{
  const UpdateAppLanguage(Locale locale) : super(locale: locale);
}

class AppLanguageUpdateFailed extends LanguageState{
  const AppLanguageUpdateFailed(String errorMessage) : super(errorMessage: errorMessage);
}