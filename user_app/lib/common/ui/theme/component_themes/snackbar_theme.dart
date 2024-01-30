import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import 'app_text_themes.dart';

sealed class SnackbarTheme{
  static final lightSnackbarTheme = SnackBarThemeData(
    backgroundColor: AppColors.primary,
    contentTextStyle: AppTextThemes.textThemeLight.bodyMedium?.copyWith(color: Colors.white),
    actionBackgroundColor: AppColors.primary.withOpacity(0.8),
    actionTextColor: AppColors.onPrimary,
  );

  static final darkSnackbarTheme = SnackBarThemeData(
    backgroundColor: AppColors.primaryDark,
    contentTextStyle: AppTextThemes.textThemeLight.bodyMedium?.copyWith(color: Colors.white),
    actionBackgroundColor: Colors.black87,
    actionTextColor: AppColors.onPrimaryDark,
  );
}
