import 'package:flutter/widgets.dart';
import 'package:survey/core/viper/module.dart';
import 'package:survey/modules/screen.dart';

class SideMenuModule extends Module {
  static const routePath = "/side-menu";

  @override
  Widget build(BuildContext context) {
    return const Screen(
      body: Center(
        child: Text("Side Menu"),
      ),
    );
  }
}
