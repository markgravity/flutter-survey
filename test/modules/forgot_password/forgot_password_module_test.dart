import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quick_test/quick_test.dart';
import 'package:survey/modules/forgot_password/forgot_password_module.dart';

import '../../mocks/build_context.dart';

void main() {
  describe("a ForgotPassword module", () {
    late ForgotPasswordModule module;
    beforeEach(() {
      module = ForgotPasswordModule();
    });

    describe("its build() is called", () {
      late Widget widget;

      beforeEach(() {
        widget = module.build(MockBuildContext());
      });

      it("returns ForgotPasswordViewImpl", () {
        expect(widget, isA<ForgotPasswordViewImpl>());
      });
    });
  });
}
