import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quick_test/quick_test.dart';
import 'package:survey/modules/forgot_password/forgot_password_module.dart';
import 'package:survey/repositories/auth_repository.dart';
import 'package:survey/services/locator/locator_service.dart';

import '../../helpers/behavior_subject_generator.dart';
import 'forgot_password_interactor_test.mocks.dart';

@GenerateMocks([AuthRepository, ForgotPasswordInteractorDelegate])
void main() {
  describe("a ForgotPassword interactor", () {
    late ForgotPasswordInteractor interactor;
    late MockAuthRepository authRepository;
    late MockForgotPasswordInteractorDelegate delegate;
    late BehaviorSubjectGenerator generator;

    beforeEach(() {
      generator = BehaviorSubjectGenerator();

      delegate = MockForgotPasswordInteractorDelegate();
      when(delegate.passwordDidFailToReset)
          .thenAnswer((realInvocation) => generator.make(0));
      when(delegate.passwordDidReset)
          .thenAnswer((realInvocation) => generator.make(1));

      authRepository = MockAuthRepository();
      locator.registerFactory<AuthRepository>(() => authRepository);
      interactor = ForgotPasswordInteractorImpl();
      interactor.delegate = delegate;
    });

    describe("its resetPassword is called", () {
      context("when authRepository's resetPassword return success", () {
        beforeEach(() {
          when(authRepository.resetPassword(email: anyNamed("email")))
              .thenAnswer((realInvocation) => Future.value(null));
          interactor.resetPassword(email: "email");
        });

        it("trigger delegate's passwordDidReset emits", () {
          expect(delegate.passwordDidReset, emits(null));
        });
      });

      context("when authRepository's resetPassword return failure", () {
        final exception = Exception();
        beforeEach(() {
          when(authRepository.resetPassword(email: anyNamed("email")))
              .thenAnswer((realInvocation) => Future.error(exception));
          interactor.resetPassword(email: "email");
        });

        it("trigger delegate's passwordDidFailToReset emits", () {
          expect(delegate.passwordDidFailToReset, emits(exception));
        });
      });
    });
  });
}
