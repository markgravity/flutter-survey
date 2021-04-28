part of 'landing_module.dart';

abstract class LandingInteractor extends Interactor<LandingInteractorDelegate> {
  void validateAuthentication();
}

abstract class LandingInteractorDelegate {
  BehaviorSubject<bool> get authenticationDidValidate;

  BehaviorSubject<Object> get authenticationDidFailToValidate;
}

class LandingInteractorImpl extends LandingInteractor {
  final AuthService _authService = locator.get();

  @override
  void validateAuthentication() {
    _authService.attemptAndFetchUser().then((_) {
      delegate?.authenticationDidValidate.add(_authService.isAuthenticated);
    }).catchError((Object error) {
      delegate?.authenticationDidFailToValidate.add(error);
    });
  }
}
