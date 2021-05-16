import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quick_test/quick_widget_test.dart';
import 'package:survey/app.dart';
import 'package:survey/modules/screen.dart';
import 'package:survey/modules/survey_questions/survey_questions_module.dart';

void main() {
  describe("a RatingAnswer widget", () {
    ValueChanged<String> onTextChange = (i) {};

    beforeEach((tester) async {
      await tester.pumpWidget(
        App(
          overrideHome: Screen(
            body: TextFieldAnswer(
              onTextChange: (i) => onTextChange(i),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
    });

    describe("it's text field is inputted", () {
      const text = "a text";
      late String output;

      beforeEach((tester) async {
        onTextChange = (value) => output = value;
        await tester.enterText(find.byKey(TextFieldAnswer.textFieldKey), text);
        await tester.pumpAndSettle();
      });

      it("triggers onTextChange() callback", (tester) async {
        expect(output, text);
      });
    });
  });
}
