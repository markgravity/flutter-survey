part of 'landing_module.dart';

abstract class LandingRouter extends Router {
  void replaceToLoginScreen({required BuildContext context});

  void replaceToHomeScreen({required BuildContext context});
}

class LandingRouterImpl implements LandingRouter {
  @override
  void replaceToLoginScreen({required BuildContext context}) {
    context.navigator.pushReplacementNamedWithoutAnimation("/login");
  }

  @override
  void replaceToHomeScreen({required BuildContext context}) {
    context.navigator.pushReplacementNamedWithoutAnimation("/home");
  }
}
