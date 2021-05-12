part of 'side_menu_module.dart';

abstract class SideMenuRouter extends Router {
  void replaceToLoginScreen(BuildContext context);
}

class SideMenuRouterImpl extends SideMenuRouter {
  @override
  void replaceToLoginScreen(BuildContext context) {
    context.navigator.pushReplacementNamed(LoginModule.routePath);
  }
}
