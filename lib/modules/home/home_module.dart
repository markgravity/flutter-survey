import 'package:flutter/widgets.dart';
import 'package:survey/core/viper/module.dart';
import 'package:survey/modules/screen.dart';

class HomeModule extends Module {
  static const routePath = "/home";

  @override
  Widget build(BuildContext context) {
    return const Screen(
      body: Center(
        child: Text("Home"),
      ),
    );
  }
}
