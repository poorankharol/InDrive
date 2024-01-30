import 'package:flutter/material.dart';

import 'component_themes/app_bar_themes.dart';
import 'component_themes/app_button_themes.dart';
import 'component_themes/app_decoration_theme.dart';
import 'component_themes/app_dialog_theme.dart';
import 'component_themes/app_text_themes.dart';
import 'component_themes/snackbar_theme.dart';
import 'core/app_colors.dart';
import 'core/app_font_family.dart';

sealed class AppThemes {
  static final ThemeData themeLight = ThemeData.light().copyWith(
    primaryColor: AppColors.primary,
    textTheme: AppTextThemes.textThemeLight
        .apply(fontFamily: AppFontFamily.montserrat),
    appBarTheme: AppBarThemes.themeLight,
    scaffoldBackgroundColor: AppColors.background,
    floatingActionButtonTheme: AppButtonThemes.fabThemeLight,
    elevatedButtonTheme: AppButtonThemes.elevatedButtonThemeLight,
    outlinedButtonTheme: AppButtonThemes.outlinedButtonThemeLight,
    textButtonTheme: AppButtonThemes.textButtonThemeLight,
    dialogTheme: AppDialogTheme.dialogThemeLight,
    inputDecorationTheme: AppDecorationTheme.lightInputDecorationTheme,
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: AppColors.primary),
    snackBarTheme: SnackbarTheme.lightSnackbarTheme,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.background,
      selectedIconTheme: IconThemeData(
        color: AppColors.primary,
      ),
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.grey
    ),
  );

  static final ThemeData themeDark = ThemeData.dark().copyWith(
    primaryColor: AppColors.primaryDark,
    textTheme:
        AppTextThemes.textThemeDark.apply(fontFamily: AppFontFamily.montserrat),
    appBarTheme: AppBarThemes.themeDark,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    floatingActionButtonTheme: AppButtonThemes.fabThemeDark,
    elevatedButtonTheme: AppButtonThemes.elevatedButtonThemeDark,
    outlinedButtonTheme: AppButtonThemes.outlinedButtonThemeDark,
    textButtonTheme: AppButtonThemes.textButtonThemeDark,
    dialogTheme: AppDialogTheme.dialogThemeDark,
    inputDecorationTheme: AppDecorationTheme.darkInputDecorationTheme,
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: AppColors.primaryDark),
    snackBarTheme: SnackbarTheme.darkSnackbarTheme,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.backgroundDark,
        selectedIconTheme: IconThemeData(
          color: AppColors.primary,
        ),
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey
    ),
  );
}
