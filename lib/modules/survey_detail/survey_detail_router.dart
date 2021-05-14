part of 'survey_detail_module.dart';

abstract class SurveyDetailRouter extends Router {
  void pushToSurveyQuestionsScreen(BuildContext context,
      {required DetailedSurveyInfo survey});
}

class SurveyDetailRouterImpl extends SurveyDetailRouter {
  @override
  void pushToSurveyQuestionsScreen(BuildContext context,
      {required DetailedSurveyInfo survey}) {}
}
