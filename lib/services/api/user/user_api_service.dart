import 'package:survey/models/user_info.dart';
import 'package:survey/services/api/api_service.dart';
import 'package:survey/services/http/http_service.dart';
import 'package:survey/services/locator/locator_service.dart';

abstract class UserApiService {
  static const getProfileEndpoint = "/me";

  Future<UserInfo> getProfile();
}

class UserApiServiceImpl implements UserApiService {
  final ApiService _apiService = locator.get();

  @override
  Future<UserInfo> getProfile() {
    return _apiService.call(
      method: HttpMethod.get,
      endPoint: UserApiService.getProfileEndpoint,
    );
  }
}
