part of 'survey_questions_module.dart';

abstract class SurveyQuestionsViewDelegate {
  BehaviorSubject<void> get stateDidInit;

  BehaviorSubject<void> get closeButtonDidTap;

  BehaviorSubject<OkCancelResult> get closeConfirmDialogDidClose;
}

abstract class SurveyQuestionsView extends View<SurveyQuestionsViewDelegate> {
  void setQuestions(List<SurveyQuestionInfo> questions);

  void showCloseConfirmDialog();
}

class SurveyQuestionsViewImpl extends StatefulWidget {
  const SurveyQuestionsViewImpl({Key? key}) : super(key: key);

  @override
  _SurveyQuestionsViewImplState createState() =>
      _SurveyQuestionsViewImplState();
}

class _SurveyQuestionsViewImplState extends ViewState<
    SurveyQuestionsViewImpl,
    SurveyQuestionsModule,
    SurveyQuestionsViewDelegate> implements SurveyQuestionsView {
  final _questions = BehaviorSubject<List<SurveyQuestionInfo>>();
  final _navigationBarKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    delegate?.stateDidInit.add(null);
  }

  @override
  Widget build(BuildContext context) {
    return const Content();
  }

  @override
  void setQuestions(List<SurveyQuestionInfo> questions) {
    _questions.add(questions);
  }

  @override
  void showCloseConfirmDialog() {
    confirm(
      context: context,
      title: AppLocalizations.of(context)!
          .surveyQuestionsScreenCloseConfirmDialogTitle,
      message: AppLocalizations.of(context)!
          .surveyQuestionsScreenCloseConfirmDialogMessage,
      okLabel: AppLocalizations.of(context)!
          .surveyQuestionsScreenCloseConfirmDialogOkLabel,
    ).then((value) => delegate?.closeConfirmDialogDidClose.add(value));
  }
}
