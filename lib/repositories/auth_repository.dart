import 'package:survey/services/api/api_service.dart';
import 'package:survey/services/api/auth/auth_api_service.dart';
import 'package:survey/services/api/user/user_api_service.dart';
import 'package:survey/services/auth_local_storage/auth_local_storage_service.dart';
import 'package:survey/services/locator/locator_service.dart';
import 'package:survey/models/user_info.dart';

abstract class AuthRepository {
  bool get isAuthenticated;

  String? get accessToken;

  UserInfo? get user;

  Future<void> login({
    required String email,
    required String password,
  });

  Future<void> logout();

  Future<void> attempt();

  Future<void> fetchUser();

  Future<void> attemptAndFetchUser();
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService _authApiService = locator.get();
  final UserApiService _userApiService = locator.get();
  final ApiService _apiService = locator.get();
  final AuthLocalStorageService _authLocalStorage = locator.get();

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
    required String email,
    required String password,
  }) async {
    final params = AuthLoginParams(email: email, password: password);
    final token = await _authApiService.login(params: params);
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
    _apiService.configureGlobalToken(_accessToken, token.tokenType);
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
