import 'package:flutter/widgets.dart';
import 'package:survey/core/viper/module.dart';
import 'package:survey/modules/screen.dart';

class ForgotPasswordModule extends Module {
  static const routePath = "/forgot-password";

  @override
  Widget build(BuildContext context) {
    return const Screen(
      body: Center(
        child: Text("Forgot Password"),
      ),
    );
  }
}
