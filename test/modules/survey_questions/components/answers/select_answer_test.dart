import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quick_test/quick_widget_test.dart';
import 'package:survey/app.dart';
import 'package:survey/models/survey_question_answer_info.dart';
import 'package:survey/modules/survey_questions/survey_questions_module.dart';

void main() {
  describe("a RatingAnswer widget", () {
    late List<Widget> widgets;
    ValueChanged<List<SurveyQuestionAnswerInfo>> onSelect = (i) {};
    final items = List<SurveyQuestionAnswerInfo>.empty(growable: true);
    for (int i = 0; i < 10; i++) {
      final item = SurveyQuestionAnswerInfo()..content = "$i";
      items.add(item);
    }

    context("when multi selection is true", () {
      beforeEach((tester) async {
        await tester.pumpWidget(
          App(
            overrideHome: SelectAnswer(
              options: items,
              isMultiSelection: true,
              onSelect: (i) => onSelect(i),
            ),
          ),
        );
        await tester.pumpAndSettle();
        widgets = tester.widgetList(find.byKey(SelectAnswer.itemKey)).toList();
      });

      describe("it's item is tapped", () {
        late Widget widget;
        late List<SurveyQuestionAnswerInfo> selected;

        beforeEach((tester) async {
          widget = widgets.first;
          final checkboxFinder = find.descendant(
            of: find.byWidget(widget),
            matching: find.byKey(SelectAnswer.checkboxKey),
          );

          onSelect = (item) {
            selected = item;
          };

          await tester.tap(checkboxFinder);
          await tester.pumpAndSettle();
        });

        it("triggers onSelect callback", (tester) async {
          expect(selected, [items.first]);
        });

        it("highlights tapped item", (tester) async {
          expect(
            find.descendant(
              of: find.byWidget(widget),
              matching: find.byKey(SelectAnswer.checkboxSelectedImageKey),
            ),
            findsOneWidget,
          );

          final text = tester.widget<Text>(
            find.descendant(
              of: find.byWidget(widget),
              matching: find.byKey(SelectAnswer.itemTextKey),
            ),
          );

          expect(text.style!.fontWeight, SelectAnswer.highlightFontWeight);
        });
      });
    });

    context("when multi selection is false", () {
      beforeEach((tester) async {
        await tester.pumpWidget(
          App(
            overrideHome: SelectAnswer(
              options: items,
              onSelect: (i) => onSelect(i),
            ),
          ),
        );
        await tester.pumpAndSettle();
        widgets = tester.widgetList(find.byKey(SelectAnswer.itemKey)).toList();
      });

      describe("it's item is tapped", () {
        late Widget widget;
        late List<SurveyQuestionAnswerInfo> selected;

        beforeEach((tester) async {
          widget = widgets.first;
          onSelect = (item) {
            selected = item;
          };

          await tester.tap(find.byWidget(widget));
          await tester.pumpAndSettle();
        });

        it("triggers onSelect callback", (tester) async {
          expect(selected, [items.first]);
        });

        it("highlights tapped item", (tester) async {
          expect(
            find.descendant(
              of: find.byWidget(widget),
              matching: find.byKey(SelectAnswer.checkboxSelectedImageKey),
            ),
            findsNothing,
          );

          final text = tester.widget<Text>(
            find.descendant(
              of: find.byWidget(widget),
              matching: find.byKey(SelectAnswer.itemTextKey),
            ),
          );

          expect(text.style!.fontWeight, SelectAnswer.highlightFontWeight);
        });
      });
    });
  });
}
