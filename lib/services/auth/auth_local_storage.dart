part of 'auth_service.dart';

class AuthLocalStorage {
  static const preferenceTokenKey = "auth_service_preference_token";

  Future<void> setToken(AuthTokenInfo? token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Remove
    if (token == null) {
      prefs.remove(AuthLocalStorage.preferenceTokenKey);
      return;
    }

    // Set
    prefs.setString(AuthLocalStorage.preferenceTokenKey, token.toJsonString());
  }

  Future<AuthTokenInfo?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(AuthLocalStorage.preferenceTokenKey);
    if (jsonString == null) {
      return null;
    }

    final Map<String, dynamic> json =
        jsonDecode(jsonString) as Map<String, dynamic>;
    return Mapper.fromJson(json).toObject<AuthTokenInfo>();
  }
}
