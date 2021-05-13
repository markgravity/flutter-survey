part of 'survey_questions_module.dart';

abstract class SurveyQuestionsPresenter extends Presenter<SurveyQuestionsView,
    SurveyQuestionsInteractor, SurveyQuestionsRouter> {}

class SurveyQuestionsPresenterImpl extends SurveyQuestionsPresenter
    implements SurveyQuestionsViewDelegate, SurveyQuestionsInteractorDelegate {
  SurveyQuestionsPresenterImpl() {
    stateDidInit.voidListen(_stateDidInit).addTo(disposeBag);
    closeButtonDidTap.voidListen(_closeButtonDidTap).addTo(disposeBag);
  }

  @override
  final stateDidInit = BehaviorSubject<void>();

  @override
  final closeConfirmDialogDidClose = BehaviorSubject<OkCancelResult>();

  @override
  final closeButtonDidTap = BehaviorSubject<void>();

  void _stateDidInit() {
    view.setQuestions(interactor.questions);
  }

  void _closeButtonDidTap() {
    view.showCloseConfirmDialog();
  }
}
