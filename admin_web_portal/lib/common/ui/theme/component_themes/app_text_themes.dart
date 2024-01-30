import 'package:flutter/material.dart';

import '../core/app_colors.dart';

sealed class AppTextThemes {
  //region Text Themes - Light and Dark.
  static const textThemeLight = TextTheme(
    titleLarge: _titleLarge,
    titleMedium: _titleMedium,
    titleSmall: _titleSmall,
    bodyLarge: _bodyLarge,
    bodyMedium: _bodyMedium,
    bodySmall: _bodySmall,
  );

  static final textThemeDark = TextTheme(
    titleLarge: _titleLargeDark,
    titleMedium: _titleMediumDark,
    titleSmall: _titleSmallDark,
    bodyLarge: _bodyLargeDark,
    bodyMedium: _bodyMediumDark,
    bodySmall: _bodySmallDark,
  );

  //endregion

  //region TextStyles - Light.
  static const TextStyle _bodyLarge = TextStyle(
    fontSize: 14.0,
    color: AppColors.text,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle _bodyMedium = TextStyle(
    fontSize: 16.0,
    color: AppColors.text,
  );

  static const TextStyle _bodySmall = TextStyle(
    fontSize: 14.0,
    color: AppColors.text,
  );

  static const TextStyle _titleLarge = TextStyle(
    fontSize: 24.0,
    color: AppColors.text,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle _titleMedium = TextStyle(
    fontSize: 16.0,
    color: AppColors.text,
  );

  static const TextStyle _titleSmall = TextStyle(
    fontSize: 14.0,
    color: AppColors.text,
  );

  //endregion

  //region TextStyles - Dark.
  static final TextStyle _bodyLargeDark = _bodyLarge.copyWith(
    color: AppColors.textDark,
  );
  static final TextStyle _bodyMediumDark = _bodyMedium.copyWith(
    color: AppColors.textDark,
  );
  static final TextStyle _bodySmallDark = _bodySmall.copyWith(
    color: AppColors.textDark,
  );
  static final TextStyle _titleLargeDark = _titleLarge.copyWith(
    color: AppColors.textDark,
  );
  static final TextStyle _titleMediumDark = _titleMedium.copyWith(
    color: AppColors.textDark,
  );
  static final TextStyle _titleSmallDark = _titleSmall.copyWith(
    color: AppColors.textDark,
  );
//endregion.
}
