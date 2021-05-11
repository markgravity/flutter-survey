import 'package:survey/core/classes/localized_exception.dart';
import 'package:survey/gen/configs.gen.dart';
import 'package:survey/services/http/http_service.dart';
import 'package:object_mapper/object_mapper.dart';
import 'package:survey/services/locator/locator_service.dart';

part 'api_exception.dart';

part 'api_params.dart';

part 'api_service_register.dart';

part 'api_list_object.dart';

abstract class ApiService {
  Future<T> call<T>({
    required HttpMethod method,
    String? baseUrl,
    required String endpoint,
    ApiParams? params,
    bool requiresAuthentication = true,
    String? token,
    String? tokenType,
  });

  Future<ApiListObject<T>> callForList<T extends Mappable>({
    required HttpMethod method,
    String? baseUrl,
    required String endpoint,
    ApiParams? params,
    bool requiresAuthentication = true,
    String? token,
    String? tokenType,
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
  Future<T> call<T>({
    required HttpMethod method,
    String? baseUrl,
    required String endpoint,
    ApiParams? params,
    bool requiresAuthentication = true,
    String? token,
    String? tokenType,
  }) async {
    final response = await _request(
      method: method,
      baseUrl: baseUrl,
      endpoint: endpoint,
      params: params,
      requiresAuthentication: requiresAuthentication,
      token: token,
      tokenType: tokenType,
    );

    return _convertResponseToObject<T>(response);
  }

  @override
  Future<ApiListObject<T>> callForList<T extends Mappable>({
    required HttpMethod method,
    String? baseUrl,
    required String endpoint,
    ApiParams? params,
    bool requiresAuthentication = true,
    String? token,
    String? tokenType,
  }) async {
    final response = await _request(
      method: method,
      baseUrl: baseUrl,
      endpoint: endpoint,
      params: params,
      requiresAuthentication: requiresAuthentication,
      token: token,
      tokenType: tokenType,
    );

    return _convertResponseToListObject<T>(response);
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

  Future<Map<String, dynamic>> _request({
    required HttpMethod method,
    String? baseUrl,
    required String endpoint,
    ApiParams? params,
    required bool requiresAuthentication,
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

    final url = finalBaseUrl! + endpoint;
    try {
      return await _httpService.request(
        method: method,
        data: params?.toJson(),
        url: url,
        headers: headers,
      ) as Map<String, dynamic>;
    } on HttpException catch (e) {
      throw ApiException.fromHttpException(e) ?? e;
    }
  }

  T _convertResponseToObject<T>(Map<String, dynamic> response) {
    if (response["data"] == null && T.toString() == "void") {
      return null as T;
    }

    if (response["data"] is! Map<String, dynamic> ||
        response["data"]["attributes"] is! Map<String, dynamic>) {
      throw ApiException.wrongResponseStructure;
    }

    return Mapper.fromJson(
            response["data"]["attributes"] as Map<String, dynamic>)
        .toObject<T>()!;
  }

  ApiListObject<T> _convertResponseToListObject<T>(
      Map<String, dynamic> response) {
    if (response["data"] is! List<dynamic>) {
      throw ApiException.wrongResponseStructure;
    }

    final items = (response["data"] as List<dynamic>)
        .where((e) => e["attributes"] is Map<String, dynamic>)
        .map((e) => Mapper.fromJson(e["attributes"] as Map<String, dynamic>)
            .toObject<T>()!)
        .toList();

    return ApiListObject<T>(items: items);
  }
}
