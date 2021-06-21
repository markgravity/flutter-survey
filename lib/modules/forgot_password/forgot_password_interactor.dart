part of 'forgot_password_module.dart';

abstract class ForgotPasswordInteractor
    extends Interactor<ForgotPasswordInteractorDelegate> {
  void resetPassword({required String email});
}

abstract class ForgotPasswordInteractorDelegate {
  BehaviorSubject<void> get passwordDidReset;

  BehaviorSubject<Exception> get passwordDidFailToReset;
}

class ForgotPasswordInteractorImpl extends ForgotPasswordInteractor {
  final AuthRepository _authRepository = locator.get();

  @override
  void resetPassword({required String email}) {
    _authRepository
        .resetPassword(email: email)
        .then((value) => delegate?.passwordDidReset.add(null))
        .onError<Exception>(
            (error, stackTrace) => delegate?.passwordDidFailToReset.add(error));
  }
}
