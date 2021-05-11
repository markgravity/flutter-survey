part of 'locator_service.dart';

class LocatorServiceRegister {
  LocatorServiceRegister() {
    locator.registerFactory<HttpService>(() => HttpServiceImpl());
    locator.registerFactory<ApiService>(() => ApiServiceImpl());

    locator.registerFactory<AuthLocalStorageService>(
        () => AuthLocalStorageServiceImpl());
    locator.registerFactory<AuthApiService>(() => AuthApiServiceImpl());
    locator.registerFactory<AuthRepository>(() => AuthRepositoryImpl());
    locator.registerFactory<UserApiService>(() => UserApiServiceImpl());
  }
}
