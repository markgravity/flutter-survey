import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quick_test/quick_test.dart';
import 'package:survey/modules/survey_questions/survey_questions_module.dart';

import '../../mocks/build_context.dart';

void main() {
  describe("a SurveyQuestions module", () {
    late SurveyQuestionsModule module;
    beforeEach(() {
      module = SurveyQuestionsModule();
    });

    describe("it's build is called", () {
      late Widget widget;

      beforeEach(() {
        widget = module.build(MockBuildContext());
      });

      it("returns SurveyQuestionsViewImpl", () {
        expect(widget, isA<SurveyQuestionsViewImpl>());
      });
    });
  });
}
