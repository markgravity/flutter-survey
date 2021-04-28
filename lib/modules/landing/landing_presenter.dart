part of 'landing_module.dart';

abstract class LandingPresenter
    extends Presenter<LandingView, LandingInteractor, LandingRouter> {}

class LandingPresenterImpl extends LandingPresenter
    implements LandingInteractorDelegate, LandingViewDelegate {
  LandingPresenterImpl() {
    stateDidInit.voidListen(_stateDidInit);
    alertDialogDidClose.voidListen(_alertDialogDidClose);
    authenticationDidFailToValidate.listen(_authenticationDidFailToValidate);

    final List<Stream<dynamic>> streams = [
      animationDidFinish,
      authenticationDidValidate
    ];

    streams.zip().listen((event) {
      _didAllFinish(isAuthenticated: event[1] as bool);
    });
  }

  @override
  final stateDidInit = BehaviorSubject<void>();

  @override
  final alertDialogDidClose = BehaviorSubject<void>();

  @override
  final animationDidFinish = BehaviorSubject<void>();

  @override
  final authenticationDidFailToValidate = BehaviorSubject<Object>();

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

  void _didAllFinish({required bool isAuthenticated}) {
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
