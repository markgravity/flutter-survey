part of '../auth_api_service.dart';

class AuthResetPasswordParams extends ApiParams {
  AuthResetPasswordParams({
    required this.email,
  });

  final String email;
  final String _clientId = Configs.app.api.clientId;
  final String _clientSecret = Configs.app.api.clientSecret;

  @override
  void mapping(Mapper map) {
    map("user.email", email, (_) {});
    map<String>("client_id", _clientId, (_) {});
    map<String>("client_secret", _clientSecret, (_) {});
  }
}
