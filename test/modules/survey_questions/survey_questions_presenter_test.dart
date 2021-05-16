import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quick_test/quick_test.dart';
import 'package:survey/components/alert/alert.dart';
import 'package:survey/models/survey_question_info.dart';
import 'package:survey/models/survey_submit_answer_info.dart';
import 'package:survey/modules/survey_questions/survey_questions_module.dart';

import '../../mocks/build_context.dart';
import 'survey_questions_presenter_test.mocks.dart';

@GenerateMocks(
    [SurveyQuestionsView, SurveyQuestionsRouter, SurveyQuestionsInteractor])
void main() {
  describe("a SurveyQuestions presenter", () {
    late SurveyQuestionsPresenterImpl presenter;
    late MockSurveyQuestionsView view;
    late MockSurveyQuestionsRouter router;
    late MockSurveyQuestionsInteractor interactor;
    late MockBuildContext buildContext;

    final outro = SurveyQuestionInfo();
    final questions = <SurveyQuestionInfo>[
      SurveyQuestionInfo()..id = "1",
      SurveyQuestionInfo()..id = "2",
    ];
    final submitAnswers = List<SurveySubmitAnswerInfo>.empty();

    beforeEach(() {
      buildContext = MockBuildContext();

      view = MockSurveyQuestionsView();
      when(view.context).thenReturn(buildContext);

      router = MockSurveyQuestionsRouter();

      interactor = MockSurveyQuestionsInteractor();
      when(interactor.questions).thenReturn(questions);
      when(interactor.outro).thenReturn(outro);

      presenter = SurveyQuestionsPresenterImpl();
      presenter.configure(view: view, interactor: interactor, router: router);
    });

    describe("it's stateDidInit emits", () {
      beforeEach(() {
        presenter.stateDidInit.add(null);
      });

      it("triggers view to set questions", () {
        verify(view.setQuestions(questions)).called(1);
      });
    });

    describe("it's closeButtonDidTap emits", () {
      beforeEach(() {
        presenter.closeButtonDidTap.add(null);
      });

      it("triggers view to show close confirm dialog", () {
        verify(view.showCloseConfirmDialog()).called(1);
      });
    });

    describe("it's submitButtonDidTap emits", () {
      context("when current page is not the last", () {
        beforeEach(() {
          presenter.submitButtonDidTap.add(submitAnswers);
        });

        it("triggers view to show the next question", () {
          verify(view.moveTo(1)).called(1);
        });
      });

      context("when current page is the last", () {
        beforeEach(() async {
          presenter.submitButtonDidTap.add(submitAnswers);
          presenter.submitButtonDidTap.add(submitAnswers);
          await untilCalled(view.showProgressHUD());
        });

        it("triggers view to show progress hud", () {
          verify(view.showProgressHUD()).called(1);
        });

        it("triggers interactor to submit", () {
          verify(interactor.submit(any)).called(1);
        });
      });
    });

    describe("it's closeConfirmDialogDidClose emits", () {
      context("when result is cancel", () {
        beforeEach(() {
          presenter.closeConfirmDialogDidClose.add(OkCancelResult.cancel);
        });

        it("does nothing", () {
          verifyNever(router.popBack(buildContext));
        });
      });

      context("when result is ok", () {
        beforeEach(() {
          presenter.closeConfirmDialogDidClose.add(OkCancelResult.ok);
        });

        it("trigger router to pop back", () {
          verify(router.popBack(buildContext)).called(1);
        });
      });
    });

    describe("it's submitDidSuccess emits", () {
      beforeEach(() {
        presenter.submitDidSuccess.add(null);
      });

      it("triggers view to dismiss progress hud", () {
        verify(view.dismissProgressHUD()).called(1);
      });

      it("triggers router to push to Survey Completed screen", () {
        verify(router.pushToSurveyCompletedScreen(buildContext, outro: outro))
            .called(1);
      });
    });

    describe("it's submitDidFail emits", () {
      final exception = Exception();

      beforeEach(() {
        presenter.submitDidFail.add(exception);
      });

      it("triggers view to alert exception", () {
        verify(view.alert(exception)).called(1);
      });
    });
  });
}
