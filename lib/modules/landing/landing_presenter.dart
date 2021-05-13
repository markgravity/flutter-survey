part of 'landing_module.dart';

abstract class LandingPresenter
    extends Presenter<LandingView, LandingInteractor, LandingRouter> {}

class LandingPresenterImpl extends LandingPresenter
    implements LandingInteractorDelegate, LandingViewDelegate {
  LandingPresenterImpl() {
    stateDidInit.voidListen(_stateDidInit).addTo(disposeBag);
    alertDialogDidClose.voidListen(_alertDialogDidClose).addTo(disposeBag);
    authenticationDidFailToValidate
        .listen(_authenticationDidFailToValidate)
        .addTo(disposeBag);

    animationDidFinish
        .zipWith<bool, bool>(authenticationDidValidate, (t, s) => s)
        .listen(_didAllFinish)
        .addTo(disposeBag);
  }

  @override
  final stateDidInit = BehaviorSubject<void>();

  @override
  final alertDialogDidClose = BehaviorSubject<void>();

  @override
  final animationDidFinish = BehaviorSubject<void>();

  @override
  final authenticationDidFailToValidate = BehaviorSubject<Exception>();

  @override
  final authenticationDidValidate = BehaviorSubject<bool>();

  void _stateDidInit() {
    view.beginAnimation();
    interactor.validateAuthentication();
  }

  void _alertDialogDidClose() {
    interactor.validateAuthentication();
  }

  void _authenticationDidFailToValidate(Object error) {
    view.alert(error);
  }

  void _didAllFinish(bool isAuthenticated) {
    switch (isAuthenticated) {
      case true:
        router.replaceToHomeScreen(context: view.context);
        break;
      case false:
        router.replaceToLoginScreen(context: view.context);
        break;
    }
  }
}
