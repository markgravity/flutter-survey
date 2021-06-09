part of 'home_module.dart';

abstract class HomeInteractorDelegate {
  BehaviorSubject<bool> get isSurveysCachedDidGet;

  BehaviorSubject<List<SurveyInfo>> get surveysDidFetch;

  BehaviorSubject<Exception> get surveysDidFailToFetch;

  BehaviorSubject<UserInfo> get authenticatedUserDidGet;
}

abstract class HomeInteractor extends Interactor<HomeInteractorDelegate> {
  void getIsSurveysCached();

  void fetchSurveys({bool force = false});

  void getAuthenticatedUser();
}

class HomeInteractorImpl extends HomeInteractor {
  final SurveyRepository _surveyRepository = locator.get();
  final AuthRepository _authRepository = locator.get();

  @override
  void getIsSurveysCached() {
    _surveyRepository.isSurveysCached
        .then((value) => delegate?.isSurveysCachedDidGet.add(value));
  }

  @override
  void fetchSurveys({bool force = false}) {
    _surveyRepository
        .fetchSurveys(force: force)
        .then((value) => delegate?.surveysDidFetch.add(value))
        .onError<Exception>(
            (exception, _) => delegate?.surveysDidFailToFetch.add(exception));
  }

  @override
  void getAuthenticatedUser() {
    delegate?.authenticatedUserDidGet.add(_authRepository.user!);
  }
}
