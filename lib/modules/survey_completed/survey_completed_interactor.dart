part of 'survey_completed_module.dart';

abstract class SurveyCompletedInteractorDelegate {}

abstract class SurveyCompletedInteractor extends ArgumentsInteractor<
    SurveyCompletedInteractorDelegate, SurveyCompletedArguments> {
  SurveyQuestionInfo get outro;
}

class SurveyCompletedInteractorImpl extends SurveyCompletedInteractor {
  @override
  SurveyQuestionInfo get outro => arguments!.outro;
}
