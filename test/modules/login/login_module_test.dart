import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quick_test/quick_test.dart';
import 'package:survey/modules/login/login_module.dart';

import '../../mocks/build_context.dart';

void main() {
  describe("a Login module", () {
    late LoginModule module;

    beforeEach(() {
      module = LoginModule();
    });

    context("its build() is called", () {
      late Widget widget;

      beforeEach(() {
        widget = module.build(MockBuildContext());
      });

      it("returns LoginViewImpl", () {
        expect(widget, isA<LoginViewImpl>());
      });
    });
  });
}
