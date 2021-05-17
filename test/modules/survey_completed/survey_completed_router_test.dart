import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quick_test/quick_test.dart';
import 'package:survey/modules/survey_completed/survey_completed_module.dart';

import '../../mocks/build_context.dart';
import '../../mocks/navigator_state.dart';

void main() {
  describe("a SurveyCompleted router", () {
    late SurveyCompletedRouter router;
    late MockBuildContext buildContext;
    late MockNavigatorState navigatorState;

    beforeEach(() {
      buildContext = MockBuildContext();
      navigatorState = MockNavigatorState();

      router = SurveyCompletedRouterImpl();
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
