part of 'survey_completed_module.dart';

abstract class SurveyCompletedRouter extends Router {
  void popBack(BuildContext context);
}

class SurveyCompletedRouterImpl extends SurveyCompletedRouter {
  @override
  void popBack(BuildContext context) {
    context.navigator.pop();
  }
}
