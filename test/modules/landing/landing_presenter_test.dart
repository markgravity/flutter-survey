import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quick_test/quick_test.dart';
import 'package:survey/modules/landing/landing_module.dart';
import 'package:survey/services/api/api_service.dart';

import '../../mocks/build_context.dart';
import 'landing_presenter_test.mocks.dart';

@GenerateMocks([LandingView, LandingRouter, LandingInteractor])
void main() {
  describe("a Landing presenter", () {
    late LandingPresenterImpl presenter;
    late MockLandingView view;
    late MockLandingRouter router;
    late MockLandingInteractor interactor;
    late MockBuildContext buildContext;

    beforeEach(() {
      buildContext = MockBuildContext();

      view = MockLandingView();
      when(view.context).thenReturn(buildContext);

      router = MockLandingRouter();

      interactor = MockLandingInteractor();

      presenter = LandingPresenterImpl();
      presenter.configure(view: view, interactor: interactor, router: router);
    });

    describe("it receives didInitState event", () {
      beforeEach(() {
        presenter.stateDidInit.add(null);
      });

      it("triggers view to begin animation", () {
        verify(view.beginAnimation()).called(1);
      });

      it("triggers interactor to validate authentication", () {
        verify(interactor.validateAuthentication()).called(1);
      });
    });

    describe("it receives didCloseAlertDialog event", () {
      beforeEach(() {
        presenter.alertDialogDidClose.add(null);
      });

      it("triggers interactor to validate authentication", () {
        verify(interactor.validateAuthentication()).called(1);
      });
    });

    describe("it receives didFailToValidateAuthentication event", () {
      context("when exception is not InvalidToken", () {
        beforeEach(() {
          presenter.authenticationDidFailToValidate.add(Exception());
        });

        it("triggers view to show alert dialog", () {
          verify(view.alert(any)).called(1);
        });
      });

      context("when exception is InvalidToken", () {
        beforeEach(() {
          presenter.authenticationDidFailToValidate
              .add(ApiException.invalidToken);
        });

        it("triggers interactor to logout", () {
          verify(interactor.logout()).called(1);
        });

        it("triggers router to replace to Login screen", () {
          verify(router.replaceToLoginScreen(context: buildContext)).called(1);
        });
      });
    });

    context(
        "it receives didFinishAnimation and didValidateAuthentication events",
        () {
      beforeEach(() {
        presenter.animationDidFinish.add(null);
      });

      context("when authentication exists", () {
        beforeEach(() {
          presenter.authenticationDidValidate.add(true);
        });

        it("triggers router to replace to Home screen", () {
          verify(router.replaceToHomeScreen(context: anyNamed("context")))
              .called(1);
        });
      });

      context("when authentication doesn't exists", () {
        beforeEach(() {
          presenter.authenticationDidValidate.add(false);
        });

        it("triggers router to replace to Login screen", () {
          verify(router.replaceToLoginScreen(context: anyNamed("context")))
              .called(1);
        });
      });
    });
  });
}
