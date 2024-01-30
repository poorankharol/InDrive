import 'package:driver_app/features/dashboard/presentation/screen/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/features/login/presentation/screen/login_screen.dart';
import 'package:driver_app/features/register/presentation/screen/register_screen.dart';

import '../ui/empty_states/navigation_error_screen.dart';
import 'route_name.dart';

/// Generates routes based on requested names.
sealed class RouteGenerator {
  /// Generates and returns the appropriate MaterialPageRoute for a given route name.
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.registerScreen:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case RouteName.initialRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case RouteName.homeScreen:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());

      /// Default case for unhandled routes:
      default:
        return MaterialPageRoute(builder: (_) => const NavigationErrorScreen());
    }
  }
}
