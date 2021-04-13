part of 'http_service.dart';

enum HttpExceptionType {
  /// It occurs when url is opened timeout.
  connectTimeout,

  /// It occurs when url is sent timeout.
  sendTimeout,

  ///It occurs when receiving timeout.
  receiveTimeout,

  /// When the server response, but with a incorrect status, such as 404, 503...
  response,

  /// When the request is cancelled, dio will throw a error with this type.
  cancel,

  /// Default error type, Some other Error. In this case, you can
  /// use the DioError.error if it is not null.
  other,
}

class HttpException implements Exception {
  const HttpException({
    this.response,
    required this.type,
    this.error,
  });

  factory HttpException.fromDioError(DioError error) {
    HttpExceptionType type;
    switch (error.type) {
      case DioErrorType.response:
        type = HttpExceptionType.response;
        break;
      case DioErrorType.other:
        type = HttpExceptionType.other;
        break;
      case DioErrorType.cancel:
        type = HttpExceptionType.cancel;
        break;
      case DioErrorType.sendTimeout:
        type = HttpExceptionType.sendTimeout;
        break;
      case DioErrorType.receiveTimeout:
        type = HttpExceptionType.receiveTimeout;
        break;
      case DioErrorType.connectTimeout:
        type = HttpExceptionType.connectTimeout;
        break;
    }

    HttpResponse? response;
    if (error.response != null) {
      response = HttpResponse.fromDioResponse(error.response!);
    }
    return HttpException(
      response: response,
      type: type,
      error: error.error,
    );
  }

  final HttpResponse? response;
  final HttpExceptionType type;
  final dynamic? error;
}
