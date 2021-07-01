import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quick_test/quick_test.dart';
import 'package:survey/models/survey_info.dart';
import 'package:survey/models/user_info.dart';
import 'package:survey/modules/home/home_module.dart';
import 'package:tuple/tuple.dart';

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

    describe("its stateDidInit emits", () {
      beforeEach(() {
        presenter.stateDidInit.add(null);
      });

      it("triggers interactor to get isSurveysCached and authenticatedUser",
          () {
        verify(interactor.fetchSurveysFromCached()).called(1);
        verify(interactor.getAuthenticatedUser()).called(1);
      });
    });

    describe("its showDetailButtonDidTap emits", () {
      final survey = SurveyInfo();

      beforeEach(() {
        presenter.showDetailButtonDidTap.add(survey);
      });

      it("triggers router to push to Survey Detail screen", () {
        verify(router.pushToSurveyDetail(context: buildContext, survey: survey))
            .called(1);
      });
    });

    describe("its surveysDidFetchFromCached emits", () {
      context("when cached surveys is emptied", () {
        final surveys = List<SurveyInfo>.empty();

        beforeEach(() {
          presenter.surveysDidFetchFromCached.add(surveys);
        });

        it("trigger view to begin skeleton animation", () {
          verify(view.beginSkeletonAnimation()).called(1);
        });

        it("trigger interactor to fetch surveys from remote", () {
          verify(interactor.fetchSurveysFromRemote()).called(1);
        });
      });

      context("when cached surveys is not emptied", () {
        final surveys = [SurveyInfo()];

        beforeEach(() {
          presenter.surveysDidFetchFromCached.add(surveys);
        });

        it("trigger view to show surveys", () {
          verify(view.showSurveys(surveys)).called(1);
        });

        it("trigger interactor to fetch surveys from remote", () {
          verify(interactor.fetchSurveysFromRemote()).called(1);
        });
      });
    });

    describe("its surveysDidFailToFetchFromCached emits", () {
      final exception = Exception();

      beforeEach(() {
        presenter.surveysDidFailToFetchFromCached.add(exception);
      });

      it("trigger view to alert error", () {
        verify(view.alert(exception)).called(1);
      });
    });

    describe("its surveysDidFetchFromRemote emits", () {
      final surveys = List<SurveyInfo>.empty();

      context("when remote provides new data", () {
        beforeEach(() {
          presenter.surveysDidFetchFromRemote.add(Tuple2(surveys, true));
        });

        it("trigger view to stop skeleton animation, dismiss progress hud and show surveys",
            () {
          verify(view.stopSkeletonAnimation()).called(1);
          verify(view.showSurveys(surveys)).called(1);
          verify(view.dismissProgressHUD()).called(1);
        });
      });

      context("when remote provides same data with cached", () {
        beforeEach(() {
          presenter.surveysDidFetchFromRemote.add(Tuple2(surveys, false));
        });

        it("trigger view to stop skeleton animation and dismiss progress hud",
            () {
          verify(view.stopSkeletonAnimation()).called(1);
          verify(view.dismissProgressHUD()).called(1);
        });
      });
    });

    describe("its surveysDidFailToFetchFromRemote emits", () {
      final exception = Exception();

      beforeEach(() {
        presenter.surveysDidFailToFetchFromRemote.add(exception);
      });

      it("trigger view to stop skeleton animation, dismiss progress hud and alert error",
          () {
        verify(view.stopSkeletonAnimation()).called(1);
        verify(view.alert(exception)).called(1);
        verify(view.dismissProgressHUD()).called(1);
      });
    });

    describe("its didSwipeDown emits", () {
      beforeEach(() {
        presenter.didSwipeDown.add(null);
      });

      it("trigger view to show progress hud", () {
        verify(view.showProgressHUD()).called(1);
      });

      it("trigger interactor to force fetch surveys", () {
        verify(interactor.fetchSurveysFromRemote()).called(1);
      });
    });

    describe("its authenticatedUserDidGet emits", () {
      final user = UserInfo();
      beforeEach(() {
        presenter.authenticatedUserDidGet.add(user);
      });

      it("trigger view to show user", () {
        verify(view.showUser(user)).called(1);
      });
    });

    describe("its sideMenuDidShow emits", () {
      beforeEach(() {
        presenter.sideMenuDidShow.add(null);
      });

      it("trigger view to disable user interaction", () {
        verify(view.setUserInteractionEnable(isEnabled: false)).called(1);
      });
    });

    describe("its sideMenuDidDismiss emits", () {
      beforeEach(() {
        presenter.sideMenuDidDismiss.add(null);
      });

      it("trigger view to enable user interaction", () {
        verify(view.setUserInteractionEnable(isEnabled: true)).called(1);
      });
    });

    describe("its userAvatarButtonDidTap emits", () {
      beforeEach(() {
        presenter.userAvatarButtonDidTap.add(null);
      });

      it("trigger view to show side menu", () {
        verify(view.showSideMenu()).called(1);
      });
    });
  });
}
