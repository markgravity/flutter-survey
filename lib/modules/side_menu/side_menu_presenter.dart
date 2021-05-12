part of 'side_menu_module.dart';

abstract class SideMenuPresenter
    extends Presenter<SideMenuView, SideMenuInteractor, SideMenuRouter> {}

class SideMenuPresenterImpl extends SideMenuPresenter
    implements SideMenuViewDelegate, SideMenuInteractorDelegate {
  SideMenuPresenterImpl() {
    logoutButtonDidTap.voidListen(_logoutButtonDidTap);
    logoutDidSuccess.voidListen(_logoutDidSuccess);
  }

  @override
  final logoutButtonDidTap = BehaviorSubject<void>();

  @override
  final logoutDidSuccess = BehaviorSubject<void>();

  void _logoutButtonDidTap() {
    interactor.logout();
  }

  void _logoutDidSuccess() {
    router.replaceToLoginScreen(view.context);
  }
}
