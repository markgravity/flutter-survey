import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:quick_test/quick_widget_test.dart';
import 'package:survey/models/survey_info.dart';
import 'package:survey/core/viper/module.dart';
import 'package:mockito/mockito.dart';
import 'package:survey/modules/survey_detail/survey_detail_module.dart';
import '../../fakers/fake_module.dart';
import '../../helpers/behavior_subject_generator.dart';
import '../../helpers/extensions/widget_tester.dart';
import 'survey_detail_view_test.mocks.dart';

@GenerateMocks([SurveyDetailViewDelegate])
void main() {
  describe("a SurveyDetail view", () {
    late FakeModule<SurveyDetailView, SurveyDetailViewDelegate> module;
    late MockSurveyDetailViewDelegate delegate;
    late BehaviorSubjectGenerator generator;
    final survey = SurveyInfo();
    survey.id = "id";
    survey.coverImageUrl = "https://example.com";
    survey.title = "title";
    survey.description = "description";

    beforeEach((tester) async {
      HttpOverrides.global = null;
      generator = BehaviorSubjectGenerator();
      delegate = MockSurveyDetailViewDelegate();
      when(delegate.startSurveyButtonDidTap)
          .thenAnswer((realInvocation) => generator.make(0));
      when(delegate.stateDidInit)
          .thenAnswer((realInvocation) => generator.make(1));

      module = FakeModule(
        builder: () => const SurveyDetailViewImpl(),
        delegate: delegate,
      );
      ViewState.overriddenModule = module;
      await tester.pumpModule(module);
      await tester.pumpAndSettle();
    });

    describe("its setSurvey() is called", () {
      beforeEach((tester) async {
        module.view.setSurvey(survey);
        await tester.pumpAndSettle();
      });

      it("displays correct information", (tester) async {
        expect(find.text(survey.title!), findsOneWidget);
        expect(find.text(survey.description!), findsOneWidget);

        final provider = tester
            .widget<Image>(find.byKey(SurveyDetailView.backgroundImageKey))
            .image as NetworkImage;
        expect(provider.url, survey.coverImageUrl);
      });
    });

    describe("its start survey button is tapped", () {
      beforeEach((tester) async {
        await tester.tap(find.byKey(SurveyDetailView.startSurveyButtonKey));
      });

      it("triggers delegate's startSurveyButtonDidTap to emit", (tester) async {
        expect(delegate.startSurveyButtonDidTap, emits(null));
      });
    });
  });
}
