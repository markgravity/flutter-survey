import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quick_test/quick_test.dart';
import 'package:survey/models/survey_info.dart';
import 'package:survey/models/user_info.dart';
import 'package:survey/modules/home/home_module.dart';

import '../../mocks/build_context.dart';
import 'home_presenter_test.mocks.dart';

@GenerateMocks([HomeView, HomeRouter, HomeInteractor])
void main() {
  describe("a Home presenter", () {
    late HomePresenterImpl presenter;
    late MockHomeView view;
    late MockHomeRouter router;
    late MockHomeInteractor interactor;
    late MockBuildContext buildContext;

    beforeEach(() {
      buildContext = MockBuildContext();

      view = MockHomeView();
      when(view.context).thenReturn(buildContext);

      router = MockHomeRouter();

      interactor = MockHomeInteractor();

      presenter = HomePresenterImpl();
      presenter.configure(view: view, interactor: interactor, router: router);
    });

    describe("it's stateDidInit emits", () {
      beforeEach(() {
        presenter.stateDidInit.add(null);
      });

      it("triggers interactor to get isSurveysCached and authenticatedUser",
          () {
        verify(interactor.getIsSurveysCached()).called(1);
        verify(interactor.getAuthenticatedUser()).called(1);
      });
    });

    describe("it's showDetailButtonDidTap emits", () {
      final survey = SurveyInfo();

      beforeEach(() {
        presenter.showDetailButtonDidTap.add(survey);
      });

      it("triggers router to push to Survey Detail screen", () {
        verify(router.pushToSurveyDetail(context: buildContext, survey: survey))
            .called(1);
      });
    });

    describe("it's surveysDidFetch emits", () {
      final surveys = List<SurveyInfo>.empty();

      beforeEach(() {
        presenter.surveysDidFetch.add(surveys);
      });

      it("trigger view to stop skeleton animation, dismiss progress hud and show surveys",
          () {
        verify(view.stopSkeletonAnimation()).called(1);
        verify(view.showSurveys(surveys)).called(1);
        verify(view.dismissProgressHUD()).called(1);
      });
    });

    describe("it's surveysDidFailToFetch emits", () {
      final exception = Exception();

      beforeEach(() {
        presenter.surveysDidFailToFetch.add(exception);
      });

      it("trigger view to stop skeleton animation, dismiss progress hud and alert error",
          () {
        verify(view.stopSkeletonAnimation()).called(1);
        verify(view.alert(exception)).called(1);
        verify(view.dismissProgressHUD()).called(1);
      });
    });

    describe("it's isSurveysCachedDidGet emits", () {
      context("when isSurveysCached is true", () {
        beforeEach(() {
          presenter.isSurveysCachedDidGet.add(true);
        });

        it("trigger interactor to fetch surveys", () {
          verify(interactor.fetchSurveys()).called(1);
        });
      });

      context("when isSurveysCached is false", () {
        beforeEach(() {
          presenter.isSurveysCachedDidGet.add(false);
        });

        it("trigger interactor to fetch surveys", () {
          verify(interactor.fetchSurveys()).called(1);
        });

        it("trigger view to begin skeleton animation", () {
          verify(view.beginSkeletonAnimation()).called(1);
        });
      });
    });

    describe("it's didSwipeDown emits", () {
      beforeEach(() {
        presenter.didSwipeDown.add(null);
      });

      it("trigger view to show progress hud", () {
        verify(view.showProgressHUD()).called(1);
      });

      it("trigger interactor to force fetch surveys", () {
        verify(interactor.fetchSurveys(force: true)).called(1);
      });
    });

    describe("it's authenticatedUserDidGet emits", () {
      final user = UserInfo();
      beforeEach(() {
        presenter.authenticatedUserDidGet.add(user);
      });

      it("trigger view to show user", () {
        verify(view.showUser(user)).called(1);
      });
    });

    describe("it's sideMenuDidShow emits", () {
      beforeEach(() {
        presenter.sideMenuDidShow.add(null);
      });

      it("trigger view to disable user interaction", () {
        verify(view.setUserInteractionEnable(isEnabled: false)).called(1);
      });
    });

    describe("it's sideMenuDidDismiss emits", () {
      beforeEach(() {
        presenter.sideMenuDidDismiss.add(null);
      });

      it("trigger view to enable user interaction", () {
        verify(view.setUserInteractionEnable(isEnabled: true)).called(1);
      });
    });

    describe("it's userAvatarButtonDidTap emits", () {
      beforeEach(() {
        presenter.userAvatarButtonDidTap.add(null);
      });

      it("trigger view to show side menu", () {
        verify(view.showSideMenu()).called(1);
      });
    });
  });
}
