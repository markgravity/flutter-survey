part of 'forgot_password_module.dart';

abstract class ForgotPasswordInteractor
    extends Interactor<ForgotPasswordInteractorDelegate> {
  void resetPassword({required String email});
}

abstract class ForgotPasswordInteractorDelegate {
  BehaviorSubject<void> get passwordDidReset;

  BehaviorSubject<Object> get passwordDidFailToReset;
}

class ForgotPasswordInteractorImpl extends ForgotPasswordInteractor {
  final AuthService _authService = locator.get();

  @override
  void resetPassword({required String email}) {
    Future.microtask(() async {
      final params = AuthResetPasswordParams(email: email);

      try {
        await _authService.resetPassword(params: params);
        delegate?.passwordDidReset.add(null);
      } on Exception catch (e) {
        delegate?.passwordDidFailToReset.add(e);
      }
    });
  }
}
