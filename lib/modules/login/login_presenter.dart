part of 'login_module.dart';

abstract class LoginPresenter
    extends Presenter<LoginView, LoginInteractor, LoginRouter> {}

class LoginPresenterImpl extends LoginPresenter
    implements LoginViewDelegate, LoginInteractorDelegate {
  @override
  final emailTextFieldDidChange = BehaviorSubject<String>();

  @override
  final passwordTextFieldDidChange = BehaviorSubject<String>();

  @override
  final stateDidInit = BehaviorSubject<void>();

  @override
  final forgotButtonDidTap = BehaviorSubject<void>();

  @override
  final loginButtonDidTap = BehaviorSubject<List<String>>();

  @override
  final alertDialogDidClose = BehaviorSubject<void>();
}
