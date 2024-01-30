import 'package:flutter/material.dart';

import '../core/app_colors.dart';

sealed class AppBarThemes {
  static const themeLight = AppBarTheme(
    color: AppColors.primary,
    foregroundColor: AppColors.onPrimary,
    iconTheme: IconThemeData(color: AppColors.onPrimary),
    elevation: 0,
    scrolledUnderElevation: 0.0,
  );

  static const themeDark = AppBarTheme(
    color: AppColors.primaryDark,
    foregroundColor: AppColors.onPrimaryDark,
    iconTheme: IconThemeData(color: AppColors.onPrimaryDark),
    elevation: 0,
    scrolledUnderElevation: 0.0,
  );
}
