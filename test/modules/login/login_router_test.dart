import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quick_test/quick_test.dart';
import 'package:survey/modules/forgot_password/forgot_password_module.dart';
import 'package:survey/modules/home/home_module.dart';
import 'package:survey/modules/login/login_module.dart';

import '../../mocks/build_context.dart';
import '../../mocks/navigator_state.dart';

void main() {
  describe("a Login router", () {
    late LoginRouter router;
    late MockBuildContext buildContext;
    late MockNavigatorState navigatorState;

    beforeEach(() {
      buildContext = MockBuildContext();
      navigatorState = MockNavigatorState();
      when(buildContext.findAncestorStateOfType<NavigatorState>())
          .thenReturn(navigatorState);
      when(navigatorState.pushReplacementNamed(any))
          .thenAnswer((_) => Future.value());
      when(navigatorState.pushNamed(any)).thenAnswer((_) => Future.value());

      router = LoginRouterImpl();
    });

    describe("it's replaceToHomeScreen() is called", () {
      beforeEach(() {
        router.replaceToHomeScreen(buildContext);
      });

      it("triggers navigator to push replacement to Home screen", () {
        verify(navigatorState.pushReplacementNamed(HomeModule.routePath));
      });
    });

    describe("it's pushToForgotPasswordScreen() is called", () {
      beforeEach(() {
        router.pushToForgotPasswordScreen(buildContext);
      });

      it("triggers navigator to push to Forgot Password screen", () {
        verify(navigatorState.pushNamed(ForgotPasswordModule.routePath));
      });
    });
  });
}
