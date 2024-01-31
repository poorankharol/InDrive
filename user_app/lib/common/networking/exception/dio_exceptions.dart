import 'package:dio/dio.dart';

import 'exception_message.dart';

// TODO: Update decoder class
sealed class DioExceptionDecoder {
  static String decode(DioException exception) {
    switch (exception.type) {
      // Cancelled
      case DioExceptionType.cancel:
        return ExceptionMessage.requestToAPIServerWasCancelled;

      // Time outs
      case DioExceptionType.connectionTimeout:
        return ExceptionMessage.connectionTimeoutWithAPIServer;
      case DioExceptionType.sendTimeout:
        return ExceptionMessage.sendTimeoutInConnectionWithAPIServer;
      case DioExceptionType.receiveTimeout:
        return ExceptionMessage.receiveTimeoutInConnectionWithAPIServer;

      // Responses
      case DioExceptionType.badResponse:
        return _handleError(
          exception.response?.statusCode,
          exception.response?.data,
        );

      case DioExceptionType.unknown:
        if ((exception.message ?? "")
            .contains(ExceptionMessage.socketException)) {
          return ExceptionMessage.noInternet;
        }
        return ExceptionMessage.unexpectedErrorOccurred;
      default:
        return ExceptionMessage.unexpectedErrorOccurred;
    }
  }

  static String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return error != null ? error['error'] : ExceptionMessage.badRequest;
      case 401:
        return ExceptionMessage.unauthorized;
      case 403:
        return ExceptionMessage.forbidden;
      case 404:
        return error == null || error == '' || error['message'] == null
            ? ExceptionMessage.oopsSomethingWentWrong
            : error['message'];
      case 500:
        return ExceptionMessage.internalServerError;
      case 502:
        return ExceptionMessage.badGateway;
      default:
        return ExceptionMessage.oopsSomethingWentWrong;
    }
  }
}
