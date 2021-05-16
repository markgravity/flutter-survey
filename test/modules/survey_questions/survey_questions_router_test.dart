import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quick_test/quick_test.dart';
import 'package:survey/models/survey_question_info.dart';
import 'package:survey/modules/survey_completed/survey_completed_module.dart';
import 'package:survey/modules/survey_questions/survey_questions_module.dart';

import '../../mocks/build_context.dart';
import '../../mocks/navigator_state.dart';

void main() {
  describe("a SurveyQuestions router", () {
    late SurveyQuestionsRouter router;
    late MockBuildContext buildContext;
    late MockNavigatorState navigatorState;

    beforeEach(() {
      buildContext = MockBuildContext();
      navigatorState = MockNavigatorState();

      router = SurveyQuestionsRouterImpl();
    });

    describe("it's pushToSurveyCompletedScreen() is called", () {
      beforeEach(() {
        when(buildContext.findAncestorStateOfType<NavigatorState>())
            .thenReturn(navigatorState);
        when(navigatorState.pushReplacementNamed(any,
                arguments: anyNamed("arguments")))
            .thenAnswer((_) => Future.value());
        router.pushToSurveyCompletedScreen(buildContext,
            outro: SurveyQuestionInfo());
      });

      it("triggers navigator to push replacement to Survey Completed screen",
          () {
        final routePath = verify(navigatorState.pushReplacementNamed(captureAny,
                arguments: anyNamed("arguments")))
            .captured
            .single as String;
        expect(routePath, SurveyCompletedModule.routePath);
      });
    });

    describe("it's popBack() is called", () {
      beforeEach(() {
        when(buildContext.findAncestorStateOfType<NavigatorState>())
            .thenReturn(navigatorState);
        when(navigatorState.pop()).thenAnswer((_) => Future.value());
        router.popBack(buildContext);
      });

      it("triggers navigator to pop back", () {
        verify(navigatorState.pop()).called(1);
      });
    });
  });
}
