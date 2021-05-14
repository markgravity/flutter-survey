import 'package:object_mapper/object_mapper.dart';

class UserInfo with Mappable {
  String? email;
  String? avatarUrl;

  @override
  void mapping(Mapper map) {
    map("attributes.email", email, (v) => email = v as String);
    map("attributes.avatar_url", avatarUrl, (v) => avatarUrl = v as String);
  }
}
