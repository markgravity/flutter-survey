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
    context.navigator.pushReplacement(
      PageRouteBuilder(
        settings: RouteSettings(
          name: SurveyCompletedModule.routePath,
          arguments: SurveyCompletedArguments(outro: outro),
        ),
        pageBuilder: (context, _, __) =>
            Configs.routes[SurveyCompletedModule.routePath]!(context),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
    );
  }

  @override
  void popBack(BuildContext context) {
    context.navigator.pop();
  }
}
