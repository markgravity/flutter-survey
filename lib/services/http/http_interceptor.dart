part of 'http_service.dart';

abstract class HttpInterceptor {
  String get identifier;

  void onException(
    HttpException exception,
    HttpExceptionInterceptorHandler handler,
  ) =>
      handler.next(exception);

  Interceptor toInterceptor(Dio dio) {
    return InterceptorsWrapper(onError: (e, handler) {
      onException(
        HttpException.fromDioError(e),
        HttpExceptionInterceptorHandler._(dio: dio, handler: handler),
      );
    });
  }
}

class HttpExceptionInterceptorHandler {
  const HttpExceptionInterceptorHandler._({
    required Dio dio,
    required ErrorInterceptorHandler handler,
  })  : _dio = dio,
        _handler = handler;

  final ErrorInterceptorHandler _handler;
  final Dio _dio;

  void next(HttpException exception) {
    _handler.next(exception.error as DioError);
  }

  void reject(HttpException exception) {
    _handler.reject(exception.error as DioError);
  }

  Future<void> retry(HttpException exception) {
    final requestOptions = (exception.error as DioError).requestOptions;

    return _dio.request(requestOptions.path,
        cancelToken: requestOptions.cancelToken,
        data: requestOptions.data,
        onReceiveProgress: requestOptions.onReceiveProgress,
        onSendProgress: requestOptions.onSendProgress,
        queryParameters: requestOptions.queryParameters,
        options: requestOptions as Options);
  }
}
