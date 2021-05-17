import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quick_test/quick_test.dart';
import 'package:survey/models/survey_question_info.dart';
import 'package:survey/modules/survey_completed/survey_completed_module.dart';
import 'package:survey/services/locator/locator_service.dart';
import '../../helpers/behavior_subject_generator.dart';
import 'survey_completed_interactor_test.mocks.dart';

@GenerateMocks([SurveyCompletedInteractorDelegate])
void main() {
  describe("a SurveyCompleted interactor", () {
    late SurveyCompletedInteractor interactor;
    late MockSurveyCompletedInteractorDelegate delegate;
    late BehaviorSubjectGenerator generator;
    final outro = SurveyQuestionInfo();
    beforeEach(() {
      generator = BehaviorSubjectGenerator();

      delegate = MockSurveyCompletedInteractorDelegate();

      interactor = SurveyCompletedInteractorImpl();
      interactor.arguments = SurveyCompletedArguments(outro: outro);
      interactor.delegate = delegate;
    });

    it("returns correct outro", () {
      expect(interactor.outro, outro);
    });
  });
}
