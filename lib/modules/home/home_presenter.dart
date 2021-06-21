part of 'home_module.dart';

abstract class HomePresenter
    extends Presenter<HomeView, HomeInteractor, HomeRouter> {}

class HomePresenterImpl extends HomePresenter
    implements HomeViewDelegate, HomeInteractorDelegate {
  HomePresenterImpl() {
    stateDidInit.voidListen(_stateDidInit).addTo(disposeBag);
    showDetailButtonDidTap.listen(_showDetailButtonDidTap).addTo(disposeBag);
    didSwipeDown.voidListen(_didSwipeDown).addTo(disposeBag);
    userAvatarDidTap.voidListen(_userAvatarDidTap).addTo(disposeBag);
    currentPageDidChange.listen(_currentPageDidChange).addTo(disposeBag);

    surveysDidFetchFromCached
        .listen(_surveysDidFetchFromCached)
        .addTo(disposeBag);
    surveysDidFailToFetchFromCached
        .listen(_surveysDidFailToFetchFromCached)
        .addTo(disposeBag);

    surveysDidFetchFromRemote
        .listen(_surveysDidFetchFromRemote)
        .addTo(disposeBag);
    surveysDidFailToFetchFromRemote
        .listen(_surveysDidFailToFetchFromRemote)
        .addTo(disposeBag);

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
  final userAvatarDidTap = BehaviorSubject<void>();

  @override
  final sideMenuDidDismiss = BehaviorSubject<void>();

  @override
  final sideMenuDidShow = BehaviorSubject<void>();

  @override
  final surveysDidFailToFetchFromCached = BehaviorSubject<Exception>();

  @override
  final surveysDidFetchFromCached = BehaviorSubject<List<SurveyInfo>>();

  @override
  final surveysDidFailToFetchFromRemote = BehaviorSubject<Exception>();

  @override
  final surveysDidFetchFromRemote =
      BehaviorSubject<Tuple2<List<SurveyInfo>, bool>>();

  @override
  final authenticatedUserDidGet = BehaviorSubject<UserInfo>();

  @override
  final currentPageDidChange = BehaviorSubject<int>();

  void _stateDidInit() {
    interactor.fetchSurveysFromCached();
    interactor.getAuthenticatedUser();

    final text = DateFormat("EEEE, MMM d").format(DateTime.now()).toUpperCase();
    view.setDateTimeText(text);
  }

  void _showDetailButtonDidTap(SurveyInfo survey) {
    router.pushToSurveyDetail(context: view.context, survey: survey);
  }

  void _surveysDidFetchFromCached(List<SurveyInfo> surveys) {
    // Show cached surveys
    if (surveys.isNotEmpty) view.showSurveys(surveys);

    // Begin skeleton animation when there are no cached surveys
    if (surveys.isEmpty) view.beginSkeletonAnimation();

    // Try to refresh data
    interactor.fetchSurveysFromRemote();
  }

  void _surveysDidFailToFetchFromCached(Exception exception) {
    view.alert(exception);
  }

  void _surveysDidFetchFromRemote(Tuple2<List<SurveyInfo>, bool> data) {
    final surveys = data.item1;
    final hasChanges = data.item2;

    view.stopSkeletonAnimation();
    view.dismissProgressHUD();

    if (hasChanges) view.showSurveys(surveys);
  }

  void _surveysDidFailToFetchFromRemote(Exception exception) {
    view.stopSkeletonAnimation();
    view.dismissProgressHUD();
    view.alert(exception);
  }

  void _authenticatedUserDidGet(UserInfo user) {
    view.showUser(user);
  }

  void _didSwipeDown() {
    view.showProgressHUD();
    interactor.fetchSurveysFromRemote();
  }

  void _userAvatarDidTap() {
    view.showSideMenu();
  }

  void _currentPageDidChange(int page) {
    view.setCurrentPage(page);
  }
}
