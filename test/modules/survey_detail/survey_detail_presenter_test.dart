import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quick_test/quick_test.dart';
import 'package:survey/models/detailed_survey_info.dart';
import 'package:survey/models/survey_info.dart';
import 'package:survey/modules/survey_detail/survey_detail_module.dart';

import '../../mocks/build_context.dart';
import 'survey_detail_presenter_test.mocks.dart';

@GenerateMocks([SurveyDetailView, SurveyDetailRouter, SurveyDetailInteractor])
void main() {
  describe("a SurveyDetail presenter", () {
    late SurveyDetailPresenterImpl presenter;
    late MockSurveyDetailView view;
    late MockSurveyDetailRouter router;
    late MockSurveyDetailInteractor interactor;
    late MockBuildContext buildContext;
    final survey = SurveyInfo();

    beforeEach(() {
      buildContext = MockBuildContext();

      view = MockSurveyDetailView();
      when(view.context).thenReturn(buildContext);

      router = MockSurveyDetailRouter();

      interactor = MockSurveyDetailInteractor();
      when(interactor.survey).thenReturn(survey);

      presenter = SurveyDetailPresenterImpl();
      presenter.configure(view: view, interactor: interactor, router: router);
    });

    describe("its detailedSurveyDidFailToFetch to emit", () {
      final exception = Exception();
      beforeEach(() {
        presenter.detailedSurveyDidFailToFetch.add(exception);
      });

      it("triggers view to dismiss progress hud and alert error", () {
        verify(view.dismissProgressHUD()).called(1);
        verify(view.alert(exception)).called(1);
      });
    });

    describe("its detailedSurveyDidFetch emits", () {
      final survey = DetailedSurveyInfo();
      beforeEach(() {
        presenter.detailedSurveyDidFetch.add(survey);
      });

      it("triggers view to dismiss progress hud", () {
        verify(view.dismissProgressHUD()).called(1);
      });

      it("triggers router to push to Survey Questions screen", () {
        verify(
            router.pushToSurveyQuestionsScreen(buildContext, survey: survey));
      });
    });

    describe("its stateDidInit emits", () {
      beforeEach(() {
        presenter.stateDidInit.add(null);
      });

      it("triggers view to set survey", () {
        verify(view.setSurvey(survey)).called(1);
      });
    });

    describe("its startSurveyButtonDidTap emits", () {
      beforeEach(() {
        presenter.startSurveyButtonDidTap.add(null);
      });

      it("triggers view to dismiss progress hud", () {
        verify(view.showProgressHUD()).called(1);
      });

      it("triggers interactor to fetch detailed survey", () {
        verify(interactor.fetchDetailedSurvey()).called(1);
      });
    });
  });
}
