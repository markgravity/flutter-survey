import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quick_test/quick_test.dart';
import 'package:survey/models/survey_info.dart';
import 'package:survey/models/user_info.dart';
import 'package:survey/modules/home/home_module.dart';
import 'package:survey/repositories/auth_repository.dart';
import 'package:survey/repositories/survey_repository.dart';
import 'package:survey/services/locator/locator_service.dart';
import '../../helpers/behavior_subject_generator.dart';
import 'home_interactor_test.mocks.dart';

@GenerateMocks([HomeInteractorDelegate, SurveyRepository, AuthRepository])
void main() {
  describe("a Home interactor", () {
    late HomeInteractor interactor;
    late MockHomeInteractorDelegate delegate;
    late MockSurveyRepository surveyRepository;
    late MockAuthRepository authRepository;
    late BehaviorSubjectGenerator generator;

    beforeEach(() {
      generator = BehaviorSubjectGenerator();

      delegate = MockHomeInteractorDelegate();
      when(delegate.isSurveysCachedDidGet)
          .thenAnswer((realInvocation) => generator.make(0));
      when(delegate.authenticatedUserDidGet)
          .thenAnswer((realInvocation) => generator.make(1));
      when(delegate.surveysDidFetch)
          .thenAnswer((realInvocation) => generator.make(2));
      when(delegate.surveysDidFailToFetch)
          .thenAnswer((realInvocation) => generator.make(3));

      surveyRepository = MockSurveyRepository();
      locator.registerSingleton<SurveyRepository>(surveyRepository);

      authRepository = MockAuthRepository();
      locator.registerSingleton<AuthRepository>(authRepository);

      interactor = HomeInteractorImpl();
      interactor.delegate = delegate;
    });

    describe("it's getIsSurveysCached is called", () {
      beforeEach(() {
        when(surveyRepository.isSurveysCached)
            .thenAnswer((realInvocation) => Future.value(true));
        interactor.getIsSurveysCached();
      });

      it("triggers delegate's isSurveysCachedDidGet emits", () {
        expect(delegate.isSurveysCachedDidGet, emits(true));
      });
    });

    describe("it's getAuthenticatedUser is called", () {
      final user = UserInfo();
      beforeEach(() {
        when(authRepository.user).thenReturn(user);
        interactor.getAuthenticatedUser();
      });

      it("triggers delegate's authenticatedUserDidGet emits", () {
        expect(delegate.authenticatedUserDidGet, emits(user));
      });
    });

    describe("it's fetchSurveys is called", () {
      context("when surveyRepository's fetchSurveys return success", () {
        final surveys = List<SurveyInfo>.empty();
        beforeEach(() {
          when(surveyRepository.fetchSurveys(force: anyNamed("force")))
              .thenAnswer((realInvocation) => Future.value(surveys));
          interactor.fetchSurveys();
        });

        it("triggers delegate's surveysDidFetch emits", () {
          expect(delegate.surveysDidFetch, emits(surveys));
        });
      });

      context("when surveyRepository's fetchSurveys return failure", () {
        final exception = Exception();
        beforeEach(() {
          when(surveyRepository.fetchSurveys(force: anyNamed("force")))
              .thenAnswer((realInvocation) => Future.error(exception));
          interactor.fetchSurveys();
        });

        it("triggers delegate's surveysDidFailToFetch emits", () {
          expect(delegate.surveysDidFailToFetch, emits(exception));
        });
      });
    });
  });
}
