import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quick_test/quick_test.dart';
import 'package:survey/models/survey_question_info.dart';
import 'package:survey/modules/survey_completed/survey_completed_module.dart';

import '../../mocks/build_context.dart';
import 'survey_completed_presenter_test.mocks.dart';

@GenerateMocks(
    [SurveyCompletedView, SurveyCompletedRouter, SurveyCompletedInteractor])
void main() {
  describe("a SurveyCompleted presenter", () {
    late SurveyCompletedPresenterImpl presenter;
    late MockSurveyCompletedView view;
    late MockSurveyCompletedRouter router;
    late MockSurveyCompletedInteractor interactor;
    late MockBuildContext buildContext;
    final outro = SurveyQuestionInfo();

    beforeEach(() {
      buildContext = MockBuildContext();

      view = MockSurveyCompletedView();
      when(view.context).thenReturn(buildContext);

      router = MockSurveyCompletedRouter();

      interactor = MockSurveyCompletedInteractor();
      when(interactor.outro).thenReturn(outro);

      presenter = SurveyCompletedPresenterImpl();
      presenter.configure(view: view, interactor: interactor, router: router);
    });

    describe("it's stateDidInit emits", () {
      beforeEach(() {
        presenter.stateDidInit.add(null);
      });

      it("triggers view to set outro", () {
        verify(view.setOutro(outro)).called(1);
      });

      describe("it's animationDidLoad emits", () {
        beforeEach(() {
          presenter.animationDidLoad.add(null);
        });

        it("triggers view to begin animation", () {
          verify(view.beginAnimation()).called(1);
        });
      });
    });

    describe("it's animationDidFinish emits", () {
      beforeEach(() async {
        presenter.animationDidFinish.add(null);
        await untilCalled(router.popBack(buildContext));
      });

      it("triggers view to set outro", () {
        verify(router.popBack(buildContext)).called(1);
      });
    });
  });
}
