import 'package:dio/dio.dart';

import '../constants/api_constants.dart';
import 'token_interceptor.dart';

/// Get instance of dio client with configured base url and token interceptor
Dio buildDioClient() {
  final dio = Dio();
  dio.options.baseUrl = ApiConstants.baseUrl;
  dio.interceptors.add(TokenInterceptor());
  return dio;
}
