part of 'side_menu_module.dart';

abstract class SideMenuViewDelegate with AlertViewMixinDelegate {
  BehaviorSubject<void> get stateDidInit;

  BehaviorSubject<void> get logoutButtonDidTap;
}

abstract class SideMenuView extends View<SideMenuViewDelegate>
    with AlertViewMixin {
  void setUser(UserInfo user);
}

class SideMenuViewImpl extends StatefulWidget {
  const SideMenuViewImpl({Key? key}) : super(key: key);

  @override
  _SideMenuViewImplState createState() => _SideMenuViewImplState();
}

class _SideMenuViewImplState
    extends ViewState<SideMenuViewImpl, SideMenuModule, SideMenuViewDelegate>
    with AlertViewMixin
    implements SideMenuView {
  final _user = BehaviorSubject<UserInfo>();

  @override
  void initState() {
    super.initState();
    delegate?.stateDidInit.add(null);
  }

  @override
  Widget build(BuildContext context) {
    return const Content();
  }

  @override
  void setUser(UserInfo user) {
    _user.add(user);
  }
}
