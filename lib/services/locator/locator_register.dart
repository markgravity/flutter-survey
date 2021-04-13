import 'package:get_it/get_it.dart';
import 'package:survey/services/api/api_service.dart';
import 'package:survey/services/auth/auth_service.dart';
import 'package:survey/services/http/http_service.dart';
import 'package:survey/services/user/user_service.dart';

final locator = GetIt.instance;

class LocatorRegister {
  LocatorRegister() {
    locator.registerFactory<HttpService>(() => HttpServiceImpl());
    locator.registerFactory<ApiService>(() => ApiServiceImpl());
    locator.registerFactory<UserService>(() => UserServiceImpl());
    locator.registerSingleton<AuthService>(AuthServiceImpl());
  }
}
