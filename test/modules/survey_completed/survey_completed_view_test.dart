import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:mockito/annotations.dart';
import 'package:quick_test/quick_widget_test.dart';
import 'package:survey/models/survey_question_info.dart';
import 'package:survey/models/user_info.dart';
import 'package:survey/core/viper/module.dart';
import 'package:mockito/mockito.dart';
import 'package:survey/modules/survey_completed/survey_completed_module.dart';
import '../../fakers/fake_module.dart';
import '../../helpers/behavior_subject_generator.dart';
import '../../helpers/extensions/widget_tester.dart';
import 'survey_completed_view_test.mocks.dart';

@GenerateMocks([SurveyCompletedViewDelegate])
void main() {
  describe("a SurveyCompleted view", () {
    late FakeModule<SurveyCompletedView, SurveyCompletedViewDelegate> module;
    late MockSurveyCompletedViewDelegate delegate;
    late BehaviorSubjectGenerator generator;
    final outro = SurveyQuestionInfo();
    outro.content = "thank you";

    beforeEach((tester) async {
      generator = BehaviorSubjectGenerator();
      delegate = MockSurveyCompletedViewDelegate();
      when(delegate.animationDidLoad)
          .thenAnswer((realInvocation) => generator.make(0));
      when(delegate.animationDidFinish)
          .thenAnswer((realInvocation) => generator.make(1));
      when(delegate.stateDidInit)
          .thenAnswer((realInvocation) => generator.make(2));

      module = FakeModule(
        builder: () => const SurveyCompletedViewImpl(),
        delegate: delegate,
      );
      ViewState.overriddenModule = module;
      await tester.pumpModule(module);
      await tester.pumpAndSettle();
    });

    describe("it's setOutro() is called", () {
      beforeEach((tester) async {
        module.view.setOutro(outro);
        await tester.pumpAndSettle();
      });

      it("displays correct outro text", (tester) async {
        expect(find.text(outro.content!), findsOneWidget);
      });
    });

    describe("it's beginAnimation() is called", () {
      beforeEach((tester) async {
        await delegate.animationDidLoad.first;
        module.view.beginAnimation();
        await tester.pumpAndSettle();
      });

      it("trigger lottie begin animation", (tester) async {
        final widget = tester
            .widget<LottieBuilder>(find.byKey(SurveyCompletedView.lottieKey));
        expect(widget.controller!.status, AnimationStatus.completed);
      });

      it("trigger delegate's emits", (tester) async {
        expect(delegate.animationDidFinish, emits(null));
      });
    });
  });
}
