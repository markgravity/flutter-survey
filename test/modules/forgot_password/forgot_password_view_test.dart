import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quick_test/quick_widget_test.dart';
import 'package:survey/components/button/button.dart';
import 'package:survey/components/translucent_text_field/translucent_text_field.dart';
import 'package:survey/core/viper/module.dart';
import 'package:survey/modules/forgot_password/forgot_password_module.dart';

import '../../fakers/fake_module.dart';
import '../../helpers/behavior_subject_generator.dart';
import '../../helpers/extensions/widget_tester.dart';
import 'forgot_password_view_test.mocks.dart';

@GenerateMocks([ForgotPasswordViewDelegate])
void main() {
  describe("a ForgotPassword view", () {
    late FakeModule<ForgotPasswordView, ForgotPasswordViewDelegate> module;
    late MockForgotPasswordViewDelegate delegate;
    late BehaviorSubjectGenerator generator;

    beforeEach((tester) async {
      generator = BehaviorSubjectGenerator();
      delegate = MockForgotPasswordViewDelegate();
      when(delegate.emailTextFieldDidChange)
          .thenAnswer((realInvocation) => generator.make(0));
      when(delegate.resetButtonDidTap)
          .thenAnswer((realInvocation) => generator.make(1));
      when(delegate.alertDialogDidClose)
          .thenAnswer((realInvocation) => generator.make(2));

      module = FakeModule(
        builder: () => const ForgotPasswordViewImpl(),
        delegate: delegate,
      );
      ViewState.overriddenModule = module;

      await tester.pumpModule(module);
      await tester.pumpAndSettle();
    });

    describe("its clearEmailTextField() is called", () {
      beforeEach((tester) async {
        module.view.clearEmailTextField();
        await tester.pumpAndSettle();
      });

      it("triggers to clear email text field's text", (tester) async {
        final textField = tester.widget<TranslucentTextField>(
            find.byKey(ForgotPasswordView.emailTextFieldKey));
        expect(textField.controller!.text, "");
      });
    });

    describe("its setResetButton() is called", () {
      context("when isEnabled is true", () {
        beforeEach((tester) async {
          module.view.setResetButton(isEnabled: true);
          await tester.pumpAndSettle();
        });

        it("triggers to enable Reset button", (tester) async {
          final button = tester
              .widget<Button>(find.byKey(ForgotPasswordView.resetButtonKey));
          expect(button.isEnabled, isTrue);
        });
      });

      context("when isEnabled is false", () {
        beforeEach((tester) async {
          module.view.setResetButton(isEnabled: false);
          await tester.pumpAndSettle();
        });

        it("triggers to disable Reset button", (tester) async {
          final button = tester
              .widget<Button>(find.byKey(ForgotPasswordView.resetButtonKey));
          expect(button.isEnabled, isFalse);
        });
      });
    });

    describe("its showResetSuccessfullyNotification() is called", () {
      beforeEach((tester) async {
        module.view.showResetSuccessfullyNotification();
        await tester.pump(
            ForgotPasswordView.showingResetSuccessfullyNotificationDuration);
        await tester.pump(
            ForgotPasswordView.showingResetSuccessfullyNotificationDuration);
      });

      it("triggers to show reset successfully notification", (tester) async {
        final transition = tester.widget<SlideTransition>(find.byKey(
            ForgotPasswordView
                .resetSuccessfullyNotificationSlideTransitionKey));
        expect(
            transition.position.value,
            ForgotPasswordView
                .resetSuccessfullyNotificationSlideTransitionEndOffset);
      });

      context("when dismissing delay duration comes", () {
        beforeEach((tester) async {
          await tester.pumpAndSettle();
          await tester.pump(ForgotPasswordView
              .dismissResetSuccessfullyNotificationDelayDuration);
          await tester.pumpAndSettle();
        });

        it("triggers to dismiss reset successfully notification",
            (tester) async {
          final transition = tester.widget<SlideTransition>(find.byKey(
              ForgotPasswordView
                  .resetSuccessfullyNotificationSlideTransitionKey));
          expect(
              transition.position.value,
              ForgotPasswordView
                  .resetSuccessfullyNotificationSlideTransitionBeginOffset);
        });
      });

      context("when it is tapped", () {
        beforeEach((tester) async {
          await tester.tap(
              find.byKey(ForgotPasswordView.resetSuccessfullyNotificationKey));
          await tester.pumpAndSettle();
        });

        it("triggers to dismiss reset successfully notification manually",
            (tester) async {
          final transition = tester.widget<SlideTransition>(find.byKey(
              ForgotPasswordView
                  .resetSuccessfullyNotificationSlideTransitionKey));
          expect(
              transition.position.value,
              ForgotPasswordView
                  .resetSuccessfullyNotificationSlideTransitionBeginOffset);
        });
      });
    });

    describe("its reset button is tapped", () {
      beforeEach((tester) async {
        module.view.setResetButton(isEnabled: true);
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(ForgotPasswordView.resetButtonKey));
      });

      it("triggers delegate's resetButtonDidTap emits", (tester) async {
        expect(delegate.resetButtonDidTap, emits(""));
      });
    });

    describe("its email text field is changed", () {
      const text = "a text";
      beforeEach((tester) async {
        await tester.enterText(
            find.byKey(ForgotPasswordView.emailTextFieldKey), text);
      });

      it("triggers delegate's emailTextFieldDidChange emits", (tester) async {
        expect(delegate.emailTextFieldDidChange, emits(text));
      });
    });
  });
}
