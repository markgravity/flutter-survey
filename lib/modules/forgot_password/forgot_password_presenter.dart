part of 'forgot_password_module.dart';

abstract class ForgotPasswordPresenter extends Presenter<ForgotPasswordView,
    ForgotPasswordInteractor, ForgotPasswordRouter> {}

class ForgotPasswordPresenterImpl extends ForgotPasswordPresenter
    implements ForgotPasswordViewDelegate, ForgotPasswordInteractorDelegate {
  ForgotPasswordPresenterImpl() {
    emailTextFieldDidChange.listen(_emailTextFieldDidChange).addTo(disposeBag);
    resetButtonDidTap.listen(_resetButtonDidTap).addTo(disposeBag);

    passwordDidReset.voidListen(_passwordDidReset).addTo(disposeBag);
    passwordDidFailToReset.listen(_passwordDidFailToReset).addTo(disposeBag);
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
  final passwordDidFailToReset = BehaviorSubject<Exception>();

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

  void _passwordDidFailToReset(Exception error) {
    view.dismissProgressHUD();
    view.alert(error);
  }
}
