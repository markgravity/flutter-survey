import 'package:flutter/widgets.dart';
import 'package:survey/core/viper/module.dart';
import 'package:survey/modules/screen.dart';

class SurveyDetailModule extends Module {
  static const routePath = "/survey/detail";

  @override
  Widget build(BuildContext context) {
    return const Screen(
      body: Center(
        child: Text("Survey Detail"),
      ),
    );
  }
}
