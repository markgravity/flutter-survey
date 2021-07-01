part of 'home_module.dart';

abstract class HomeRouter extends Router {
  void pushToSurveyDetail(
      {required BuildContext context, required SurveyInfo survey});
}

class HomeRouterImpl extends HomeRouter {
  @override
  void pushToSurveyDetail(
      {required BuildContext context, required SurveyInfo survey}) {
    context.navigator.pushNamed(SurveyDetailModule.routePath);
  }
}
