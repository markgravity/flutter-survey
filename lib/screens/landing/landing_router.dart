import 'package:flutter/widgets.dart';
import 'package:survey/gen/configs.gen.dart';

abstract class LandingRouter {
  void replaceToLoginScreen({required BuildContext context});

  void replaceToHomeScreen({required BuildContext context});
}

class LandingRouterImpl implements LandingRouter {
  @override
  void replaceToLoginScreen({required BuildContext context}) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, _, __) => Configs.routes["/login"]!(context),
        transitionDuration: const Duration(),
      ),
    );
  }

  @override
  void replaceToHomeScreen({required BuildContext context}) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, _, __) => Configs.routes["/home"]!(context),
        transitionDuration: const Duration(),
      ),
    );
  }
}
