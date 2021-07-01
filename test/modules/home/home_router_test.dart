import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quick_test/quick_test.dart';
import 'package:survey/models/survey_info.dart';
import 'package:survey/modules/home/home_module.dart';
import 'package:survey/modules/survey_detail/survey_detail_module.dart';

import '../../mocks/build_context.dart';
import '../../mocks/navigator_state.dart';

void main() {
  describe("a Home router", () {
    late HomeRouter router;
    late MockBuildContext buildContext;
    late MockNavigatorState navigatorState;

    beforeEach(() {
      buildContext = MockBuildContext();
      navigatorState = MockNavigatorState();

      router = HomeRouterImpl();
    });

    describe("its pushToSurveyDetail() is called", () {
      beforeEach(() {
        when(buildContext.findAncestorStateOfType<NavigatorState>())
            .thenReturn(navigatorState);
        when(navigatorState.pushNamed(any)).thenAnswer((_) => Future.value());
        router.pushToSurveyDetail(context: buildContext, survey: SurveyInfo());
      });

      it("triggers navigator to push to Survey Detail screen", () {
        final routePath = verify(navigatorState.pushNamed(captureAny))
            .captured
            .single as String;
        expect(routePath, SurveyDetailModule.routePath);
      });
    });
  });
}
