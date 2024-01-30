import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension BuildContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  NavigatorState get navigator => Navigator.of(this);

  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  AppLocalizations get appLocale => AppLocalizations.of(this);
}
