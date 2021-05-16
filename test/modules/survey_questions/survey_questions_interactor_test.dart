import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quick_test/quick_test.dart';
import 'package:survey/models/detailed_survey_info.dart';
import 'package:survey/models/survey_question_info.dart';
import 'package:survey/models/survey_submit_question_info.dart';
import 'package:survey/modules/survey_questions/survey_questions_module.dart';
import 'package:survey/repositories/survey_repository.dart';
import 'package:survey/services/locator/locator_service.dart';
import '../../helpers/behavior_subject_generator.dart';
import 'survey_questions_interactor_test.mocks.dart';

@GenerateMocks([SurveyQuestionsInteractorDelegate, SurveyRepository])
void main() {
  describe("a SurveyQuestions interactor", () {
    late SurveyQuestionsInteractor interactor;
    late MockSurveyQuestionsInteractorDelegate delegate;
    late BehaviorSubjectGenerator generator;
    late MockSurveyRepository surveyRepository;

    final outro = SurveyQuestionInfo();
    outro.displayOrder = 1;
    outro.displayType = SurveyQuestionDisplayType.outro;

    final question1 = SurveyQuestionInfo();
    question1.displayOrder = 0;
    question1.displayType = SurveyQuestionDisplayType.choice;

    final question2 = SurveyQuestionInfo();
    question2.displayOrder = 2;
    question2.displayType = SurveyQuestionDisplayType.textarea;

    final detailedSurvey = DetailedSurveyInfo();
    detailedSurvey.id = "id";
    detailedSurvey.questions = [question2, question1, outro];

    beforeEach(() {
      generator = BehaviorSubjectGenerator();

      delegate = MockSurveyQuestionsInteractorDelegate();
      when(delegate.submitDidSuccess)
          .thenAnswer((realInvocation) => generator.make(0));
      when(delegate.submitDidFail)
          .thenAnswer((realInvocation) => generator.make(1));

      surveyRepository = MockSurveyRepository();
      locator.registerSingleton<SurveyRepository>(surveyRepository);

      interactor = SurveyQuestionsInteractorImpl();
      interactor.delegate = delegate;
      interactor.arguments = SurveyQuestionsArguments(survey: detailedSurvey);
    });

    it("returns correct outro", () {
      expect(interactor.outro, outro);
    });

    it("returns correct questions", () {
      expect(interactor.questions, [question1, question2]);
    });

    describe("it's submit() is called", () {
      final List<SurveySubmitQuestionInfo> submitQuestions = [
        const SurveySubmitQuestionInfo(questionId: "questionId", answers: []),
      ];

      context("when survey repository's submit() returns success", () {
        beforeEach(() {
          when(surveyRepository.submit(
                  surveyId: detailedSurvey.id, questions: submitQuestions))
              .thenAnswer((realInvocation) => Future.value(null));
          interactor.submit(submitQuestions);
        });

        it("trigger delegate's submitDidSuccess emits", () {
          expect(delegate.submitDidSuccess, emits(null));
        });
      });

      context("when survey repository's submit() returns failure", () {
        final exception = Exception();

        beforeEach(() {
          when(surveyRepository.submit(
                  surveyId: detailedSurvey.id, questions: submitQuestions))
              .thenAnswer((realInvocation) => Future.error(exception));
          interactor.submit(submitQuestions);
        });

        it("trigger delegate's submitDidFail", () {
          expect(delegate.submitDidFail, emits(exception));
        });
      });
    });
  });
}
