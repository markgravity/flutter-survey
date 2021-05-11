import 'dart:convert';

import 'package:object_mapper/object_mapper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:survey/models/auth_token_info.dart';

abstract class AuthLocalStorageService {
  static const preferenceTokenKey = "auth_service_preference_token";

  Future<void> setToken(AuthTokenInfo? token);

  Future<AuthTokenInfo?> getToken();
}

class AuthLocalStorageServiceImpl implements AuthLocalStorageService {
  @override
  Future<void> setToken(AuthTokenInfo? token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Remove
    if (token == null) {
      prefs.remove(AuthLocalStorageService.preferenceTokenKey);
      return;
    }

    // Set
    prefs.setString(
        AuthLocalStorageService.preferenceTokenKey, token.toJsonString());
  }

  @override
  Future<AuthTokenInfo?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString =
        prefs.getString(AuthLocalStorageService.preferenceTokenKey);
    if (jsonString == null) {
      return null;
    }

    final Map<String, dynamic> json =
        jsonDecode(jsonString) as Map<String, dynamic>;
    return Mapper.fromJson(json).toObject<AuthTokenInfo>();
  }
}
