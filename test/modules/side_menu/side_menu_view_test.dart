import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:quick_test/quick_widget_test.dart';
import 'package:survey/models/user_info.dart';
import 'package:survey/core/viper/module.dart';
import 'package:mockito/mockito.dart';
import 'package:survey/modules/side_menu/side_menu_module.dart';
import '../../fakers/fake_module.dart';
import '../../helpers/behavior_subject_generator.dart';
import '../../helpers/extensions/widget_tester.dart';
import 'side_menu_view_test.mocks.dart';

@GenerateMocks([SideMenuViewDelegate])
void main() {
  describe("a SideMenu view", () {
    late FakeModule<SideMenuView, SideMenuViewDelegate> module;
    late MockSideMenuViewDelegate delegate;
    late BehaviorSubjectGenerator generator;

    beforeEach((tester) async {
      HttpOverrides.global = null;
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      generator = BehaviorSubjectGenerator();
      delegate = MockSideMenuViewDelegate();
      when(delegate.logoutButtonDidTap)
          .thenAnswer((realInvocation) => generator.make(1));

      module = FakeModule(
        builder: () => const SideMenuViewImpl(),
        delegate: delegate,
      );
      ViewState.overriddenModule = module;
      await tester.pumpModule(module);
    });

    afterEach((_) async {
      debugDefaultTargetPlatformOverride = null;
    });

    describe("it's setUser() is called", () {
      final user = UserInfo();
      user.avatarUrl = "http://example.com";
      user.email = "email";

      beforeEach((tester) async {
        module.view.setUser(user);
        await tester.pumpAndSettle();
      });

      it("triggers user widget displays correct information", (tester) async {
        expect(find.text(user.email!), findsOneWidget);

        final image =
            tester.widget<Image>(find.byKey(SideMenuView.userAvatarImageKey));
        final provider = image.image as NetworkImage;
        expect(provider.url, user.avatarUrl);
      });
    });

    describe("it's logout button is tapped", () {
      beforeEach((tester) async {
        await tester.tap(find.byKey(SideMenuView.logoutButtonKey));
      });

      it("triggers delegate's logoutButtonDidTap emits", (tester) async {
        expect(delegate.logoutButtonDidTap, emits(null));
      });
    });
  });
}
