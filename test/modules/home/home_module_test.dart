import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quick_test/quick_test.dart';
import 'package:survey/modules/home/home_module.dart';

import '../../mocks/build_context.dart';

void main() {
  describe("a Home module", () {
    late HomeModule module;
    beforeEach(() {
      module = HomeModule();
    });

    describe("its build is called", () {
      late Widget widget;

      beforeEach(() {
        widget = module.build(MockBuildContext());
      });

      it("returns LandingViewImpl", () {
        expect(widget, isA<HomeViewImpl>());
      });
    });
  });
}
