import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quick_test/quick_test.dart';
import 'package:survey/modules/login/login_module.dart';
import 'package:survey/repositories/auth_repository.dart';
import 'package:survey/services/locator/locator_service.dart';

import '../../helpers/behavior_subject_generator.dart';
import 'login_interactor_test.mocks.dart';

@GenerateMocks([AuthRepository, LoginInteractorDelegate])
void main() {
  describe("a Login interactor", () {
    late MockAuthRepository authRepository;
    late LoginInteractor interactor;
    late MockLoginInteractorDelegate delegate;
    late BehaviorSubjectGenerator generator;

    beforeEach(() {
      authRepository = MockAuthRepository();
      locator.registerFactory<AuthRepository>(() => authRepository);

      delegate = MockLoginInteractorDelegate();
      generator = BehaviorSubjectGenerator();
      when(delegate.didLogin).thenAnswer((realInvocation) => generator.make(1));
      when(delegate.didFailToLogin)
          .thenAnswer((realInvocation) => generator.make(2));

      interactor = LoginInteractorImpl();
      interactor.delegate = delegate;
    });

    describe("its login() is called", () {
      context("when success", () {
        beforeEach(() {
          when(authRepository.login(
                  email: anyNamed("email"), password: anyNamed("password")))
              .thenAnswer((realInvocation) => Future.value(null));
          interactor.login("email", "password");
        });

        it("triggers delegate's didLogin to emit", () {
          expect(delegate.didLogin, emits(null));
        });
      });

      context("when failure", () {
        final error = Exception();
        beforeEach(() {
          when(authRepository.login(
                  email: anyNamed("email"), password: anyNamed("password")))
              .thenAnswer((realInvocation) => Future.error(error));
          interactor.login("email", "password");
        });

        it("triggers delegate's didFailToLogin emits", () {
          expect(delegate.didFailToLogin, emits(error));
        });
      });
    });
  });
}
