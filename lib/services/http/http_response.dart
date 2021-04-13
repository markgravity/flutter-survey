part of 'http_service.dart';

class HttpResponse {
  final dynamic data;
  final Map<String, List<String>>? headers;
  final int? statusCode;
  final String? statusMessage;

  HttpResponse({
    required this.data,
    required this.headers,
    required this.statusCode,
    required this.statusMessage,
  });

  factory HttpResponse.fromDioResponse(Response response) {
    return HttpResponse(
      data: response.data,
      headers: response.headers.map,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
    );
  }
}
