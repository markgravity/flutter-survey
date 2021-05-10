part of 'locator_service.dart';

class LocatorServiceRegister {
  LocatorServiceRegister() {
    locator.registerFactory<HttpService>(() => HttpServiceImpl());
    locator.registerFactory<ApiService>(() => ApiServiceImpl());
    locator.registerFactory<AuthService>(() => AuthServiceImpl());
    locator.registerFactory<UserApiService>(() => UserApiServiceImpl());
  }
}
