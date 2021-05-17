import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quick_test/quick_test.dart';
import 'package:survey/models/detailed_survey_info.dart';
import 'package:survey/modules/survey_detail/survey_detail_module.dart';

import '../../mocks/build_context.dart';
import '../../mocks/navigator_state.dart';

void main() {
  describe("a SurveyDetail router", () {
    late SurveyDetailRouter router;
    late MockBuildContext buildContext;
    late MockNavigatorState navigatorState;

    beforeEach(() {
      buildContext = MockBuildContext();
      navigatorState = MockNavigatorState();

      router = SurveyDetailRouterImpl();
    });

    describe("it's pushToSurveyQuestionsScreen is called", () {
      beforeEach(() {
        router.pushToSurveyQuestionsScreen(buildContext,
            survey: DetailedSurveyInfo());
      });
    });
  });
}