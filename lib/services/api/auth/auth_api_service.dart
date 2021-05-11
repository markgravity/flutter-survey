import 'package:survey/gen/configs.gen.dart';
import 'package:survey/services/locator/locator_service.dart';
import 'package:survey/models/auth_token_info.dart';
import 'package:object_mapper/object_mapper.dart';
import 'package:survey/services/api/api_service.dart';
import 'package:survey/services/http/http_service.dart';

part 'params/auth_login_params.dart';

abstract class AuthApiService {
  static const loginEndpoint = "/oauth/token";
  static const logoutEndpoint = "/oauth/revoke";
  static const preferenceTokenKey = "auth_service_preference_token";

  Future<AuthTokenInfo> login({
    required AuthLoginParams params,
  });

  Future<void> logout();
}

class AuthApiServiceImpl implements AuthApiService {
  final ApiService _apiService = locator.get();

  @override
  Future<AuthTokenInfo> login({
    required AuthLoginParams params,
  }) {
    return _apiService.call(
      method: HttpMethod.post,
      endPoint: AuthApiService.loginEndpoint,
      params: params,
    );
  }

  @override
  Future<void> logout() {
    return _apiService.call(
      method: HttpMethod.post,
      endPoint: AuthApiService.logoutEndpoint,
    );
  }
}
