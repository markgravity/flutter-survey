import 'package:survey/models/user_info.dart';
import 'package:survey/services/api/api_service.dart';
import 'package:survey/services/http/http_service.dart';
import 'package:survey/services/locator/locator_service.dart';

abstract class UserService {
  static const getProfileEndpoint = "/me";

  Future<UserInfo> getProfile();
}

class UserServiceImpl implements UserService {
  final ApiService _apiService = locator.get();

  @override
  Future<UserInfo> getProfile() {
    return _apiService.call(
      method: HttpMethod.get,
      endPoint: UserService.getProfileEndpoint,
    );
  }
}
