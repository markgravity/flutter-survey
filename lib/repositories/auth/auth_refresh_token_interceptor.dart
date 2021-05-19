part of 'auth_repository.dart';

class AuthRefreshTokenInterceptor extends HttpInterceptor {
  final AuthRepository _authRepository = locator.get();

  @override
  final identifier = "auth_refresh_token";

  @override
  Future<void> onException(
      HttpException exception, HttpExceptionInterceptorHandler handler) async {
    final apiException = ApiException.fromHttpException(exception);
    if (apiException == null || apiException != ApiException.invalidToken) {
      return handler.next(exception);
    }

    try {
      await _authRepository.refreshToken();
    } on Exception {
      return handler.next(exception);
    }

    return handler.retry(exception);
  }
}
