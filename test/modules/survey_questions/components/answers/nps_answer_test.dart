import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quick_test/quick_widget_test.dart';
import 'package:survey/app.dart';
import 'package:survey/models/survey_question_answer_info.dart';
import 'package:survey/modules/survey_questions/survey_questions_module.dart';

void main() {
  describe("a NPS Answer widget", () {
    final items = List<SurveyQuestionAnswerInfo>.empty(growable: true);
    for (int i = 0; i < 10; i++) {
      final item = SurveyQuestionAnswerInfo()..content = "$i";
      items.add(item);
    }

    beforeEach((tester) async {
      await tester.pumpWidget(
        App(
          overrideHome: NPSAnswer(items: items),
        ),
      );
      await tester.pumpAndSettle();
    });

    it("it's item text displays all unhighlight state", (tester) async {
      final widgets =
          tester.widgetList<Text>(find.byKey(NPSAnswer.itemTextKey));
      for (final widget in widgets) {
        expect(widget.style!.color, NPSAnswer.textNormalColor);
      }
    });

    it("displays correct select options", (tester) async {
      final widgets = tester.widgetList(find.byKey(NPSAnswer.itemKey));
      expect(widgets.length, items.length);
    });

    describe("it's item is tapped", () {
      late List<Widget> widgets;
      beforeEach((tester) async {
        widgets = tester.widgetList(find.byKey(NPSAnswer.itemKey)).toList();
      });

      context("when the first item is tapped", () {
        late Widget widget;

        beforeEach((tester) async {
          widget = widgets.first;
          await tester.tap(find.byWidget(widget));
          await tester.pumpAndSettle();
        });

        it("highlights the first item's text and lowest score text",
            (tester) async {
          final text =
              tester.widgetList<Text>(find.byKey(NPSAnswer.itemTextKey)).first;
          expect(text.style!.color, NPSAnswer.textHighlightColor);

          final scoreText =
              tester.widget<Text>(find.byKey(NPSAnswer.lowestScoreTextKey));
          expect(scoreText.style!.color, NPSAnswer.textHighlightColor);
        });
      });

      context("when a middle item is tapped", () {
        late Widget widget;
        final int pos = items.length ~/ 2;
        beforeEach((tester) async {
          widget = widgets[pos];
          await tester.tap(find.byWidget(widget));
          await tester.pumpAndSettle();
        });

        it("highlights the first item's text until the tapped item's text",
            (tester) async {
          final texts = tester
              .widgetList<Text>(find.byKey(NPSAnswer.itemTextKey))
              .toList();

          for (var i = 0; i < texts.length; i++) {
            final color = i <= pos
                ? NPSAnswer.textHighlightColor
                : NPSAnswer.textNormalColor;
            expect(texts[i].style!.color, color);
          }
        });
      });

      context("when the last item is tapped", () {
        late Widget widget;

        beforeEach((tester) async {
          widget = widgets.last;
          await tester.tap(find.byWidget(widget));
          await tester.pumpAndSettle();
        });

        it("highlights the last item's text and highest score text",
            (tester) async {
          final text =
              tester.widgetList<Text>(find.byKey(NPSAnswer.itemTextKey)).last;
          expect(text.style!.color, NPSAnswer.textHighlightColor);

          final scoreText =
              tester.widget<Text>(find.byKey(NPSAnswer.highestScoreTextKey));
          expect(scoreText.style!.color, NPSAnswer.textHighlightColor);
        });
      });
    });
  });
}
