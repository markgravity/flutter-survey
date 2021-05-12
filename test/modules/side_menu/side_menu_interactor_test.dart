import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quick_test/quick_test.dart';
import 'package:survey/modules/side_menu/side_menu_module.dart';
import 'package:survey/repositories/auth_repository.dart';
import 'package:survey/repositories/survey_repository.dart';
import 'package:survey/services/locator/locator_service.dart';
import '../../helpers/behavior_subject_generator.dart';
import 'side_menu_interactor_test.mocks.dart';

@GenerateMocks([SideMenuInteractorDelegate, SurveyRepository, AuthRepository])
void main() {
  describe("a SideMenu interactor", () {
    late SideMenuInteractor interactor;
    late MockSideMenuInteractorDelegate delegate;
    late MockAuthRepository authRepository;
    late BehaviorSubjectGenerator generator;

    beforeEach(() {
      generator = BehaviorSubjectGenerator();

      delegate = MockSideMenuInteractorDelegate();
      when(delegate.logoutDidSuccess)
          .thenAnswer((realInvocation) => generator.make(0));

      authRepository = MockAuthRepository();
      locator.registerSingleton<AuthRepository>(authRepository);

      interactor = SideMenuInteractorImpl();
      interactor.delegate = delegate;
    });

    describe("it's logout() is called", () {
      context("when auth repository's logout() return success", () {
        beforeEach(() {
          when(authRepository.logout())
              .thenAnswer((realInvocation) => Future.value(null));
          interactor.logout();
        });

        it("triggers delegate's logoutDidSuccess emits", () {
          expect(delegate.logoutDidSuccess, emits(null));
        });
      });

      context("when auth repository's logout() return failure", () {
        beforeEach(() {
          when(authRepository.logout())
              .thenAnswer((realInvocation) => Future.error(Exception()));
          interactor.logout();
        });

        it("triggers delegate's logoutDidSuccess emits", () {
          expect(delegate.logoutDidSuccess, emits(null));
        });
      });
    });
  });
}
