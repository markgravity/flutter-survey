part of '../auth_api_service.dart';

class AuthRefreshTokenParams extends ApiParams {
  factory AuthRefreshTokenParams({
    required String refreshToken,
    String? clientId,
    String? clientSecret,
  }) {
    return AuthRefreshTokenParams._(
      refreshToken: refreshToken,
      clientId: clientId ?? Configs.app.api.clientId,
      clientSecret: clientSecret ?? Configs.app.api.clientSecret,
    );
  }

  AuthRefreshTokenParams._({
    required this.refreshToken,
    required this.clientId,
    required this.clientSecret,
  });

  String refreshToken;
  String clientId;
  String clientSecret;
  String grantType = "refresh_token";

  @override
  void mapping(Mapper map) {
    map<String>(
        "refresh_token", refreshToken, (v) => refreshToken = v as String);
    map<String>("client_id", clientId, (v) => clientId = v as String);
    map<String>(
        "client_secret", clientSecret, (v) => clientSecret = v as String);
    map<String>("grant_type", grantType, (v) => grantType = v as String);
  }
}
