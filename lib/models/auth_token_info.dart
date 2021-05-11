import 'package:object_mapper/object_mapper.dart';

class AuthTokenInfo with Mappable {
  String? accessToken;
  String? tokenType;
  DateTime? expiresIn;
  String? refreshToken;

  @override
  void mapping(Mapper map) {
    map<String>("access_token", accessToken, (v) => accessToken = v as String);
    map<String>("token_type", tokenType, (v) => tokenType = v as String);
    map<DateTime>("expires_in", expiresIn, (v) => expiresIn = v as DateTime,
        DateTransform());
    map<String>(
        "refresh_token", refreshToken, (v) => refreshToken = v as String);
  }
}
