import 'package:survey/gen/configs.gen.dart';
import 'package:survey/services/http/http_service.dart';
import 'package:object_mapper/object_mapper.dart';
import 'package:survey/services/locator/locator_service.dart';

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

  void configureGlobalToken(String? token, String? tokenType);
}

class ApiServiceImpl implements ApiService {
  static String? _baseUrl;
  static String? _token;
  static String _tokenType = "Bearer";
  final HttpService _httpService = locator.get();

  @override
  Future<T> call<T extends Mappable>({
    required HttpMethod method,
    String? baseUrl,
    required String endPoint,
    ApiParams? params,
    bool requiresAuthentication = true,
    String? token,
    String? tokenType,
  }) async {
    final String? finalBaseUrl = baseUrl ?? _baseUrl;
    assert(finalBaseUrl != null);

    final Map<String, dynamic> headers = {};

    // Append token
    final String? finalToken = token ?? _token;
    if (requiresAuthentication && finalToken != null) {
      final finalTokenType = tokenType ?? _tokenType;
      headers["authorization"] = "$finalTokenType $finalToken";
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

  /// Configures a default base url when [call] with `baseUrl` is null.
  ///
  /// This value is stored in a static variable [_baseUrl] so it will be available in any
  /// instance of [ApiServiceImpl], after set
  @override
  void configureGlobalBaseUrl(String? baseUrl) {
    _baseUrl = baseUrl;
  }

  /// Configures a default token & tokenType when [call] with token or tokenType is null.
  ///
  /// This value is stored in a static variable [_token], [_tokenType] so it will be available in any
  /// instance of [ApiServiceImpl], after set
  @override
  void configureGlobalToken(String? token, String? tokenType) {
    _token = token;
    if (tokenType != null) {
      _tokenType = tokenType;
    }
  }
}
