part of 'api_service.dart';

class ApiException extends Equatable implements LocalizedException {
  const ApiException({
    required this.source,
    required this.message,
    required this.code,
  });

  static ApiException? fromHttpException(HttpException exception) {
    if (exception.type != HttpExceptionType.response &&
        exception.response?.data is! Map<String, dynamic>) {
      return null;
    }

    final json = exception.response!.data as Map<String, dynamic>;
    final source = json["errors"][0]["source"] as String?;
    final message = json["errors"][0]["detail"] as String;
    final code = json["errors"][0]["code"] as String;

    return ApiException(
      source: source,
      message: message,
      code: code,
    );
  }

  final String? source;
  final String code;

  @override
  final String message;

  @override
  List<Object?> get props => [source, code];

  static const invalidResponseStructure = ApiException(
    source: "local",
    message: "Wrong response structure",
    code: "wrong_response_structure",
  );

  static const invalidToken = ApiException(
    source: "unauthorized",
    message: "The access token is invalid",
    code: "invalid_token",
  );
}
