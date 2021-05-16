part of 'survey_completed_module.dart';

abstract class SurveyCompletedPresenter extends Presenter<SurveyCompletedView,
    SurveyCompletedInteractor, SurveyCompletedRouter> {}

class SurveyCompletedPresenterImpl extends SurveyCompletedPresenter
    implements SurveyCompletedViewDelegate, SurveyCompletedInteractorDelegate {}
