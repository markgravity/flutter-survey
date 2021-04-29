import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quick_test/quick_test.dart';
import 'package:survey/modules/login/login_module.dart';
import 'package:survey/services/auth/auth_service.dart';
import 'package:survey/services/locator/locator_service.dart';

import '../../helpers/behavior_subject_generator.dart';
import 'login_interactor_test.mocks.dart';

@GenerateMocks([AuthService, LoginInteractorDelegate])
void main() {
  describe("a Login interactor", () {
    late MockAuthService authService;
    late LoginInteractor interactor;
    late MockLoginInteractorDelegate delegate;
    late BehaviorSubjectGenerator generator;

    beforeEach(() {
      authService = MockAuthService();
      locator.registerFactory<AuthService>(() => authService);

      delegate = MockLoginInteractorDelegate();
      generator = BehaviorSubjectGenerator();
      when(delegate.didLogin).thenAnswer((realInvocation) => generator.make(1));
      when(delegate.didFailToLogin)
          .thenAnswer((realInvocation) => generator.make(2));

      interactor = LoginInteractorImpl();
      interactor.delegate = delegate;
    });

    describe("it's login() is called", () {
      context("when success", () {
        beforeEach(() {
          when(authService.login(params: anyNamed("params")))
              .thenAnswer((realInvocation) => Future.value(null));
          interactor.login("email", "password");
        });

        it("triggers delegate's didLogin emits", () {
          expect(delegate.didLogin, emits(null));
        });
      });

      context("when failure", () {
        final error = Exception();
        beforeEach(() {
          when(authService.login(params: anyNamed("params")))
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
