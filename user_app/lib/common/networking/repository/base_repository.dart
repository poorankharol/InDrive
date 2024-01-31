import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../utils/internet_connectivity.dart';

abstract class BaseRepository {
  Future<T> execute<T>({
    required Future<HttpResponse<T>> Function() request,
  }) async {
    try {
      if (!await Internet.isAvailable) {
        throw Exception("No internet connection"); // TODO: Create exceptions
      }

      final httpResponse = await request();

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return httpResponse.data;
      } else {
        throw DioException(
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
        );
      }
    } on DioException catch (_) {
      rethrow;
    }
  }
}
// TODO: Refer: cellbadge project for networking layer
