part of '../auth_api_service.dart';

class AuthResetPasswordParams extends ApiParams {
  factory AuthResetPasswordParams({
    required String email,
    String? clientId,
    String? clientSecret,
  }) {
    return AuthResetPasswordParams._(
      email: email,
      clientId: clientId ?? Configs.app.api.clientId,
      clientSecret: clientSecret ?? Configs.app.api.clientSecret,
    );
  }

  AuthResetPasswordParams._({
    required this.email,
    required this.clientId,
    required this.clientSecret,
  });

  final String email;
  final String clientId;
  final String clientSecret;

  @override
  void mapping(Mapper map) {
    map("user.email", email, (_) {});
    map<String>("client_id", clientId, (_) {});
    map<String>("client_secret", clientSecret, (_) {});
  }
}
