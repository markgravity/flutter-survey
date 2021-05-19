import 'package:flutter/widgets.dart';
import 'package:survey/core/viper/module.dart';
import 'package:survey/modules/screen.dart';

class LoginModule extends Module {
  static const routePath = "/login";

  @override
  Widget build(BuildContext context) {
    return const Screen(
      body: Center(
        child: Text("Login"),
      ),
    );
  }
}
