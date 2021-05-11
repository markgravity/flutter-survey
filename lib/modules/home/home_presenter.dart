part of 'home_module.dart';

abstract class HomePresenter
    extends Presenter<HomeView, HomeInteractor, HomeRouter> {}

class HomePresenterImpl extends HomePresenter
    implements HomeViewDelegate, HomeInteractorDelegate {
  HomePresenterImpl() {
    stateDidInit.voidListen(_stateDidInit).addTo(disposeBag);
    showDetailButtonDidTap.listen(_showDetailButtonDidTap).addTo(disposeBag);
    didSwipeDown.voidListen(_didSwipeDown).addTo(disposeBag);

    surveysDidFetch.listen(_surveysDidFetch).addTo(disposeBag);
    surveysDidFailToFetch.listen(_surveysDidFailToFetch).addTo(disposeBag);
    isSurveysCachedDidGet.listen(_isSurveysCachedDidGet).addTo(disposeBag);
    authenticatedUserDidGet.listen(_authenticatedUserDidGet).addTo(disposeBag);
  }

  @override
  final stateDidInit = BehaviorSubject<void>();

  @override
  final showDetailButtonDidTap = BehaviorSubject<SurveyInfo>();

  @override
  final didSwipeDown = BehaviorSubject<void>();

  @override
  final alertDialogDidClose = BehaviorSubject<void>();

  @override
  final surveysDidFailToFetch = BehaviorSubject<Exception>();

  @override
  final surveysDidFetch = BehaviorSubject<List<SurveyInfo>>();

  @override
  final isSurveysCachedDidGet = BehaviorSubject<bool>();

  @override
  final authenticatedUserDidGet = BehaviorSubject<UserInfo>();

  void _stateDidInit() {
    interactor.getIsSurveysCached();
    interactor.getAuthenticatedUser();
    view.setDateTime(DateTime.now());
  }

  void _showDetailButtonDidTap(SurveyInfo survey) {
    router.pushToSurveyDetail(context: view.context, survey: survey);
  }

  void _surveysDidFetch(List<SurveyInfo> surveys) {
    view.stopSkeletonAnimation();
    view.dismissProgressHUD();
    view.showSurveys(surveys);
  }

  void _surveysDidFailToFetch(Exception exception) {
    view.stopSkeletonAnimation();
    view.dismissProgressHUD();
    view.alert(exception);
  }

  void _isSurveysCachedDidGet(bool isCached) {
    interactor.fetchSurveys();
    if (!isCached) {
      view.beginSkeletonAnimation();
    }
  }

  void _authenticatedUserDidGet(UserInfo user) {
    view.showUser(user);
  }

  void _didSwipeDown() {
    view.showProgressHUD();
    interactor.fetchSurveys(force: true);
  }
}
