part of 'locator_service.dart';

class LocatorServiceRegister {
  LocatorServiceRegister() {
    locator.registerFactory<HttpService>(() => HttpServiceImpl());
    locator.registerFactory<ApiService>(() => ApiServiceImpl());
    locator
        .registerFactory<LocalStorageService>(() => LocalStorageServiceImpl());
    locator.registerFactory<AuthApiService>(() => AuthApiServiceImpl());
    locator.registerFactory<UserApiService>(() => UserApiServiceImpl());

    locator.registerFactory<AuthRepository>(() => AuthRepositoryImpl());
  }
}
