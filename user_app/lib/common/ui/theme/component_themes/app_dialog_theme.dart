import 'package:flutter/material.dart';

import 'app_text_themes.dart';

sealed class AppDialogTheme {
  static final dialogThemeLight = DialogTheme(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    titleTextStyle: AppTextThemes.textThemeLight.titleLarge?.copyWith(color: Colors.black),
    contentTextStyle: AppTextThemes.textThemeLight.bodyMedium?.copyWith(color: Colors.black45),
  );

  static final dialogThemeDark = DialogTheme(
    backgroundColor: Colors.grey[400],
    surfaceTintColor: Colors.grey[400],
    titleTextStyle: AppTextThemes.textThemeLight.titleLarge?.copyWith(color: Colors.grey[800]),
    contentTextStyle: AppTextThemes.textThemeLight.bodyMedium?.copyWith(color: Colors.grey[600]),
  );
}
