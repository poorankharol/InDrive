import 'dart:ui';

///This class contains constants of Language Codes and list of Language Locale that will be used for the app.
sealed class Languages{
  //Declare the language codes required for the app here.
  static const String english = "en";
  static const String hindi = "hi";

  //Add list of Locale.
  static const List<Locale> localeList = [
    Locale(english),
    //Locale(hindi),
  ];
}
