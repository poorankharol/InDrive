import 'package:flutter/material.dart';

/// Provides a centralized service for managing navigation within the application.
sealed class NavigationService {
  /// Global key used to access the app's NavigatorState, allowing navigation
  /// from anywhere in the codebase without requiring direct context.
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
