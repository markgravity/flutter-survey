import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quick_test/quick_test.dart';
import 'package:survey/modules/survey_detail/survey_detail_module.dart';

import '../../mocks/build_context.dart';

void main() {
  describe("a SurveyDetail module", () {
    late SurveyDetailModule module;
    beforeEach(() {
      module = SurveyDetailModule();
    });

    describe("its build is called", () {
      late Widget widget;

      beforeEach(() {
        widget = module.build(MockBuildContext());
      });

      it("returns SurveyDetailViewImpl", () {
        expect(widget, isA<SurveyDetailViewImpl>());
      });
    });
  });
}
