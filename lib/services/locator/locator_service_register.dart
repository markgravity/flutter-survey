part of 'locator_service.dart';

class LocatorServiceRegister {
  LocatorServiceRegister() {
    locator.registerFactory<HttpService>(() => HttpServiceImpl());
    locator.registerFactory<ApiService>(() => ApiServiceImpl());

    locator.registerFactory<AuthLocalStorage>(() => AuthLocalStorage());
    locator.registerFactory<AuthApiService>(() => AuthApiServiceImpl());
    locator.registerFactory<AuthService>(() => AuthServiceImpl());
    locator.registerFactory<UserApiService>(() => UserApiServiceImpl());
  }
}
