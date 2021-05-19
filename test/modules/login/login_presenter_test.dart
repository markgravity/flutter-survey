import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quick_test/quick_test.dart';
import 'package:survey/modules/login/login_module.dart';

import '../../mocks/build_context.dart';
import 'login_presenter_test.mocks.dart';

@GenerateMocks([LoginView, LoginInteractor, LoginRouter])
void main() {
  describe("a Login presenter", () {
    late LoginPresenterImpl presenter;
    late MockLoginInteractor interactor;
    late MockLoginRouter router;
    late MockLoginView view;

    beforeEach(() {
      interactor = MockLoginInteractor();
      router = MockLoginRouter();

      view = MockLoginView();
      when(view.context).thenReturn(MockBuildContext());

      presenter = LoginPresenterImpl();
      presenter.configure(view: view, interactor: interactor, router: router);
    });

    describe("its didChangeEmailText and didChangePasswordText emit", () {
      context("when one of them is emptied", () {
        beforeEach(() {
          presenter.passwordTextFieldDidChange.add("");
          presenter.emailTextFieldDidChange.add("email");
        });

        it("triggers view to disable login button", () {
          verify(view.setLoginButton(isEnabled: false)).called(1);
        });
      });

      context("when both of them are not emptied", () {
        beforeEach(() {
          presenter.passwordTextFieldDidChange.add("password");
          presenter.emailTextFieldDidChange.add("email");
        });

        it("triggers view to enable login button", () {
          verify(view.setLoginButton(isEnabled: true)).called(1);
        });
      });
    });

    describe("its didInitState emits", () {
      beforeEach(() {
        presenter.stateDidInit.add(null);
      });

      it("triggers view to disable login button and begin animation", () {
        verify(view.setLoginButton(isEnabled: false)).called(1);
        verify(view.beginAnimation()).called(1);
      });
    });

    describe("its didTapForgotButton emits", () {
      beforeEach(() {
        presenter.forgotButtonDidTap.add(null);
      });

      it("triggers router to push to Forgot Password screen", () {
        verify(router.pushToForgotPasswordScreen(any)).called(1);
      });
    });

    describe("its didTapLoginButton emits", () {
      beforeEach(() {
        presenter.loginButtonDidTap.add(["", ""]);
      });

      it("triggers view to show progress HUD", () {
        verify(view.showProgressHUD()).called(1);
      });

      it("triggers interactor to login", () {
        verify(interactor.login("", "")).called(1);
      });
    });

    describe("its didLogin emits", () {
      beforeEach(() {
        presenter.didLogin.add(null);
      });

      it("triggers router to replace to Home screen", () {
        verify(router.replaceToHomeScreen(any)).called(1);
      });
    });

    describe("its didFailToLogin emits", () {
      final error = Exception();
      beforeEach(() {
        presenter.didFailToLogin.add(error);
      });

      it("triggers view to dismiss progress hud and alert error", () {
        verify(view.dismissProgressHUD()).called(1);
        verify(view.alert(error)).called(1);
      });
    });
  });
}
