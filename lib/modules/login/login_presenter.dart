part of 'login_module.dart';

abstract class LoginPresenter
    extends Presenter<LoginView, LoginInteractor, LoginRouter> {}

class LoginPresenterImpl extends LoginPresenter
    implements LoginViewDelegate, LoginInteractorDelegate {
  LoginPresenterImpl() {
    stateDidInit.voidListen(_didInitState);
    forgotButtonDidTap.voidListen(_didTapForgotButton);
    loginButtonDidTap.listen(_didTapLoginButton);
    [emailTextFieldDidChange, passwordTextFieldDidChange]
        .combineLatest()
        .listen(_didChangeEmailOrPasswordText);

    didLogin.voidListen(_didLogin);
    didFailToLogin.listen(_didFailToLogin);
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

  void _didTapLoginButton(List<String> data) {
    view.showProgressHUD();
    interactor.login(data[0], data[1]);
  }

  void _didChangeEmailOrPasswordText(List<String> data) {
    final isEnabled = data[0].isNotEmpty && data[1].isNotEmpty;
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
