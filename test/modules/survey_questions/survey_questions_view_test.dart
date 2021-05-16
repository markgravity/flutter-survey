import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:quick_test/quick_widget_test.dart';
import 'package:survey/components/button/button.dart';
import 'package:survey/components/navigation_bar/navigation_bar.dart';
import 'package:survey/models/survey_question_answer_info.dart';
import 'package:survey/models/survey_question_info.dart';
import 'package:survey/core/viper/module.dart';
import 'package:mockito/mockito.dart';
import 'package:survey/modules/survey_questions/survey_questions_module.dart';
import '../../fakers/fake_module.dart';
import '../../helpers/behavior_subject_generator.dart';
import '../../helpers/extensions/widget_tester.dart';
import 'survey_questions_view_test.mocks.dart';

@GenerateMocks([SurveyQuestionsViewDelegate])
void main() {
  describe("a SurveyQuestions view", () {
    late FakeModule<SurveyQuestionsView, SurveyQuestionsViewDelegate> module;
    late MockSurveyQuestionsViewDelegate delegate;
    late BehaviorSubjectGenerator generator;

    final question1 = SurveyQuestionInfo();
    question1.content = "q1";
    question1.pickType = SurveyQuestionPickType.any;
    question1.displayOrder = 0;
    question1.coverImageOpacity = 1;
    question1.coverImageUrl = "https://example.com";
    question1.displayType = SurveyQuestionDisplayType.choice;

    final question2 = SurveyQuestionInfo();
    question1.content = "q2";
    question1.pickType = SurveyQuestionPickType.any;
    question2.coverImageOpacity = 1;
    question2.coverImageUrl = "https://example.com";
    question2.displayOrder = 2;
    question2.displayType = SurveyQuestionDisplayType.textarea;

    final questions = [question1, question2];

    beforeEach((tester) async {
      HttpOverrides.global = null;

      generator = BehaviorSubjectGenerator();

      delegate = MockSurveyQuestionsViewDelegate();
      when(delegate.stateDidInit)
          .thenAnswer((realInvocation) => generator.make(0));
      when(delegate.submitButtonDidTap)
          .thenAnswer((realInvocation) => generator.make(1));
      when(delegate.closeConfirmDialogDidClose)
          .thenAnswer((realInvocation) => generator.make(2));
      when(delegate.closeButtonDidTap)
          .thenAnswer((realInvocation) => generator.make(3));
      when(delegate.alertDialogDidClose)
          .thenAnswer((realInvocation) => generator.make(4));

      module = FakeModule(
        builder: () => const SurveyQuestionsViewImpl(),
        delegate: delegate,
      );
      ViewState.overriddenModule = module;
      await tester.pumpModule(module);
      await tester.pumpAndSettle();
    });

    it("displays navigation bar with back button hidden and close button",
        (tester) async {
      final widget = tester.widget<NavigationBar>(find.byType(NavigationBar));
      expect(widget.isBackButtonHidden, isTrue);
    });

    describe("it's setQuestions() is called", () {
      beforeEach((tester) async {
        module.view.setQuestions(questions);
        await tester.pumpAndSettle();
      });

      it("triggers carousel displays first question", (tester) async {
        final widget =
            tester.widget<Slide>(find.byKey(SurveyQuestionsView.slideKey));
        expect(widget.question, question1);
        expect(find.byKey(SurveyQuestionsView.closeButtonKey), findsOneWidget);
      });
    });

    describe("it's slide", () {
      late SurveyQuestionInfo question;
      beforeEach((_) async {
        question = SurveyQuestionInfo();
        question.id = "id";
        question.content = "q1";
        question.displayOrder = 0;
        question.coverImageOpacity = 1;
        question.coverImageUrl = "https://example.com";
        question.answers = [
          SurveyQuestionAnswerInfo()
            ..id = "id"
            ..displayOrder = 0
            ..content = "content"
        ];
      });

      context("when the question's display type is choice", () {
        context("and it's pick type is any", () {
          beforeEach((tester) async {
            question.displayType = SurveyQuestionDisplayType.choice;
            question.pickType = SurveyQuestionPickType.any;

            module.view.setQuestions([question]);
            await tester.pumpAndSettle();
          });

          it("displays a select answer with multi selection is true",
              (tester) async {
            final widget =
                tester.widget<SelectAnswer>(find.byType(SelectAnswer));
            expect(widget.options, question.orderedAnswers);
            expect(widget.isMultiSelection, true);
          });
        });

        context("and it's pick type is one", () {
          beforeEach((tester) async {
            question.displayType = SurveyQuestionDisplayType.choice;
            question.pickType = SurveyQuestionPickType.one;

            module.view.setQuestions([question]);
            await tester.pumpAndSettle();
          });

          it("displays a select answer with multi selection is false",
              (tester) async {
            final widget =
                tester.widget<SelectAnswer>(find.byType(SelectAnswer));
            expect(widget.options, question.orderedAnswers);
            expect(widget.isMultiSelection, false);
          });
        });
      });

      context("when the question's display type is heart", () {
        beforeEach((tester) async {
          question.displayType = SurveyQuestionDisplayType.heart;

          module.view.setQuestions([question]);
          await tester.pumpAndSettle();
        });

        it("displays a rating answer with symbol is heart", (tester) async {
          final widget = tester.widget<RatingAnswer>(find.byType(RatingAnswer));
          expect(widget.symbol, "❤️");
        });
      });

      context("when the question's display type is star", () {
        beforeEach((tester) async {
          question.displayType = SurveyQuestionDisplayType.star;

          module.view.setQuestions([question]);
          await tester.pumpAndSettle();
        });

        it("displays a rating answer with symbol is star", (tester) async {
          final widget = tester.widget<RatingAnswer>(find.byType(RatingAnswer));
          expect(widget.symbol, "⭐️");
        });
      });

      context("when the question's display type is smiley", () {
        beforeEach((tester) async {
          question.displayType = SurveyQuestionDisplayType.smiley;

          module.view.setQuestions([question]);
          await tester.pumpAndSettle();
        });

        it("displays a rating answer with symbol is smiley", (tester) async {
          final widget = tester.widget<RatingAnswer>(find.byType(RatingAnswer));
          expect(widget.symbol, "😃");
        });
      });

      context("when the question's display type is nps", () {
        beforeEach((tester) async {
          question.displayType = SurveyQuestionDisplayType.nps;
          question.answers = [
            SurveyQuestionAnswerInfo()
              ..displayOrder = 0
              ..content = "1",
            SurveyQuestionAnswerInfo()
              ..displayOrder = 1
              ..content = "2",
          ];
          module.view.setQuestions([question]);
          await tester.pumpAndSettle();
        });

        it("displays a nps answer", (tester) async {
          expect(find.byType(NPSAnswer), findsOneWidget);
        });
      });

      context("when the question's display type is textarea", () {
        beforeEach((tester) async {
          question.displayType = SurveyQuestionDisplayType.textarea;

          module.view.setQuestions([question]);
          await tester.pumpAndSettle();
        });

        it("displays a text field with multiline is true", (tester) async {
          final widget =
              tester.widget<TextFieldAnswer>(find.byType(TextFieldAnswer));
          expect(widget.isMultiLines, isTrue);
        });
      });

      context("when the question's display type is text field", () {
        beforeEach((tester) async {
          question.displayType = SurveyQuestionDisplayType.textField;

          module.view.setQuestions([question]);
          await tester.pumpAndSettle();
        });

        it("displays a text field with multiline is false", (tester) async {
          final widget =
              tester.widget<TextFieldAnswer>(find.byType(TextFieldAnswer));
          expect(widget.isMultiLines, isFalse);
        });
      });

      context("when the question's mandatory is true", () {
        beforeEach((tester) async {
          question.isMandatory = true;
        });

        context("when submit answers is not emptied", () {
          beforeEach((tester) async {
            question.displayType = SurveyQuestionDisplayType.textField;

            module.view.setQuestions([question]);
            await tester.pumpAndSettle();
            final widget =
                tester.widget<TextFieldAnswer>(find.byType(TextFieldAnswer));
            widget.onTextChange!("a");
            await tester.pumpAndSettle();
          });

          it("makes submit button become enable", (tester) async {
            final widget = tester.widget<Button>(
                find.byKey(SurveyQuestionsView.submitButtonKey));
            expect(widget.isEnabled, true);
          });
        });

        context("when submit answers is emptied", () {
          beforeEach((tester) async {
            question.displayType = SurveyQuestionDisplayType.textField;
            question.isMandatory = true;

            module.view.setQuestions([question]);
            await tester.pumpAndSettle();
          });

          it("makes submit button become disable", (tester) async {
            final widget = tester.widget<Button>(
                find.byKey(SurveyQuestionsView.submitButtonKey));
            expect(widget.isEnabled, false);
          });
        });
      });

      context("when the question's mandatory is false", () {
        beforeEach((tester) async {
          question.displayType = SurveyQuestionDisplayType.textField;
          question.isMandatory = false;

          module.view.setQuestions([question]);
          await tester.pumpAndSettle();
        });

        it("makes submit button become enable", (tester) async {
          final widget = tester
              .widget<Button>(find.byKey(SurveyQuestionsView.submitButtonKey));
          expect(widget.isEnabled, true);
        });
      });
    });

    describe("it's close button is tapped", () {
      beforeEach((tester) async {
        await tester.tap(find.byKey(SurveyQuestionsView.closeButtonKey));
      });

      it("triggers delegate's closeButtonDidTap emits", (tester) async {
        expect(delegate.closeButtonDidTap, emits(null));
      });
    });
  });
}
