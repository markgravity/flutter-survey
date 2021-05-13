part of 'survey_questions_module.dart';

abstract class SurveyQuestionsInteractorDelegate {}

abstract class SurveyQuestionsInteractor extends ArgumentsInteractor<
    SurveyQuestionsInteractorDelegate, SurveyQuestionsArguments> {
  List<SurveyQuestionInfo> get questions;
}

class SurveyQuestionsInteractorImpl extends SurveyQuestionsInteractor {
  @override
  List<SurveyQuestionInfo> get questions => arguments!.survey.orderedQuestions
      .where((element) =>
          element.displayType != SurveyQuestionDisplayType.intro &&
          element.displayType != SurveyQuestionDisplayType.outro)
      .toList();
}
