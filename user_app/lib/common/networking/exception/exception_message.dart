/// Contains API request exception messages
sealed class ExceptionMessage {
  static const String requestToAPIServerWasCancelled =
      "Request to API server was cancelled";
  static const String connectionTimeoutWithAPIServer =
      "Connection timeout with API server";
  static const String receiveTimeoutInConnectionWithAPIServer =
      "Receive timeout in connection with API server";
  static const String sendTimeoutInConnectionWithAPIServer =
      "Send timeout in connection with API server";
  static const String socketException = "SocketException";
  static const String noInternet = "No Internet";
  static const String unexpectedErrorOccurred = "Unexpected error occurred";
  static const String somethingWentWrong = "Something went wrong";
  static const String badRequest = "Bad Request";
  static const String unauthorized = "Unauthorized";
  static const String forbidden = "Forbidden";
  static const String oopsSomethingWentWrong = "Oops something went wrong";
  static const String internalServerError = "Internal server error";
  static const String badGateway = "Bad gateway";
}
