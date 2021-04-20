import 'package:get_it/get_it.dart';
import 'package:survey/services/http/http_service.dart';

final locator = GetIt.instance;

class LocatorRegister {
  LocatorRegister() {
    locator.registerFactory<HttpService>(() => HttpServiceImpl());
  }
}
