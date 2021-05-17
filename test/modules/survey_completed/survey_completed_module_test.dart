import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quick_test/quick_test.dart';
import 'package:survey/modules/survey_completed/survey_completed_module.dart';

import '../../mocks/build_context.dart';

void main() {
  describe("a SurveyCompleted module", () {
    late SurveyCompletedModule module;
    beforeEach(() {
      module = SurveyCompletedModule();
    });

    describe("it's build is called", () {
      late Widget widget;

      beforeEach(() {
        widget = module.build(MockBuildContext());
      });

      it("returns SurveyCompletedViewImpl", () {
        expect(widget, isA<SurveyCompletedViewImpl>());
      });
    });
  });
}
