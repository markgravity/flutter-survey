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

abstract class AuthService {
  static const loginEndPoint = "/oauth/token";
  static const logoutEndPoint = "/oauth/revoke";
  static const preferenceTokenKey = "auth_service_preference_token";

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
}

class AuthServiceImpl implements AuthService {
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
      endPoint: AuthService.loginEndPoint,
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
        endPoint: AuthService.logoutEndPoint,
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

    final user = await _userService.getProfile();
    _user = user;
  }

  @override
  Future<void> attemptAndFetchUser() async {
    await attempt();
    await fetchUser();
  }

  Future<void> _storeToken(AuthTokenInfo tokenInfo) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AuthService.preferenceTokenKey, tokenInfo.toJsonString());
  }

  Future<void> _clearToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(AuthService.preferenceTokenKey);
  }

  Future<AuthTokenInfo?> _getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(AuthService.preferenceTokenKey);
    if (jsonString == null) {
      return null;
    }

    final Map<String, dynamic> json =
        jsonDecode(jsonString) as Map<String, dynamic>;
    return Mapper.fromJson(json).toObject<AuthTokenInfo>();
  }
}
