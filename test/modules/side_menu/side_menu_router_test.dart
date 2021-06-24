import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quick_test/quick_test.dart';
import 'package:survey/modules/login/login_module.dart';
import 'package:survey/modules/side_menu/side_menu_module.dart';

import '../../mocks/build_context.dart';
import '../../mocks/navigator_state.dart';

void main() {
  describe("a SideMenu router", () {
    late SideMenuRouter router;
    late MockBuildContext buildContext;
    late MockNavigatorState navigatorState;

    beforeEach(() {
      buildContext = MockBuildContext();
      navigatorState = MockNavigatorState();

      router = SideMenuRouterImpl();
    });

    describe("it's replaceToLoginScreen() is called", () {
      beforeEach(() {
        when(buildContext.findAncestorStateOfType<NavigatorState>())
            .thenReturn(navigatorState);
        when(navigatorState.pushReplacementNamed(any))
            .thenAnswer((_) => Future.value());
        router.replaceToLoginScreen(buildContext);
      });

      it("triggers navigator to push replacement to Login screen", () {
        final routePath =
            verify(navigatorState.pushReplacementNamed(captureAny))
                .captured
                .single as String;
        expect(routePath, LoginModule.routePath);
      });
    });
  });
}
