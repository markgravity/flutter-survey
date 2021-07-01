part of 'home_module.dart';

abstract class HomeInteractorDelegate {
  BehaviorSubject<List<SurveyInfo>> get surveysDidFetchFromCached;

  BehaviorSubject<Exception> get surveysDidFailToFetchFromCached;

  BehaviorSubject<Tuple2<List<SurveyInfo>, bool>> get surveysDidFetchFromRemote;

  BehaviorSubject<Exception> get surveysDidFailToFetchFromRemote;

  BehaviorSubject<UserInfo> get authenticatedUserDidGet;
}

abstract class HomeInteractor extends Interactor<HomeInteractorDelegate> {
  void fetchSurveysFromCached();

  void fetchSurveysFromRemote();

  void getAuthenticatedUser();
}

class HomeInteractorImpl extends HomeInteractor {
  final SurveyRepository _surveyRepository = locator.get();
  final AuthRepository _authRepository = locator.get();

  @override
  void fetchSurveysFromCached() {
    _surveyRepository
        .fetchSurveysFromCached()
        .then((value) => delegate?.surveysDidFetchFromCached.add(value))
        .onError<Exception>((exception, _) =>
            delegate?.surveysDidFailToFetchFromCached.add(exception));
  }

  @override
  void fetchSurveysFromRemote() {
    Future.wait([
      _surveyRepository.fetchSurveysFromCached(),
      _surveyRepository.fetchSurveysFromRemote()
    ]).then((values) {
      final cachedSurveys = values[0];
      final remoteSurveys = values[1];

      final hasChanges = _isCachedSurveysChanged(cachedSurveys, remoteSurveys);
      delegate?.surveysDidFetchFromRemote
          .add(Tuple2(remoteSurveys, hasChanges));
    }).onError<Exception>((exception, _) {
      delegate?.surveysDidFailToFetchFromRemote.add(exception);
    });
  }

  @override
  void getAuthenticatedUser() {
    delegate?.authenticatedUserDidGet.add(_authRepository.user!);
  }

  bool _isCachedSurveysChanged(
      List<SurveyInfo> cachedSurveys, List<SurveyInfo> remoteSurveys) {
    if (cachedSurveys.length != remoteSurveys.length) return true;

    int count = 0;
    for (final survey in cachedSurveys) {
      if (!remoteSurveys.contains(survey)) return true;
      count++;
    }

    return count != remoteSurveys.length;
  }
}
