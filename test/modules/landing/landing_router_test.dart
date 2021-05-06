import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quick_test/quick_test.dart';
import 'package:survey/modules/home/home_module.dart';
import 'package:survey/modules/landing/landing_module.dart';
import 'package:survey/modules/login/login_module.dart';

import '../../mocks/build_context.dart';
import '../../mocks/navigator_state.dart';

class FakeAnimation extends Mock implements Animation<double> {}

void main() {
  describe("a Landing router", () {
    late LandingRouter router;
    late MockBuildContext buildContext;
    late MockNavigatorState navigatorState;

    beforeEach(() {
      buildContext = MockBuildContext();
      navigatorState = MockNavigatorState();

      router = LandingRouterImpl();
    });

    describe("it's replaceToLoginScreen() is called", () {
      beforeEach(() {
        when(buildContext.findAncestorStateOfType<NavigatorState>())
            .thenReturn(navigatorState);
        when(navigatorState.pushReplacement(any))
            .thenAnswer((_) => Future.value());
        router.replaceToLoginScreen(context: buildContext);
      });

      it("triggers navigator to push replacement to Login screen", () {
        final PageRouteBuilder builder =
            verify(navigatorState.pushReplacement(captureAny)).captured.single
                as PageRouteBuilder;
        final widget =
            builder.pageBuilder(buildContext, FakeAnimation(), FakeAnimation());
        expect(widget, isA<LoginModule>());
      });
    });

    describe("it's replaceToHomeScreen() is called", () {
      beforeEach(() {
        when(buildContext.findAncestorStateOfType<NavigatorState>())
            .thenReturn(navigatorState);
        when(navigatorState.pushReplacement(any))
            .thenAnswer((_) => Future.value());
        router.replaceToHomeScreen(context: buildContext);
      });

      it("triggers navigator to push replacement to Home screen", () {
        final PageRouteBuilder builder =
            verify(navigatorState.pushReplacement(captureAny)).captured.single
                as PageRouteBuilder;
        final widget =
            builder.pageBuilder(buildContext, FakeAnimation(), FakeAnimation());
        expect(widget, isA<HomeModule>());
      });
    });
  });
}
