part of 'survey_questions_module.dart';

abstract class SurveyQuestionsPresenter extends Presenter<SurveyQuestionsView,
    SurveyQuestionsInteractor, SurveyQuestionsRouter> {}

class SurveyQuestionsPresenterImpl extends SurveyQuestionsPresenter
    implements SurveyQuestionsViewDelegate, SurveyQuestionsInteractorDelegate {
  SurveyQuestionsPresenterImpl() {
    stateDidInit.voidListen(_stateDidInit).addTo(disposeBag);
    closeButtonDidTap.voidListen(_closeButtonDidTap).addTo(disposeBag);
    submitButtonDidTap.listen(_submitButtonDidTap).addTo(disposeBag);
    closeConfirmDialogDidClose
        .listen(_closeConfirmDialogDidClose)
        .addTo(disposeBag);

    submitDidFail.listen(_submitDidFail).addTo(disposeBag);
    submitDidSuccess.voidListen(_submitDidSuccess).addTo(disposeBag);
  }

  int _currentPage = 0;
  SurveyQuestionInfo get _currentQuestion => interactor.questions[_currentPage];

  final _submitQuestions = List<SurveySubmitQuestionInfo>.empty(growable: true);

  @override
  final stateDidInit = BehaviorSubject<void>();

  @override
  final closeConfirmDialogDidClose = BehaviorSubject<OkCancelResult>();

  @override
  final closeButtonDidTap = BehaviorSubject<void>();

  @override
  final submitButtonDidTap = BehaviorSubject<List<SurveySubmitAnswerInfo>>();

  @override
  final alertDialogDidClose = BehaviorSubject<void>();

  @override
  final submitDidFail = BehaviorSubject<Exception>();

  @override
  final submitDidSuccess = BehaviorSubject<void>();

  void _stateDidInit() {
    view.setQuestions(interactor.questions);
  }

  void _closeButtonDidTap() {
    view.showCloseConfirmDialog();
  }

  void _submitButtonDidTap(List<SurveySubmitAnswerInfo> answers) {
    _submitQuestions.add(
      SurveySubmitQuestionInfo(
          questionId: _currentQuestion.id!, answers: answers),
    );

    // Last question
    if (_currentPage >= interactor.questions.length - 1) {
      view.showProgressHUD();
      interactor.submit(_submitQuestions);
      return;
    }
    _currentPage++;
    view.moveTo(_currentPage);
  }

  void _closeConfirmDialogDidClose(OkCancelResult result) {
    if (result != OkCancelResult.ok) return;
    router.popBack(view.context);
  }

  void _submitDidSuccess() {
    view.dismissProgressHUD();
    router.pushToSurveyCompletedScreen(view.context, outro: interactor.outro);
  }

  void _submitDidFail(Exception exception) {
    view.dismissProgressHUD();
    view.alert(exception);
  }
}
