part of 'landing_module.dart';

abstract class LandingInteractor extends Interactor<LandingInteractorDelegate> {
  void validateAuthentication();
  void logout();
}

abstract class LandingInteractorDelegate {
  BehaviorSubject<bool> get authenticationDidValidate;

  BehaviorSubject<Exception> get authenticationDidFailToValidate;
}

class LandingInteractorImpl extends LandingInteractor {
  final AuthRepository _authRepository = locator.get();

  @override
  void validateAuthentication() {
    _authRepository.attemptAndFetchUser().then((_) {
      delegate?.authenticationDidValidate.add(_authRepository.isAuthenticated);
    }).onError<Exception>((exception, _) {
      delegate?.authenticationDidFailToValidate.add(exception);
    });
  }

  @override
  void logout() {
    _authRepository.logout().then((value) => null);
  }
}
