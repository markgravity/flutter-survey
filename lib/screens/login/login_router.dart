import 'package:flutter/widgets.dart';
import 'package:survey/gen/configs.gen.dart';

abstract class LoginRouter {
  void replaceToHomeScreen({required BuildContext context});
}

class LoginRouterImpl implements LoginRouter {
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
