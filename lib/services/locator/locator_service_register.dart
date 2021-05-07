part of 'locator_service.dart';

class LocatorServiceRegister {
  LocatorServiceRegister() {
    locator.registerFactory<HttpService>(() => HttpServiceImpl());
    locator.registerFactory<ApiService>(() => ApiServiceImpl());
  }
}
