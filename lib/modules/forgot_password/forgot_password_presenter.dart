part of 'forgot_password_module.dart';

abstract class ForgotPasswordPresenter extends Presenter<ForgotPasswordView,
    ForgotPasswordInteractor, ForgotPasswordRouter> {}

class ForgotPasswordPresenterImpl extends ForgotPasswordPresenter
    implements ForgotPasswordViewDelegate, ForgotPasswordInteractorDelegate {
  ForgotPasswordPresenterImpl() {
    emailTextFieldDidChange.listen(_emailTextFieldDidChange);
    resetButtonDidTap.listen(_resetButtonDidTap);

    passwordDidReset.voidListen(_passwordDidReset);
    passwordDidFailToReset.listen(_passwordDidFailToReset);
  }


  @override
  final emailTextFieldDidChange = BehaviorSubject<String>();

  @override
  final resetButtonDidTap = BehaviorSubject<String>();

  @override
  final alertDialogDidClose = BehaviorSubject<void>();

  @override
  final passwordDidReset = BehaviorSubject<void>();

  @override
  final passwordDidFailToReset = BehaviorSubject<Object>();

  void _emailTextFieldDidChange(String email) {
    view.setResetButton(isEnabled: email.isNotEmpty);
  }

  void _resetButtonDidTap(String email) {
    view.showProgressHUD();
    interactor.resetPassword(email: email);
  }

  void _passwordDidReset() {
    view.dismissProgressHUD();
    view.showResetSuccessfullyNotification();
    view.clearEmailTextField();
  }

  void _passwordDidFailToReset(Object error) {
    view.dismissProgressHUD();
    view.alert(error);
  }
}
