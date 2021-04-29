part of 'locator_service.dart';

class LocatorServiceRegister {
  LocatorServiceRegister() {
    locator.registerFactory<HttpService>(() => HttpServiceImpl());
    locator.registerFactory<ApiService>(() => ApiServiceImpl());
    locator.registerFactory<UserService>(() => UserServiceImpl());
    locator.registerFactory<AuthService>(() => AuthServiceImpl());
    locator.registerFactoryParam<StreamsDisposeBag, List, dynamic>(
      (streams, _) => StreamsDisposeBag(streams!),
    );
    locator.registerFactory<NavigatorObserver>(() => NavigatorObserver());

    // Landing
    locator.registerFactory<LandingInteractor>(() => LandingInteractorImpl());
    locator.registerFactory<LandingRouter>(() => LandingRouterImpl());
    locator.registerFactory<LandingPresenter>(() => LandingPresenterImpl());

    // Login
    locator.registerFactory<LoginInteractor>(() => LoginInteractorImpl());
    locator.registerFactory<LoginRouter>(() => LoginRouterImpl());
    locator.registerFactory<LoginPresenter>(() => LoginPresenterImpl());
  }
}
