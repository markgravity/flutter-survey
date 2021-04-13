import 'package:survey/services/locator/locator_register.dart';
import 'package:survey/models/user_info.dart';
import 'package:survey/services/api/api_service.dart';
import 'package:survey/services/http/http_service.dart';

abstract class UserService {
  Future<UserInfo> me();
}

class UserServiceImpl implements UserService {
  final ApiService _apiService = locator.get();

  @override
  Future<UserInfo> me() {
    return _apiService.call(
      method: HttpMethod.get,
      endPoint: "/me",
    );
  }
}
