import 'package:quick_test/quick_test.dart';
import 'package:survey/models/detailed_survey_info.dart';
import 'package:survey/modules/survey_detail/survey_detail_module.dart';

import '../../mocks/build_context.dart';

void main() {
  describe("a SurveyDetail router", () {
    late SurveyDetailRouter router;
    late MockBuildContext buildContext;

    beforeEach(() {
      buildContext = MockBuildContext();

      router = SurveyDetailRouterImpl();
    });

    describe("its pushToSurveyQuestionsScreen is called", () {
      beforeEach(() {
        router.pushToSurveyQuestionsScreen(buildContext,
            survey: DetailedSurveyInfo());
      });
    });
  });
}
