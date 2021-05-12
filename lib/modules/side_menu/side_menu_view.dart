part of 'side_menu_module.dart';

abstract class SideMenuViewDelegate {
  BehaviorSubject<void> get logoutButtonDidTap;
}

abstract class SideMenuView extends View<SideMenuViewDelegate> {
  void setUser(UserInfo user);
}

class SideMenuViewImpl extends StatefulWidget {
  const SideMenuViewImpl({Key? key}) : super(key: key);

  @override
  _SideMenuViewImplState createState() => _SideMenuViewImplState();
}

class _SideMenuViewImplState
    extends ViewState<SideMenuViewImpl, SideMenuModule, SideMenuViewDelegate>
    implements SideMenuView {
  final _user = BehaviorSubject<UserInfo>();

  @override
  void initState() {
    super.initState();

    final user = UserInfo();
    user.email = "mark@nimblehq.co";
    user.avatarUrl =
        "https://en.gravatar.com/userimage/137591909/6a42a5a20cd79d50edb957644bc41b0c.png";
    setUser(user);
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
