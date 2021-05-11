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
    locator.registerFactory<SurveyApiService>(() => SurveyApiServiceImpl());

    locator.registerFactory<NavigatorObserver>(() => NavigatorObserver());

    // Landing
    locator.registerFactory<LandingInteractor>(() => LandingInteractorImpl());
    locator.registerFactory<LandingRouter>(() => LandingRouterImpl());
    locator.registerFactory<LandingPresenter>(() => LandingPresenterImpl());

    // Login
    locator.registerFactory<LoginInteractor>(() => LoginInteractorImpl());
    locator.registerFactory<LoginRouter>(() => LoginRouterImpl());
    locator.registerFactory<LoginPresenter>(() => LoginPresenterImpl());

    // Forgot Password
    locator.registerFactory<ForgotPasswordInteractor>(
        () => ForgotPasswordInteractorImpl());
    locator.registerFactory<ForgotPasswordPresenter>(
        () => ForgotPasswordPresenterImpl());
    locator.registerFactory<ForgotPasswordRouter>(
        () => ForgotPasswordRouterImpl());
  }
}
