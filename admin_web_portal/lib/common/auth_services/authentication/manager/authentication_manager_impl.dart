import 'package:admin_web_portal/common/auth_services/authentication/provider/email/email_authentication_provider.dart';

import '../../../app_storage/app_storage.dart';
import '../../../app_storage/constants/app_storage_keys.dart';
import '../../../di/injector.dart';
import '../../../extensions/snack_bar.dart';
import '../../../navigation/navigation_service.dart';
import '../../token/token_manager.dart';
import '../enum/authentication_type.dart';
import '../provider/authentication_provider.dart';
import 'authentication_manager.dart';

class AuthenticationManagerImpl implements AuthenticationManager {
  @override
  Future<bool> authenticateUser(AuthenticationType authenticationType) async {
    ///Temporary added the following code for Authentication.
    ///-------------
    AuthenticationProvider authenticationProvider =
        _getAuthenticationProvider(authenticationType);

    try {
      var token = await authenticationProvider.authenticate();
      if (token != null) {
        await injector<TokenManager>()
            .saveTokenSecurely(token, authenticationType);
        return true;
      } else {
        return false;
      }
    } catch (exception) {
      var context = NavigationService.navigatorKey.currentContext;
      if (context != null) {
        Future.delayed(Duration.zero).then(
          (value) => context.showSnackbar(exception.toString(), isError: true),
        );
      }
      return false;
    }

    ///-------------
  }

  @override
  Future<String?> authenticateSilently(
      AuthenticationType authenticationType) async {
    AuthenticationProvider authenticationProvider =
        _getAuthenticationProvider(authenticationType);
    try {
      var token = await authenticationProvider.authenticateSilently();
      return token;
    } catch (exception) {
      var context = NavigationService.navigatorKey.currentContext;
      if (context != null) {
        Future.delayed(Duration.zero).then(
          (value) => context.showSnackbar(exception.toString(), isError: true),
        );
      }
      return null;
    }
  }

  @override
  Future<bool> logout() async {
    try {
      ///1. Fetch Authentication type from Storage.
      var authenticationType =
          await AppStorage.fetchString(key: AppStorageKey.authenticationType);

      if (authenticationType != null) {
        ///2. Get Authentication Provider.
        var authenticationProvider = _getAuthenticationProvider(
            authenticationType.toAuthenticationType());

        await authenticationProvider.logout();

        await AppStorage.save(key: AppStorageKey.isAuthenticated, value: false);
        await AppStorage.save(key: AppStorageKey.authenticationType, value: "");
        return true;
      } else {
        return false;
      }
    } catch (exception) {
      var context = NavigationService.navigatorKey.currentContext;
      if (context != null) {
        Future.delayed(Duration.zero).then((value) =>
            context.showSnackbar(exception.toString(), isError: true));
      }
      return false;
    }
  }

  ///Provides AuthenticationProvider using AuthenticationType.
  AuthenticationProvider _getAuthenticationProvider(
      AuthenticationType authenticationType) {
    AuthenticationProvider authenticationProvider = EmailAuthenticationProvider();
    return authenticationProvider;
  }
}
