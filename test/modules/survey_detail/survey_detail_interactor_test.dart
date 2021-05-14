import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quick_test/quick_test.dart';
import 'package:survey/models/detailed_survey_info.dart';
import 'package:survey/models/survey_info.dart';
import 'package:survey/modules/survey_detail/survey_detail_module.dart';
import 'package:survey/repositories/survey_repository.dart';
import 'package:survey/services/locator/locator_service.dart';
import '../../helpers/behavior_subject_generator.dart';
import 'survey_detail_interactor_test.mocks.dart';

@GenerateMocks([SurveyDetailInteractorDelegate, SurveyRepository])
void main() {
  describe("a SurveyDetail interactor", () {
    late SurveyDetailInteractor interactor;
    late MockSurveyDetailInteractorDelegate delegate;
    late BehaviorSubjectGenerator generator;
    late MockSurveyRepository surveyRepository;

    final survey = SurveyInfo();
    survey.id = "id";

    beforeEach(() {
      generator = BehaviorSubjectGenerator();

      surveyRepository = MockSurveyRepository();
      locator.registerSingleton<SurveyRepository>(surveyRepository);

      delegate = MockSurveyDetailInteractorDelegate();
      when(delegate.detailedSurveyDidFetch)
          .thenAnswer((realInvocation) => generator.make(0));
      when(delegate.detailedSurveyDidFailToFetch)
          .thenAnswer((realInvocation) => generator.make(1));

      interactor = SurveyDetailInteractorImpl();
      interactor.delegate = delegate;
      interactor.arguments = SurveyDetailArguments(survey: survey);
    });

    describe("its survey is got", () {
      it("returns correct survey", () {
        expect(interactor.survey, survey);
      });
    });

    describe("its fetchDetailedSurvey() is called", () {
      context("when survey repository's fetchDetailedSurvey() return success",
          () {
        final detailedSurvey = DetailedSurveyInfo();
        beforeEach(() {
          when(surveyRepository.fetchDetailedSurvey(any))
              .thenAnswer((realInvocation) => Future.value(detailedSurvey));
          interactor.fetchDetailedSurvey();
        });

        it("triggers delegate's detailedSurveyDidFetch to emit", () {
          expect(delegate.detailedSurveyDidFetch, emits(detailedSurvey));
        });
      });

      context("when survey repository's fetchDetailedSurvey() return failure",
          () {
        final exception = Exception();
        beforeEach(() {
          when(surveyRepository.fetchDetailedSurvey(any))
              .thenAnswer((realInvocation) => Future.error(exception));
          interactor.fetchDetailedSurvey();
        });

        it("triggers delegate's detailedSurveyDidFailToFetch to emit", () {
          expect(delegate.detailedSurveyDidFailToFetch, emits(exception));
        });
      });
    });
  });
}
