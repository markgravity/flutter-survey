import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:quick_test/quick_test.dart';
import 'package:survey/modules/landing/landing_module.dart';

import '../../mocks/build_context.dart';

@GenerateMocks([LandingRouter, LandingInteractor])
void main() {
  describe("a Landing module", () {
    late LandingModule module;
    beforeEach(() {
      module = LandingModule();
    });

    describe("it builds", () {
      late Widget widget;

      beforeEach(() {
        widget = module.build(MockBuildContext());
      });

      it("returns LandingViewImpl", () {
        expect(widget, isA<LandingViewImpl>());
      });
    });
  });
}
