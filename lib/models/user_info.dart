import 'package:object_mapper/object_mapper.dart';

class UserInfo with Mappable {
  String? email;
  String? avatarUrl;

  @override
  void mapping(Mapper map) {
    map("email", email, (v) => email = v as String);
    map("avatar_url", avatarUrl, (v) => avatarUrl = v as String);
  }
}
