part of 'login_module.dart';

abstract class LoginInteractor extends Interactor<LoginInteractorDelegate> {
  void login(String email, String password);
}

abstract class LoginInteractorDelegate {
  BehaviorSubject<void> get didLogin;

  BehaviorSubject<Object> get didFailToLogin;
}

class LoginInteractorImpl extends LoginInteractor {
  final AuthService _authService = locator.get();

  @override
  void login(String email, String password) {
    Future.microtask(() async {
      final params = AuthLoginParams(
        email: email,
        password: password,
      );

      try {
        await _authService.login(params: params);
        delegate?.didLogin.add(null);
      } on Exception catch (e) {
        delegate?.didFailToLogin.add(e);
      }
    });
  }
}
