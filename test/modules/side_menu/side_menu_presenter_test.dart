import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quick_test/quick_test.dart';
import 'package:survey/models/survey_info.dart';
import 'package:survey/models/user_info.dart';
import 'package:survey/modules/side_menu/side_menu_module.dart';

import '../../mocks/build_context.dart';
import 'side_menu_presenter_test.mocks.dart';

@GenerateMocks([SideMenuView, SideMenuRouter, SideMenuInteractor])
void main() {
  describe("a SideMenu presenter", () {
    late SideMenuPresenterImpl presenter;
    late MockSideMenuView view;
    late MockSideMenuRouter router;
    late MockSideMenuInteractor interactor;
    late MockBuildContext buildContext;

    beforeEach(() {
      buildContext = MockBuildContext();

      view = MockSideMenuView();
      when(view.context).thenReturn(buildContext);

      router = MockSideMenuRouter();

      interactor = MockSideMenuInteractor();

      presenter = SideMenuPresenterImpl();
      presenter.configure(view: view, interactor: interactor, router: router);
    });

    describe("it's logoutButtonDidTap emits", () {
      beforeEach(() {
        presenter.logoutButtonDidTap.add(null);
      });

      it("triggers interactor to logout", () {
        verify(interactor.logout()).called(1);
      });
    });

    describe("it's logoutDidSuccess emits", () {
      beforeEach(() {
        presenter.logoutDidSuccess.add(null);
      });

      it("triggers router to replace to Login screen", () {
        verify(router.replaceToLoginScreen(buildContext)).called(1);
      });
    });
  });
}
