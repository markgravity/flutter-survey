import 'package:flutter/cupertino.dart' hide Router;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quick_test/quick_widget_test.dart';
import 'package:survey/core/viper/module.dart';
import 'package:survey/modules/landing/landing_module.dart';

import '../../fakers/fake_module.dart';
import '../../helpers/behavior_subject_generator.dart';
import '../../helpers/extensions/widget_tester.dart';
import 'landing_view_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<LandingViewDelegate>(returnNullOnMissingStub: true),
])
void main() {
  describe("a Landing view", () {
    late FakeModule<LandingView, LandingViewDelegate> module;
    late MockLandingViewDelegate delegate;
    late BehaviorSubjectGenerator generator;

    beforeEach((_) async {
      generator = BehaviorSubjectGenerator();
      delegate = MockLandingViewDelegate();
      when(delegate.animationDidFinish)
          .thenAnswer((realInvocation) => generator.make(0));
      when(delegate.stateDidInit)
          .thenAnswer((realInvocation) => generator.make(1));
      when(delegate.alertDialogDidClose)
          .thenAnswer((realInvocation) => generator.make(2));

      module = FakeModule(
        builder: () => const LandingViewImpl(),
        delegate: delegate,
      );
      ViewState.overriddenModule = module;
    });

    describe("it at initial state", () {
      beforeEach((tester) async {
        await tester.pumpModule(module);
      });

      it("shows background and hides logo", (tester) async {
        final fadeTransition = tester.widget<FadeTransition>(
            find.byKey(LandingView.fadeTransitionLogoKey));
        expect(fadeTransition.opacity.value, 0);
        expect(find.byKey(LandingView.backgroundKey), findsOneWidget);
      });
    });

    describe("it's beginAnimation() is called", () {
      beforeEach((tester) async {
        await tester.pumpModule(module);
        module.view.beginAnimation();

        await tester.pumpAndSettle();
      });

      it("shows logo", (tester) async {
        expect(
          tester
              .widget<FadeTransition>(
                  find.byKey(LandingView.fadeTransitionLogoKey))
              .opacity
              .value,
          1,
        );
      });

      it("triggers delegate to call didFinishAnimation()", (tester) async {
        expect(delegate.animationDidFinish, emits(null));
      });
    });

    describe("it's alert() is called", () {
      const message = "A error message";

      beforeEach((tester) async {
        await tester.pumpModule(module);
        module.view.alert(message);

        await tester.pumpAndSettle();
      });

      it("shows alert dialog", (tester) async {
        expect(find.text(message), findsOneWidget);
      });

      context("when alert dialog is closed", () {
        beforeEach((tester) async {
          await tester.tap(find.text("OK"));
        });

        it("triggers delegate to call to didCloseAlertDialog()",
            (tester) async {
          expect(delegate.alertDialogDidClose, emits(null));
        });
      });
    });
  });
}
