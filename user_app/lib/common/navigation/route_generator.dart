import 'package:flutter/material.dart';
import 'package:user_app/features/home/presentation/screen/home_screen.dart';
import 'package:user_app/features/login/presentation/screen/login_screen.dart';
import 'package:user_app/features/register/presentation/screen/register_screen.dart';

import '../../features/search/presentation/screen/search_screen.dart';
import '../ui/empty_states/navigation_error_screen.dart';
import 'route_name.dart';

/// Generates routes based on requested names.
sealed class RouteGenerator {
  /// Generates and returns the appropriate MaterialPageRoute for a given route name.
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.initialRoute:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case RouteName.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case RouteName.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case RouteName.searchScreen:
        return MaterialPageRoute(
          builder: (_) => const SearchScreen(),
        );

      /// Default case for unhandled routes:
      default:
        return MaterialPageRoute(builder: (_) => const NavigationErrorScreen());
    }
  }
}
