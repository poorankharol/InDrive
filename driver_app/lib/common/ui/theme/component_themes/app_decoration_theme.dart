import 'package:flutter/material.dart';

import '../core/app_colors.dart';

sealed class AppDecorationTheme {
  //Light InputDecorationTheme.
  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.primary, width: 1.0),
      borderRadius: BorderRadius.circular(5.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.primary, width: 1.0),
      borderRadius: BorderRadius.circular(5.0),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.grey, width: 1.0),
      borderRadius: BorderRadius.circular(5.0),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red, width: 1.0),
      borderRadius: BorderRadius.circular(5.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red, width: 1.0),
      borderRadius: BorderRadius.circular(5.0),
    ),
    hintStyle: TextStyle(color: Colors.grey[700]),
    labelStyle: const TextStyle(color: Colors.black87),
    filled: true,
    fillColor: Colors.white,
    suffixIconColor: AppColors.text,
    errorStyle:
        const TextStyle(color: Colors.red, fontWeight: FontWeight.normal),
  );

  //Dark InputDecorationTheme.
  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.primaryDark, width: 1.0),
      borderRadius: BorderRadius.circular(5.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.primaryDark, width: 1.0),
      borderRadius: BorderRadius.circular(5.0),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.grey, width: 1.0),
      borderRadius: BorderRadius.circular(5.0),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 1.0),
      borderRadius: BorderRadius.circular(5.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red, width: 1.0),
      borderRadius: BorderRadius.circular(5.0),
    ),
    hintStyle: TextStyle(color: Colors.grey[700]),
    labelStyle: const TextStyle(color: Colors.black87),
    filled: true,
    fillColor: Colors.grey[200],
    suffixIconColor: AppColors.text,
    errorStyle:
        const TextStyle(color: Colors.red, fontWeight: FontWeight.normal),
  );
}
