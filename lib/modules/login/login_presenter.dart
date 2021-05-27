part of 'login_module.dart';

abstract class LoginPresenter
    extends Presenter<LoginView, LoginInteractor, LoginRouter> {}

class LoginPresenterImpl extends LoginPresenter
    implements LoginViewDelegate, LoginInteractorDelegate {
  LoginPresenterImpl() {
    stateDidInit.voidListen(_didInitState).addTo(disposeBag);
    forgotButtonDidTap.voidListen(_didTapForgotButton).addTo(disposeBag);
    loginButtonDidTap.listen(_didTapLoginButton).addTo(disposeBag);
    [emailTextFieldDidChange, passwordTextFieldDidChange]
        .combineLatest()
        .listen(_didChangeEmailOrPasswordText)
        .addTo(disposeBag);

    didLogin.voidListen(_didLogin).addTo(disposeBag);
    didFailToLogin.listen(_didFailToLogin).addTo(disposeBag);
  }

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

  @override
  final didLogin = BehaviorSubject<void>();

  @override
  final didFailToLogin = BehaviorSubject<Exception>();

  void _didInitState() {
    view.setLoginButton(isEnabled: false);
    view.beginAnimation();
  }

  void _didTapForgotButton() {
    router.pushToForgotPasswordScreen(view.context);
  }

  void _didTapLoginButton(List<String> emailAndPassword) {
    final email = emailAndPassword[0];
    final password = emailAndPassword[1];

    view.showProgressHUD();
    interactor.login(email, password);
  }

  void _didChangeEmailOrPasswordText(List<String> emailAndPassword) {
    final email = emailAndPassword[0];
    final password = emailAndPassword[1];
    final isEnabled = email.isNotEmpty && password.isNotEmpty;
    view.setLoginButton(isEnabled: isEnabled);
  }

  void _didLogin() {
    router.replaceToHomeScreen(view.context);
  }

  void _didFailToLogin(Exception exception) {
    view.dismissProgressHUD();
    view.alert(exception);
  }
}
