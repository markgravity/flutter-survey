import 'package:dio/dio.dart';
import 'package:enumerated_class/enumerated_class.dart';
import 'package:flutter/foundation.dart';

part 'http_method.dart';
part 'http_exception.dart';
part 'http_response.dart';

abstract class HttpService {
  Future<dynamic> request({
    required HttpMethod method,
    dynamic? data,
    required String url,
    Map<String, dynamic>? headers,
  });
}

class HttpServiceImpl implements HttpService {
  final _dio = Dio();

  HttpServiceImpl() {
    if (!kReleaseMode) {
      _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
      ));
    }
  }

  @override
  Future<dynamic> request({
    required HttpMethod method,
    dynamic data,
    required String url,
    Map<String, dynamic>? headers,
  }) async {
    final options = Options(method: method.rawValue, headers: headers);
    try {
      final response = await _dio.request(url,
          data: method != HttpMethod.get ? data : null,
          options: options,
          queryParameters:
              method == HttpMethod.get ? data as Map<String, dynamic>? : null);
      return response.data;
    } on DioError catch (e) {
      throw HttpException.fromDioError(e);
    }
  }
}
