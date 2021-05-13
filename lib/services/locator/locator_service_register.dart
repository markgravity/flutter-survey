part of 'locator_service.dart';

class LocatorServiceRegister {
  LocatorServiceRegister() {
    //
    locator.registerFactory<NavigatorObserver>(() => NavigatorObserver());

    // Services
    locator.registerFactory<HttpService>(() => HttpServiceImpl());
    locator.registerFactory<ApiService>(() => ApiServiceImpl());
    locator
        .registerFactory<LocalStorageService>(() => LocalStorageServiceImpl());
    locator.registerFactory<AuthApiService>(() => AuthApiServiceImpl());
    locator.registerFactory<UserApiService>(() => UserApiServiceImpl());
    locator.registerFactory<SurveyApiService>(() => SurveyApiServiceImpl());

    // Repositories
    locator.registerSingleton<AuthRepository>(AuthRepositoryImpl());
    locator.registerFactory<SurveyRepository>(() => SurveyRepositoryImpl());

    // Landing
    locator.registerFactory<LandingInteractor>(() => LandingInteractorImpl());
    locator.registerFactory<LandingRouter>(() => LandingRouterImpl());
    locator.registerFactory<LandingPresenter>(() => LandingPresenterImpl());

    // Login
    locator.registerFactory<LoginInteractor>(() => LoginInteractorImpl());
    locator.registerFactory<LoginRouter>(() => LoginRouterImpl());
    locator.registerFactory<LoginPresenter>(() => LoginPresenterImpl());

    // Home
    locator.registerFactory<HomeInteractor>(() => HomeInteractorImpl());
    locator.registerFactory<HomeRouter>(() => HomeRouterImpl());
    locator.registerFactory<HomePresenter>(() => HomePresenterImpl());

    // Side Menu
    locator.registerFactory<SideMenuModule>(() => SideMenuModule());
    locator.registerFactory<SideMenuInteractor>(() => SideMenuInteractorImpl());
    locator.registerFactory<SideMenuRouter>(() => SideMenuRouterImpl());
    locator.registerFactory<SideMenuPresenter>(() => SideMenuPresenterImpl());

    // Survey Detail
    locator.registerFactory<SurveyDetailInteractor>(
        () => SurveyDetailInteractorImpl());
    locator.registerFactory<SurveyDetailRouter>(() => SurveyDetailRouterImpl());
    locator.registerFactory<SurveyDetailPresenter>(
        () => SurveyDetailPresenterImpl());

    // Survey Questions
    locator.registerFactory<SurveyQuestionsInteractor>(
        () => SurveyQuestionsInteractorImpl());
    locator.registerFactory<SurveyQuestionsRouter>(
        () => SurveyQuestionsRouterImpl());
    locator.registerFactory<SurveyQuestionsPresenter>(
        () => SurveyQuestionsPresenterImpl());
  }
}
