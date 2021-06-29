part of 'side_menu_module.dart';

abstract class SideMenuPresenter
    extends Presenter<SideMenuView, SideMenuInteractor, SideMenuRouter> {}

class SideMenuPresenterImpl extends SideMenuPresenter
    implements SideMenuViewDelegate, SideMenuInteractorDelegate {
  SideMenuPresenterImpl() {
    logoutButtonDidTap.voidListen(_logoutButtonDidTap).addTo(disposeBag);
    logoutDidSuccess.voidListen(_logoutDidSuccess).addTo(disposeBag);
    logoutDidFail.listen(_logoutDidFail).addTo(disposeBag);
    stateDidInit.voidListen(_stateDidInit).addTo(disposeBag);
  }

  @override
  final stateDidInit = BehaviorSubject<void>();

  @override
  final logoutButtonDidTap = BehaviorSubject<void>();

  @override
  final logoutDidSuccess = BehaviorSubject<void>();

  @override
  final logoutDidFail = BehaviorSubject<Exception>();

  @override
  final alertDialogDidClose = BehaviorSubject<void>();

  void _logoutButtonDidTap() {
    interactor.logout();
  }

  void _logoutDidSuccess() {
    router.replaceToLoginScreen(view.context);
  }

  void _stateDidInit() {
    view.setUser(interactor.authenticatedUser);
  }

  void _logoutDidFail(Exception exception) {
    view.alert(exception);
  }
}
