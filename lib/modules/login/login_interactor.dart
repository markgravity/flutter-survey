part of 'login_module.dart';

abstract class LoginInteractor extends Interactor<LoginInteractorDelegate> {
  void login(String email, String password);
}

abstract class LoginInteractorDelegate {
  BehaviorSubject<void> get didLogin;

  BehaviorSubject<Exception> get didFailToLogin;
}

class LoginInteractorImpl extends LoginInteractor {
  final AuthRepository _authRepository = locator.get();

  @override
  void login(String email, String password) {
    Future.microtask(() async {
      try {
        await _authRepository.login(email: email, password: password);
        delegate?.didLogin.add(null);
      } on Exception catch (e) {
        delegate?.didFailToLogin.add(e);
      }
    });
  }
}
