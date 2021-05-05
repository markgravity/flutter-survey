import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:survey/gen/configs.gen.dart';
import 'package:survey/services/locator/locator_service.dart';
import 'package:survey/models/auth_token_info.dart';
import 'package:object_mapper/object_mapper.dart';
import 'package:survey/models/user_info.dart';
import 'package:survey/services/api/api_service.dart';
import 'package:survey/services/http/http_service.dart';
import 'package:survey/services/user/user_service.dart';

part 'params/auth_login_params.dart';

part 'params/auth_reset_password_params.dart';

abstract class AuthService {
  bool get isAuthenticated;

  String? get token;

  UserInfo? get user;

  Future<void> login({
    required AuthLoginParams params,
  });

  Future<void> logout();

  Future<void> attempt();

  Future<void> fetchUser();

  Future<void> attemptAndFetchUser();

  Future<void> resetPassword({required AuthResetPasswordParams params});
}

class AuthServiceImpl implements AuthService {
  static const _preferenceTokenKey = "auth_service_preference_token";

  final ApiService _apiService = locator.get();
  final UserService _userService = locator.get();
  String? _token;
  UserInfo? _user;

  @override
  bool get isAuthenticated => _token != null;

  @override
  String? get token => _token;

  @override
  UserInfo? get user => _user;

  @override
  Future<void> login({
    required AuthLoginParams params,
  }) async {
    final AuthTokenInfo token = await _apiService.call(
      method: HttpMethod.post,
      endPoint: "/oauth/token",
      params: params,
    );
    await _storeToken(token);
    await attemptAndFetchUser();
  }

  @override
  Future<void> logout() async {
    try {
      await _apiService.call(
        method: HttpMethod.post,
        endPoint: "/oauth/revoke",
      );
    } on Exception catch (_) {}

    await _clearToken();
    _token = null;
    _user = null;
  }

  @override
  Future<void> attempt() async {
    final token = await _getToken();
    if (token == null) {
      _token = null;
      _user = null;
      return;
    }

    _token = token.accessToken;
    _apiService.configureGlobalToken(_token);
  }

  @override
  Future<void> fetchUser() async {
    if (_token == null) return;

    final user = await _userService.me();
    _user = user;
  }

  @override
  Future<void> attemptAndFetchUser() async {
    await attempt();
    await fetchUser();
  }

  @override
  Future<void> resetPassword({required AuthResetPasswordParams params}) {
    return _apiService.call(
      method: HttpMethod.post,
      endPoint: "/passwords",
      params: params,
    );
  }

  Future<void> _storeToken(AuthTokenInfo tokenInfo) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_preferenceTokenKey, tokenInfo.toJsonString());
  }

  Future<void> _clearToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_preferenceTokenKey);
  }

  Future<AuthTokenInfo?> _getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_preferenceTokenKey);
    if (jsonString == null) {
      return null;
    }

    final Map<String, dynamic> json =
        jsonDecode(jsonString) as Map<String, dynamic>;
    return Mapper.fromJson(json).toObject<AuthTokenInfo>();
  }
}
