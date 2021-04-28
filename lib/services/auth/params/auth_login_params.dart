part of '../auth_service.dart';

class AuthLoginParams extends ApiParams {
  factory AuthLoginParams({
    required String email,
    required String password,
    String? clientId,
    String? clientSecret,
  }) {
    return AuthLoginParams._(
      email: email,
      password: password,
      clientId: clientId ?? Configs.app.api.clientId,
      clientSecret: clientSecret ?? Configs.app.api.clientSecret,
    );
  }

  AuthLoginParams._({
    required this.email,
    required this.password,
    required this.clientId,
    required this.clientSecret,
  });

  String email;
  String password;
  String clientId;
  String clientSecret;
  String grantType = "password";

  @override
  void mapping(Mapper map) {
    map<String>("email", email, (v) => email = v as String);
    map<String>("password", password, (v) => password = v as String);
    map<String>("client_id", clientId, (v) => clientId = v as String);
    map<String>(
        "client_secret", clientSecret, (v) => clientSecret = v as String);
    map<String>("grant_type", grantType, (v) => grantType = v as String);
  }
}
