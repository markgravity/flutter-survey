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
import 'package:tuple/tuple.dart';
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
      when(delegate.authenticatedUserDidGet)
          .thenAnswer((realInvocation) => generator.make(1));
      when(delegate.surveysDidFetchFromCached)
          .thenAnswer((realInvocation) => generator.make(2));
      when(delegate.surveysDidFailToFetchFromCached)
          .thenAnswer((realInvocation) => generator.make(3));
      when(delegate.surveysDidFetchFromRemote)
          .thenAnswer((realInvocation) => generator.make(4));
      when(delegate.surveysDidFailToFetchFromRemote)
          .thenAnswer((realInvocation) => generator.make(5));

      surveyRepository = MockSurveyRepository();
      locator.registerSingleton<SurveyRepository>(surveyRepository);

      authRepository = MockAuthRepository();
      locator.registerSingleton<AuthRepository>(authRepository);

      interactor = HomeInteractorImpl();
      interactor.delegate = delegate;
    });

    describe("its getAuthenticatedUser is called", () {
      final user = UserInfo();
      beforeEach(() {
        when(authRepository.user).thenReturn(user);
        interactor.getAuthenticatedUser();
      });

      it("triggers delegate's authenticatedUserDidGet to emit", () {
        expect(delegate.authenticatedUserDidGet, emits(user));
      });
    });

    describe("its fetchSurveysFromCached is called", () {
      context(
          "when surveyRepository's fetchSurveysFromCached to return success",
          () {
        final surveys = List<SurveyInfo>.empty();
        beforeEach(() {
          when(surveyRepository.fetchSurveysFromCached())
              .thenAnswer((realInvocation) => Future.value(surveys));
          interactor.fetchSurveysFromCached();
        });

        it("triggers delegate's surveysDidFetchFromCached to emit", () {
          expect(delegate.surveysDidFetchFromCached, emits(surveys));
        });
      });

      context(
          "when surveyRepository's fetchSurveysFromCached to return failure",
          () {
        final exception = Exception();
        beforeEach(() {
          when(surveyRepository.fetchSurveysFromCached())
              .thenAnswer((realInvocation) => Future.error(exception));
          interactor.fetchSurveysFromCached();
        });

        it("triggers delegate's surveysDidFailToFetchFromCached to emit", () {
          expect(delegate.surveysDidFailToFetchFromCached, emits(exception));
        });
      });
    });

    describe("its fetchSurveysFromRemote is called", () {
      context(
          "when surveyRepository's fetchSurveysFromRemote to return success",
          () {
        context(
            "when surveyRepository's surveysDidFailToFetchFromCached to return outdated data",
            () {
          final cachedSurveys = [
            SurveyInfo()..description = "cached description"
          ];

          final remoteSurveys = [SurveyInfo()..description = "description"];

          beforeEach(() {
            when(surveyRepository.fetchSurveysFromCached())
                .thenAnswer((realInvocation) => Future.value(cachedSurveys));

            when(surveyRepository.fetchSurveysFromRemote())
                .thenAnswer((realInvocation) => Future.value(remoteSurveys));
            interactor.fetchSurveysFromRemote();
          });

          it("triggers delegate's surveysDidFetchFromRemote to emit", () {
            expect(delegate.surveysDidFetchFromRemote,
                emits(Tuple2(remoteSurveys, true)));
          });
        });

        context(
            "when surveyRepository's surveysDidFailToFetchFromCached to return the same data",
            () {
          final cachedSurveys = [SurveyInfo()..description = "description"];

          final remoteSurveys = cachedSurveys;

          beforeEach(() {
            when(surveyRepository.fetchSurveysFromCached())
                .thenAnswer((realInvocation) => Future.value(cachedSurveys));

            when(surveyRepository.fetchSurveysFromRemote())
                .thenAnswer((realInvocation) => Future.value(remoteSurveys));
            interactor.fetchSurveysFromRemote();
          });

          it("triggers delegate's surveysDidFetchFromRemote to emit", () {
            expect(delegate.surveysDidFetchFromRemote,
                emits(Tuple2(remoteSurveys, false)));
          });
        });
      });

      context(
          "when surveyRepository's fetchSurveysFromRemote to return failure",
          () {
        final exception = Exception();
        beforeEach(() {
          when(surveyRepository.fetchSurveysFromCached())
              .thenAnswer((realInvocation) => Future.value([]));

          when(surveyRepository.fetchSurveysFromRemote())
              .thenAnswer((realInvocation) => Future.error(exception));
          interactor.fetchSurveysFromRemote();
        });

        it("triggers delegate's surveysDidFailToFetchFromRemote to emit", () {
          expect(delegate.surveysDidFailToFetchFromRemote, emits(exception));
        });
      });
    });
  });
}
