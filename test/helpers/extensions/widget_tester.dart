import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:survey/app.dart';

extension WidgetTesterExtension on WidgetTester {
  Future<void> pumpModule(Widget module) {
    return pumpWidget(App(
      overrideHome: module,
    ));
  }
}
