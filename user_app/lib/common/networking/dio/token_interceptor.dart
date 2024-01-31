import 'package:dio/dio.dart';

import '../../auth_services/token/token_manager.dart';
import '../../di/injector.dart';

/// Handles fetching updated token and setting as a header in every API request.
class TokenInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var token = await injector<TokenManager>().getSecurelyStoredToken();
    options.headers['Authorization'] = "Bearer $token";
    super.onRequest(options, handler);
  }
}
