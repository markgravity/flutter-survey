import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:survey/services/api/api_service.dart';
import 'package:survey/services/api/auth/auth_api_service.dart';
import 'package:survey/services/api/user/user_api_service.dart';
import 'package:survey/services/locator/locator_service.dart';
import 'package:survey/models/auth_token_info.dart';
import 'package:object_mapper/object_mapper.dart';
import 'package:survey/models/user_info.dart';

part 'auth_local_storage.dart';

abstract class AuthService {
  bool get isAuthenticated;

  String? get accessToken;

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
  final AuthApiService _authApiService = locator.get();
  final UserApiService _userApiService = locator.get();
  final ApiService _apiService = locator.get();
  final AuthLocalStorage _authLocalStorage = locator.get();

  String? _accessToken;
  UserInfo? _user;

  @override
  bool get isAuthenticated => _accessToken != null;

  @override
  String? get accessToken => _accessToken;

  @override
  UserInfo? get user => _user;

  @override
  Future<void> login({
    required AuthLoginParams params,
  }) async {
    final AuthTokenInfo token = await _authApiService.login(params: params);
    await _authLocalStorage.setToken(token);
    await attemptAndFetchUser();
  }

  @override
  Future<void> logout() async {
    try {
      await _authApiService.logout();
    } on Exception catch (_) {}

    await _authLocalStorage.setToken(null);
    _accessToken = null;
    _user = null;
  }

  @override
  Future<void> attempt() async {
    final token = await _authLocalStorage.getToken();
    if (token == null) {
      _accessToken = null;
      _user = null;
      return;
    }

    _accessToken = token.accessToken;
    _apiService.configureGlobalToken(_accessToken);
  }

  @override
  Future<void> fetchUser() async {
    if (_accessToken == null) return;

    final user = await _userApiService.getProfile();
    _user = user;
  }

  @override
  Future<void> attemptAndFetchUser() async {
    await attempt();
    await fetchUser();
  }
}
