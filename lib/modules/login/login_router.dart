part of 'login_module.dart';

abstract class LoginRouter extends Router {
  void replaceToHomeScreen(BuildContext context);

  void pushToForgotPasswordScreen(BuildContext context);
}

class LoginRouterImpl extends LoginRouter {
  @override
  void replaceToHomeScreen(BuildContext context) {
    context.navigator.pushReplacementNamed(HomeModule.routePath);
  }

  @override
  void pushToForgotPasswordScreen(BuildContext context) {
    context.navigator.pushNamed(ForgotPasswordModule.routePath);
  }
}
