part of 'survey_questions_module.dart';

abstract class SurveyQuestionsInteractorDelegate {
  BehaviorSubject<void> get submitDidSuccess;

  BehaviorSubject<Exception> get submitDidFail;
}

abstract class SurveyQuestionsInteractor extends ArgumentsInteractor<
    SurveyQuestionsInteractorDelegate, SurveyQuestionsArguments> {
  final SurveyRepository _surveyRepository = locator.get();

  List<SurveyQuestionInfo> get questions;

  SurveyQuestionInfo get outro;

  void submit(List<SurveySubmitQuestionInfo> questions);
}

class SurveyQuestionsInteractorImpl extends SurveyQuestionsInteractor {
  @override
  List<SurveyQuestionInfo> get questions => arguments!.survey.orderedQuestions
      .where((element) =>
          element.displayType != SurveyQuestionDisplayType.intro &&
          element.displayType != SurveyQuestionDisplayType.outro)
      .toList();

  @override
  SurveyQuestionInfo get outro => arguments!.survey.questions.firstWhere(
      (element) => element.displayType == SurveyQuestionDisplayType.outro);

  @override
  void submit(List<SurveySubmitQuestionInfo> questions) {
    _surveyRepository
        .submit(surveyId: arguments!.survey.id!, questions: questions)
        .then((value) => delegate?.submitDidSuccess.add(null))
        .onError((Exception exception, stackTrace) =>
            delegate?.submitDidFail.add(exception));
  }
}
