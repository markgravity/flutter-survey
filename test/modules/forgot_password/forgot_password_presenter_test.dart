import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quick_test/quick_test.dart';
import 'package:survey/modules/forgot_password/forgot_password_module.dart';

import '../../mocks/build_context.dart';
import 'forgot_password_presenter_test.mocks.dart';

@GenerateMocks([
  ForgotPasswordView,
  ForgotPasswordInteractor,
  ForgotPasswordRouter,
])
void main() {
  describe("a Landing presenter", () {
    late ForgotPasswordPresenterImpl presenter;
    late MockForgotPasswordView view;
    late MockForgotPasswordRouter router;
    late MockForgotPasswordInteractor interactor;
    late MockBuildContext buildContext;

    beforeEach(() {
      buildContext = MockBuildContext();

      view = MockForgotPasswordView();
      when(view.context).thenReturn(buildContext);

      router = MockForgotPasswordRouter();

      interactor = MockForgotPasswordInteractor();

      presenter = ForgotPasswordPresenterImpl();
      presenter.configure(view: view, interactor: interactor, router: router);
    });

    describe("its emailTextFieldDidChange emits", () {
      context("when email is emptied", () {
        beforeEach(() {
          presenter.emailTextFieldDidChange.add("");
        });

        it("trigger view to disable reset button", () {
          verify(view.setResetButton(isEnabled: false)).called(1);
        });
      });

      context("when email is not emptied", () {
        beforeEach(() {
          presenter.emailTextFieldDidChange.add("email");
        });

        it("trigger view to disable reset button", () {
          verify(view.setResetButton(isEnabled: true)).called(1);
        });
      });
    });

    describe("its resetButtonDidTap emits", () {
      beforeEach(() {
        presenter.resetButtonDidTap.add("email");
      });

      it("triggers view to show progress HUD", () {
        verify(view.showProgressHUD()).called(1);
      });

      it("triggers interactor to reset password", () {
        verify(interactor.resetPassword(email: anyNamed("email"))).called(1);
      });
    });

    describe("its passwordDidReset emits", () {
      beforeEach(() {
        presenter.passwordDidReset.add(null);
      });

      it("triggers view to dismiss progress HUD, clear email text field and show reset successfully notification",
          () {
        verify(view.dismissProgressHUD()).called(1);
        verify(view.clearEmailTextField()).called(1);
        verify(view.showResetSuccessfullyNotification()).called(1);
      });
    });

    describe("its passwordDidFailToReset emits", () {
      final exception = Exception();
      beforeEach(() {
        presenter.passwordDidFailToReset.add(exception);
      });

      it("triggers view to show alert dialog", () {
        verify(view.alert(exception)).called(1);
      });
    });
  });
}
