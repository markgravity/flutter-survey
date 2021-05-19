import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quick_test/quick_widget_test.dart';
import 'package:survey/components/button/button.dart';
import 'package:survey/components/common/progress_hud.dart';
import 'package:survey/core/viper/module.dart';
import 'package:survey/modules/login/login_module.dart';

import '../../fakers/fake_module.dart';
import '../../helpers/behavior_subject_generator.dart';
import '../../helpers/extensions/widget_tester.dart';
import 'login_view_test.mocks.dart';

@GenerateMocks([LoginViewDelegate])
void main() {
  describe("a Login view", () {
    late FakeModule<LoginView, LoginViewDelegate> module;
    late MockLoginViewDelegate delegate;
    late BehaviorSubjectGenerator generator;

    beforeEach((_) async {
      generator = BehaviorSubjectGenerator();
      delegate = MockLoginViewDelegate();
      when(delegate.emailTextFieldDidChange)
          .thenAnswer((realInvocation) => generator.make(0));
      when(delegate.passwordTextFieldDidChange)
          .thenAnswer((realInvocation) => generator.make(1));
      when(delegate.stateDidInit)
          .thenAnswer((realInvocation) => generator.make(2));
      when(delegate.loginButtonDidTap)
          .thenAnswer((realInvocation) => generator.make(3));
      when(delegate.forgotButtonDidTap)
          .thenAnswer((realInvocation) => generator.make(4));

      module = FakeModule(
        builder: () => LoginViewImpl(),
        delegate: delegate,
      );
      ViewState.overriddenModule = module;
    });

    describe("it at initial state", () {
      beforeEach((tester) async {
        await tester.pumpModule(module);
        await tester.pumpAndSettle();
      });

      it("shows logo & background only", (tester) async {
        final opacityForm =
            tester.widget<Opacity>(find.byKey(LoginView.opacityFormKey));
        expect(opacityForm.opacity, 0);

        expect(find.byKey(LoginView.backgroundImageKey), findsOneWidget);
        expect(find.byKey(LoginView.logoImageKey), findsOneWidget);
      });
    });

    describe("its beginAnimation() is called", () {
      beforeEach((tester) async {
        await tester.pumpModule(module);
        module.view.beginAnimation();
        await tester.pumpAndSettle(LoginView.animationDuration);
      });

      it("triggers to fade in the form", (tester) async {
        final opacityForm =
            tester.widget<Opacity>(find.byKey(LoginView.opacityFormKey));
        expect(opacityForm.opacity, 1);
        expect(find.byKey(LoginView.emailTextFieldKey), findsOneWidget);
        expect(find.byKey(LoginView.passwordTextFieldKey), findsOneWidget);
        expect(find.byKey(LoginView.loginButtonKey), findsOneWidget);
        expect(find.byKey(LoginView.forgotButtonKey), findsOneWidget);
      });
    });

    describe("its showProgressHUD() is called", () {
      beforeEach((tester) async {
        await tester.pumpModule(module);
        module.view.showProgressHUD();
        await tester.pump();
      });

      it("triggers to show progress HUD", (tester) async {
        final progressHUD =
            tester.widget<ProgressHUD>(find.byKey(LoginView.progressHUDKey));
        expect(progressHUD.isShow, true);
      });
    });

    describe("its dismissProgressHUD() is called", () {
      beforeEach((tester) async {
        await tester.pumpModule(module);
        module.view.dismissProgressHUD();
        await tester.pump();
      });

      it("triggers to hide progress HUD", (tester) async {
        final progressHUD =
            tester.widget<ProgressHUD>(find.byKey(LoginView.progressHUDKey));
        expect(progressHUD.isShow, false);
      });
    });

    describe("its setLoginButton() is called", () {
      context("isEnabled is true", () {
        beforeEach((tester) async {
          await tester.pumpModule(module);
          module.view.setLoginButton(isEnabled: true);
          await tester.pumpAndSettle();
        });

        it("triggers to enable login button", (tester) async {
          final loginButton =
              tester.widget<Button>(find.byKey(LoginView.loginButtonKey));
          expect(loginButton.isEnabled, true);
        });
      });

      context("isEnabled is false", () {
        beforeEach((tester) async {
          await tester.pumpModule(module);
          module.view.setLoginButton(isEnabled: false);
          await tester.pumpAndSettle();
        });

        it("triggers to enable login button", (tester) async {
          final loginButton =
              tester.widget<Button>(find.byKey(LoginView.loginButtonKey));
          expect(loginButton.isEnabled, false);
        });
      });
    });

    describe("its alert() is called", () {
      const message = "a message";
      beforeEach((tester) async {
        await tester.pumpModule(module);
        module.view.alert(message);
        await tester.pumpAndSettle();
      });

      it("triggers to alert message", (tester) async {
        expect(find.text(message), findsOneWidget);
      });
    });

    describe("its email text field is changed", () {
      const text = "a text";
      beforeEach((tester) async {
        await tester.pumpModule(module);
        await tester.pumpAndSettle();
        await tester.enterText(find.byKey(LoginView.emailTextFieldKey), text);
      });

      it("triggers to delegate's didChangeEmailText emits", (tester) async {
        expect(delegate.emailTextFieldDidChange, emits(text));
      });
    });

    context("its password text field is changed", () {
      const text = "a text";
      beforeEach((tester) async {
        await tester.pumpModule(module);
        await tester.pumpAndSettle();
        await tester.enterText(
            find.byKey(LoginView.passwordTextFieldKey), text);
      });

      it("triggers to delegate's didChangePasswordText emits", (tester) async {
        expect(delegate.passwordTextFieldDidChange, emits(text));
      });
    });

    context("its login button is tapped", () {
      beforeEach((tester) async {
        await tester.pumpModule(module);
        module.view.setLoginButton(isEnabled: true);
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(LoginView.loginButtonKey));
      });

      it("triggers to delegate's didTapLoginButton emits", (tester) async {
        expect(delegate.loginButtonDidTap, emits(["", ""]));
      });
    });

    context("its forgot button is tapped", () {
      beforeEach((tester) async {
        await tester.pumpModule(module);
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(LoginView.forgotButtonKey));
      });

      it("triggers to delegate's didTapLoginButton emits", (tester) async {
        expect(delegate.forgotButtonDidTap, emits(null));
      });
    });
  });
}
