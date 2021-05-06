part of 'forgot_password_module.dart';

abstract class ForgotPasswordPresenter extends Presenter<ForgotPasswordView,
    ForgotPasswordInteractor, ForgotPasswordRouter> {}

class ForgotPasswordPresenterImpl extends ForgotPasswordPresenter
    implements ForgotPasswordViewDelegate, ForgotPasswordInteractorDelegate {
  @override
  final emailTextFieldDidChange = BehaviorSubject<String>();

  @override
  final resetButtonDidTap = BehaviorSubject<String>();

  @override
  final alertDialogDidClose = BehaviorSubject<void>();
}
