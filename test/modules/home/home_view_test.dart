import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:quick_test/quick_widget_test.dart';
import 'package:skeletor/skeletor.dart';
import 'package:streams_provider/streams_provider.dart';
import 'package:survey/models/survey_info.dart';
import 'package:survey/models/user_info.dart';
import 'package:survey/modules/home/home_module.dart';
import 'package:survey/core/viper/module.dart';
import 'package:mockito/mockito.dart';
import 'package:survey/modules/side_menu/side_menu_module.dart';
import 'package:survey/services/locator/locator_service.dart';
import '../../fakers/fake_module.dart';
import '../../helpers/behavior_subject_generator.dart';
import '../../helpers/extensions/widget_tester.dart';
import 'home_view_test.mocks.dart';

class MockSideMenuPresenter extends Mock
    implements
        SideMenuPresenter,
        SideMenuViewDelegate,
        SideMenuInteractorDelegate {
  @override
  final stateDidInit = BehaviorSubject<void>();
}

@GenerateMocks([HomeViewDelegate, SideMenuInteractor, SideMenuRouter])
void main() {
  describe("a Home view", () {
    late FakeModule<HomeView, HomeViewDelegate> module;
    late MockHomeViewDelegate delegate;
    late BehaviorSubjectGenerator generator;

    final surveys = List<SurveyInfo>.empty(growable: true);
    const numberOfSurvey = 5;

    for (int i = 1; i <= numberOfSurvey; i++) {
      final survey = SurveyInfo();
      survey.title = "title $i";
      survey.description = "description $i";
      survey.coverImageUrl = "https://example.com/$i";
      surveys.add(survey);
    }

    beforeEach((tester) async {
      HttpOverrides.global = null;

      generator = BehaviorSubjectGenerator();
      delegate = MockHomeViewDelegate();
      when(delegate.stateDidInit)
          .thenAnswer((realInvocation) => generator.make(1));
      when(delegate.alertDialogDidClose)
          .thenAnswer((realInvocation) => generator.make(2));
      when(delegate.showDetailButtonDidTap)
          .thenAnswer((realInvocation) => generator.make(3));
      when(delegate.didSwipeDown)
          .thenAnswer((realInvocation) => generator.make(4));
      when(delegate.currentPageDidChange)
          .thenAnswer((realInvocation) => generator.make(5));
      when(delegate.sideMenuDidShow)
          .thenAnswer((realInvocation) => generator.make(6));
      when(delegate.sideMenuDidDismiss)
          .thenAnswer((realInvocation) => generator.make(7));
      when(delegate.userAvatarButtonDidTap)
          .thenAnswer((realInvocation) => generator.make(8));

      locator.registerSingleton<SideMenuPresenter>(MockSideMenuPresenter());
      locator.registerSingleton<SideMenuInteractor>(MockSideMenuInteractor());
      locator.registerSingleton<SideMenuRouter>(MockSideMenuRouter());

      module = FakeModule(
        builder: () => const HomeViewImpl(),
        delegate: delegate,
      );
      ViewState.overriddenModule = module;
      await tester.pumpModule(module);
    });

    context("when wipes from top to bottom on screen", () {
      beforeEach((tester) async {
        await tester.pumpAndSettle();

        final center = tester.getCenter(find.byKey(HomeView.bodyKey));
        final location = Offset(center.dx, 0);
        await tester.flingFrom(location, Offset(0, center.dy), center.dy);
      });

      it("triggers delegate's didSwipeDown to emit", (tester) async {
        expect(delegate.didSwipeDown, emits(null));
      });
    });

    describe("its setDateTimeText is called", () {
      const text = "SATURDAY, MAY 2";
      beforeEach((tester) async {
        module.view.setDateTimeText(text);
        await tester.pumpAndSettle();
      });

      it("shows correct current date text", (tester) async {
        expect(find.text(text), findsOneWidget);
      });
    });

    describe("its showUser() is called", () {
      final user = UserInfo();
      user.avatarUrl = "https://example.com";

      beforeEach((tester) async {
        module.view.showUser(user);
        await tester.pumpAndSettle();
      });

      it("makes user's avatar image to display input user's avatar",
          (tester) async {
        final widget =
            tester.widget<Image>(find.byKey(HomeView.userAvatarImageKey));
        final networkImage = widget.image as NetworkImage;

        expect(networkImage.url, user.avatarUrl);
      });
    });

    describe("its showSurveys() is called", () {
      beforeEach((tester) async {
        module.view.showSurveys(surveys);
        await tester.pumpAndSettle();
      });

      it("triggers carousel slider to display the first survey information",
          (tester) async {
        final survey = surveys.first;
        expect(find.text(survey.title!), findsOneWidget);
        expect(find.text(survey.description!), findsOneWidget);

        final widget = tester
            .widget<Image>(find.byKey(HomeView.backgroundImageSlideItemKey));
        final networkImage = widget.image as NetworkImage;
        expect(networkImage.url, survey.coverImageUrl);
      });

      it("triggers page control to display correct number of dots and highlight the first dot",
          (tester) async {
        expect(find.byKey(HomeView.dotPageControlKey),
            findsNWidgets(surveys.length));

        final dots = tester
            .widgetList<Container>(find.byKey(HomeView.dotPageControlKey))
            .toList();
        for (int i = 0; i < dots.length; i++) {
          final dot = dots[i];
          final boxDecoration = dot.decoration! as BoxDecoration;
          final color = i == 0
              ? HomeView.dotPageControlHighlightColor
              : HomeView.dotPageControlNormalColor;
          expect(boxDecoration.color, color);
        }
      });

      context("when swipes right to left on screen", () {
        beforeEach((tester) async {
          final location = tester.getCenter(find.byKey(HomeView.bodyKey));
          await tester.flingFrom(
              location, Offset(-location.dx, 0), location.dx);
          await tester.pumpAndSettle();
        });

        it("triggers carousel slider to show the second survey information",
            (tester) async {
          final survey = surveys[1];
          expect(find.text(survey.title!), findsOneWidget);
          expect(find.text(survey.description!), findsOneWidget);

          final widget = tester
              .widget<Image>(find.byKey(HomeView.backgroundImageSlideItemKey));
          final networkImage = widget.image as NetworkImage;
          expect(networkImage.url, survey.coverImageUrl);
        });
      });

      context("when swipes left to right on screen", () {
        beforeEach((tester) async {
          final location = tester.getCenter(find.byKey(HomeView.bodyKey));
          await tester.flingFrom(location, Offset(location.dx, 0), location.dx);
          await tester.pumpAndSettle();
        });

        it("triggers carousel slider to display the last survey information",
            (tester) async {
          final survey = surveys.last;
          expect(find.text(survey.title!), findsOneWidget);
          expect(find.text(survey.description!), findsOneWidget);

          final widget = tester
              .widget<Image>(find.byKey(HomeView.backgroundImageSlideItemKey));
          final networkImage = widget.image as NetworkImage;
          expect(networkImage.url, survey.coverImageUrl);
        });
      });
    });

    describe("its beginSkeletonAnimation() is called", () {
      beforeEach((tester) async {
        module.view.beginSkeletonAnimation();
        await tester.pump();
        await tester.pump();
        await tester.pump();
      });

      it("triggers skeleton to begin animation", (tester) async {
        final widget =
            tester.widget<Skeleton>(find.byKey(HomeView.skeletonKey));
        expect(widget.isShown, isTrue);
      });
    });

    describe("its stopSkeletonAnimation() is called", () {
      beforeEach((tester) async {
        module.view.stopSkeletonAnimation();
        await tester.pump();
        await tester.pump();
        await tester.pump();
      });

      it("triggers skeleton to stop animation", (tester) async {
        final widget =
            tester.widget<Skeleton>(find.byKey(HomeView.skeletonKey));
        expect(widget.isShown, isFalse);
      });
    });

    describe("its show detail button in one of slide items is tapped", () {
      beforeEach((tester) async {
        module.view.showSurveys(surveys);
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(HomeView.showDetailButtonKey));
      });

      it("triggers delegate's showDetailButtonDidTap to emit", (tester) async {
        expect(delegate.showDetailButtonDidTap, emits(surveys.first));
      });
    });

    describe("its showSideMenu() is called", () {
      beforeEach((tester) async {
        await tester.pumpAndSettle();
        module.view.showSideMenu();
        await tester.pumpAndSettle();
      });

      it("triggers delegate's sideMenuDidShow to emit", (tester) async {
        expect(delegate.sideMenuDidShow, emits(null));
      });

      describe("then wipes from left to right", () {
        beforeEach((tester) async {
          final location = tester.getCenter(find.byKey(HomeView.bodyKey));
          await tester.flingFrom(location, Offset(location.dx, 0), location.dx);
          await tester.pumpAndSettle();
        });

        it("triggers delegate's sideMenuDidDismiss to emit", (tester) async {
          expect(delegate.sideMenuDidDismiss, emits(null));
        });
      });
    });

    describe("its user avatar button is tapped", () {
      beforeEach((tester) async {
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(HomeView.userAvatarButtonKey));
      });

      it("triggers delegate's userAvatarButtonDidTap to emit", (tester) async {
        expect(delegate.userAvatarButtonDidTap, emits(null));
      });
    });

    describe("its setUserInteractionEnable() is called", () {
      beforeEach((tester) async {
        module.view.setUserInteractionEnable(isEnabled: false);
        await tester.pumpAndSettle();
      });

      it("triggers main ignore pointer updates with correct ignoring value",
          (tester) async {
        final widget = tester
            .widget<IgnorePointer>(find.byKey(HomeView.mainIgnorePointer));
        expect(widget.ignoring, true);
      });
    });
  });
}
