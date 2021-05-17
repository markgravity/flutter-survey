import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quick_test/quick_test.dart';
import 'package:survey/modules/landing/landing_module.dart';
import 'package:survey/repositories/auth_repository.dart';
import 'package:survey/services/locator/locator_service.dart';

import '../../helpers/behavior_subject_generator.dart';
import 'landing_interactor_test.mocks.dart';

@GenerateMocks([AuthRepository, LandingInteractorDelegate])
void main() {
  describe("an Landing interactor", () {
    late LandingInteractor interactor;
    late MockAuthRepository authRepository;
    late MockLandingInteractorDelegate delegate;
    late BehaviorSubjectGenerator generator;

    beforeEach(() {
      generator = BehaviorSubjectGenerator();

      delegate = MockLandingInteractorDelegate();
      when(delegate.authenticationDidValidate)
          .thenAnswer((realInvocation) => generator.make(0));
      when(delegate.authenticationDidFailToValidate)
          .thenAnswer((realInvocation) => generator.make(1));

      authRepository = MockAuthRepository();
      locator.registerFactory<AuthRepository>(() => authRepository);
      interactor = LandingInteractorImpl();
      interactor.delegate = delegate;
    });

    describe("its validateAuthentication() is called", () {
      beforeEach(() {
        when(authRepository.isAuthenticated).thenReturn(true);
      });

      context("when authRepository returns success", () {
        beforeEach(() {
          when(authRepository.attemptAndFetchUser())
              .thenAnswer((realInvocation) => Future.value(null));
          interactor.validateAuthentication();
        });

        it("triggers delegate's didValidateAuthentication emits true", () {
          expect(delegate.authenticationDidValidate, emits(true));
        });
      });

      context("when authRepository returns failure", () {
        final error = Exception();
        beforeEach(() {
          when(authRepository.attemptAndFetchUser())
              .thenAnswer((_) => Future.error(error));
          interactor.validateAuthentication();
        });

        it("triggers delegate's didValidateAuthentication emits error", () {
          expect(delegate.authenticationDidFailToValidate, emits(error));
        });
      });
    });
  });
}
