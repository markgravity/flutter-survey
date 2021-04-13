import 'package:survey/gen/configs.gen.dart';
import 'package:survey/services/locator/locator_register.dart';
import 'package:survey/services/http/http_service.dart';
import 'package:object_mapper/object_mapper.dart';

part 'api_exception.dart';

part 'api_params.dart';
part 'api_service_register.dart';

abstract class ApiService {
  Future<T> call<T extends Mappable>({
    required HttpMethod method,
    String? baseUrl,
    required String endPoint,
    ApiParams? params,
    String? token,
  });

  void configureGlobalBaseUrl(String? baseUrl);

  void configureGlobalToken(String? token);
}

class ApiServiceImpl implements ApiService {
  static String? _fallbackBaseUrl;
  static String? _fallbackToken;
  final HttpService _httpService = locator.get();

  @override
  Future<T> call<T extends Mappable>({
    required HttpMethod method,
    String? baseUrl,
    required String endPoint,
    ApiParams? params,
    String? token,
  }) async {
    final String? finalBaseUrl = baseUrl ?? _fallbackBaseUrl;
    assert(finalBaseUrl != null);

    final Map<String, dynamic> headers = {};

    // Append bearer token
    final String? finalToken = token ?? _fallbackToken;
    if (finalToken != null) {
      headers["authorization"] = "Bearer $finalToken";
    }

    final url = finalBaseUrl! + endPoint;
    try {
      final response = await _httpService.request(
        method: method,
        data: params?.toJson(),
        url: url,
        headers: headers,
      ) as Map<String, dynamic>;
      return Mapper.fromJson(
              response["data"]["attributes"] as Map<String, dynamic>)
          .toObject<T>();
    } on HttpException catch (e) {
      throw ApiException.fromHttpException(e) ?? e;
    }
  }

  @override
  void configureGlobalBaseUrl(String? baseUrl) {
    _fallbackBaseUrl = baseUrl;
  }

  @override
  void configureGlobalToken(String? token) {
    _fallbackToken = token;
  }
}
