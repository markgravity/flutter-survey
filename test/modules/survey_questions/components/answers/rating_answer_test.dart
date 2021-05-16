import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quick_test/quick_widget_test.dart';
import 'package:survey/app.dart';
import 'package:survey/modules/survey_questions/survey_questions_module.dart';

void main() {
  describe("a RatingAnswer widget", () {
    const symbol = "heart";
    late List<Widget> widgets;
    ValueChanged<int?> onSelect = (i) {};

    beforeEach((tester) async {
      await tester.pumpWidget(
        App(
          overrideHome: RatingAnswer(
            symbol: symbol,
            onSelect: (i) => onSelect(i),
          ),
        ),
      );
      await tester.pumpAndSettle();
      widgets = tester.widgetList(find.text(symbol)).toList();
    });

    it("displays correct number of symbols", (tester) async {
      expect(widgets.length, RatingAnswer.numberOfItems);
    });

    describe("it's item is tapped", () {
      final int pos = RatingAnswer.numberOfItems ~/ 2;
      late int? selected;

      beforeEach((tester) async {
        onSelect = (i) {
          selected = i;
        };

        await tester.tap(find.byWidget(widgets[pos]));
        await tester.pumpAndSettle();
      });

      it("triggers onSelect() callback", (tester) async {
        expect(selected, pos + 1);
      });

      it("highlights item from the first until the tapped item",
          (tester) async {
        for (int i = 0; i < widgets.length; i++) {
          final opacity = i <= pos
              ? RatingAnswer.highlightOpacity
              : RatingAnswer.normalOpacity;
          final widget = tester.widget<Opacity>(
            find.ancestor(
              of: find.byWidget(widgets[i]),
              matching: find.byType(Opacity),
            ),
          );

          expect(widget.opacity, opacity);
        }
      });
    });
  });
}
