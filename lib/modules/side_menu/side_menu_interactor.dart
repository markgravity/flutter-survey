part of 'side_menu_module.dart';

abstract class SideMenuInteractorDelegate {
  BehaviorSubject<void> get logoutDidSuccess;
}

abstract class SideMenuInteractor
    extends Interactor<SideMenuInteractorDelegate> {
  UserInfo get authenticatedUser;
  void logout();
}

class SideMenuInteractorImpl extends SideMenuInteractor {
  final AuthRepository _authRepository = locator.get();

  @override
  UserInfo get authenticatedUser => _authRepository.user!;

  @override
  void logout() {
    _authRepository
        .logout()
        .then((value) => delegate?.logoutDidSuccess.add(null))
        .onError<Exception>(
            (error, stackTrace) => delegate?.logoutDidSuccess.add(null));
  }
}
