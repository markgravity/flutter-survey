part of 'survey_questions_module.dart';

abstract class SurveyQuestionsRouter extends Router {
  void pushToSurveyCompletedScreen(BuildContext context,
      {required SurveyQuestionInfo outro});
  void popBack(BuildContext context);
}

class SurveyQuestionsRouterImpl extends SurveyQuestionsRouter {
  @override
  void pushToSurveyCompletedScreen(BuildContext context,
      {required SurveyQuestionInfo outro}) {
    context.navigator.pushReplacementNamed(
      SurveyCompletedModule.routePath,
      arguments: SurveyCompletedArguments(outro: outro),
    );
  }

  @override
  void popBack(BuildContext context) {
    context.navigator.pop();
  }
}
