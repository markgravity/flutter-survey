part of 'side_menu_module.dart';

abstract class SideMenuPresenter
    extends Presenter<SideMenuView, SideMenuInteractor, SideMenuRouter> {}

class SideMenuPresenterImpl extends SideMenuPresenter
    implements SideMenuViewDelegate, SideMenuInteractorDelegate {
  @override
  final logoutButtonDidTap = BehaviorSubject<void>();
}
