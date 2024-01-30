import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import 'app_text_themes.dart';

sealed class AppButtonThemes {
  //region Floating Action Button Theme.
  static const fabThemeLight = FloatingActionButtonThemeData(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.onPrimary,
  );

  static const fabThemeDark = FloatingActionButtonThemeData(
    backgroundColor: AppColors.primaryDark,
    foregroundColor: AppColors.onPrimaryDark,
  );

  //endregion

  //region Elevated Button Theme.
  static final elevatedButtonThemeLight = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      foregroundColor: AppColors.onPrimary,
      backgroundColor: AppColors.primary,
      fixedSize: const Size(200, 50),
      textStyle: AppTextThemes.textThemeLight.titleMedium,
    ),
  );

  static final elevatedButtonThemeDark = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      foregroundColor: AppColors.onPrimaryDark,
      backgroundColor: AppColors.primaryDark,
      fixedSize: const Size(200, 50),
      textStyle: AppTextThemes.textThemeDark.titleMedium,
    ),
  );

  //endregion

  //region Outlined Button Theme.
  static final outlinedButtonThemeLight = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      foregroundColor: AppColors.primary,
      backgroundColor: AppColors.onPrimary,
      side: const BorderSide(color: AppColors.primary, width: 1.0),
      fixedSize: const Size(200, 50),
    ),
  );

  static final outlinedButtonThemeDark = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      foregroundColor: AppColors.primaryDark,
      backgroundColor: AppColors.onPrimaryDark,
      side: const BorderSide(color: AppColors.primaryDark, width: 1.0),
      fixedSize: const Size(200, 50),
    ),
  );

  //endregion

  //region Text Button Theme.
  static final textButtonThemeLight = TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: EdgeInsets.zero,
      foregroundColor: AppColors.primary,
    ),
  );

  static final textButtonThemeDark = TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: EdgeInsets.zero,
      foregroundColor: AppColors.primaryDark,
    ),
  );
//endregion
}
