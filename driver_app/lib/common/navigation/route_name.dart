/// Contains named routes for navigation within the application.
/// Contains constant strings representing route names.
///
/// Usage:
/// ```dart
/// Navigator.pushNamed(context, RouteName.authenticationScreen);
/// ```
sealed class RouteName {
  /// Root route, typically used for splash screens or initial loading states.
  static const String initialRoute = "/";
  static const String homeScreen = "/home";
  static const String loginScreen = "/login";
  static const String registerScreen = "/register";
}
