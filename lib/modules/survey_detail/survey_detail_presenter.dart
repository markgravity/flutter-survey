part of 'survey_detail_module.dart';

abstract class SurveyDetailPresenter extends Presenter<SurveyDetailView,
    SurveyDetailInteractor, SurveyDetailRouter> {}

class SurveyDetailPresenterImpl extends SurveyDetailPresenter
    implements SurveyDetailViewDelegate, SurveyDetailInteractorDelegate {
  SurveyDetailPresenterImpl() {
    stateDidInit.voidListen(_stateDidInit).addTo(disposeBag);
    startSurveyButtonDidTap
        .voidListen(_startSurveyButtonDidTap)
        .addTo(disposeBag);

    detailedSurveyDidFetch.listen(_detailedSurveyDidFetch).addTo(disposeBag);
    detailedSurveyDidFailToFetch
        .listen(_detailedSurveyDidFailToFetch)
        .addTo(disposeBag);
  }

  @override
  final detailedSurveyDidFailToFetch = BehaviorSubject<Exception>();

  @override
  final detailedSurveyDidFetch = BehaviorSubject<DetailedSurveyInfo>();

  @override
  final alertDialogDidClose = BehaviorSubject<void>();

  @override
  final stateDidInit = BehaviorSubject<void>();

  @override
  final startSurveyButtonDidTap = BehaviorSubject<void>();

  void _stateDidInit() {
    view.setSurvey(interactor.survey);
  }

  void _startSurveyButtonDidTap() {
    view.showProgressHUD();
    interactor.fetchDetailedSurvey();
  }

  void _detailedSurveyDidFetch(DetailedSurveyInfo survey) {
    view.dismissProgressHUD();
    router.pushToSurveyQuestionsScreen(view.context, survey: survey);
  }

  void _detailedSurveyDidFailToFetch(Exception exception) {
    view.dismissProgressHUD();
    view.alert(exception);
  }
}
