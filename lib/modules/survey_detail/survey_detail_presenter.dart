part of 'survey_detail_module.dart';

abstract class SurveyDetailPresenter extends Presenter<SurveyDetailView,
    SurveyDetailInteractor, SurveyDetailRouter> {}

class SurveyDetailPresenterImpl extends SurveyDetailPresenter
    implements SurveyDetailViewDelegate, SurveyDetailInteractorDelegate {}
