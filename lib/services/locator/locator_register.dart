import 'package:get_it/get_it.dart';
import 'package:survey/screens/landing/landing_router.dart';
import 'package:survey/screens/landing/landing_vm.dart';
import 'package:survey/screens/login/login_router.dart';
import 'package:survey/screens/login/login_vm.dart';
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
    locator.registerFactory<LandingVM>(() => LandingVMImpl());
    locator.registerFactory<LandingRouter>(() => LandingRouterImpl());
    locator.registerFactory<LoginVM>(() => LoginVMImpl());
    locator.registerFactory<LoginRouter>(() => LoginRouterImpl());
    locator.registerSingleton<AuthService>(AuthServiceImpl());
  }
}
