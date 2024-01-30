import 'package:flutter/material.dart';

sealed class AppColors {
  static const Color primary = Color(0xFF21A2DA);
  static const Color secondary = Color(0xFFFF974D);
  static const Color background = Color(0xFFFFFFFF);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color text = Color(0xFF333333);
  static const Color grey = Color(0xFF808080);

  // Colors for Dark Mode.
  static const Color primaryDark = Color(0xFF272F33);
  static const Color secondaryDark = Color(0xFF4D4038);
  static const Color backgroundDark = Color(0xFFBEBEBE);
  static const Color onPrimaryDark = Color(0xFFEEEEEE);
  static const Color textDark = Color(0xFF111111);
}
