part of '../survey_questions_module.dart';

class Slide extends StatelessWidget {
  const Slide({
    Key? key,
    required this.questions,
    required this.index,
  }) : super(key: key);

  final List<SurveyQuestionInfo> questions;
  final int index;
  bool get _isLast => index == questions.length - 1;
  SurveyQuestionInfo get question => questions[index];

  @override
  Widget build(BuildContext context) {
    final state =
        context.findAncestorStateOfType<_SurveyQuestionsViewImplState>()!;
    final box = state._navigationBarKey.currentContext?.findRenderObject()
        as RenderBox?;
    return Stack(
      fit: StackFit.expand,
      children: [
        Opacity(
          opacity: question.coverImageOpacity!,
          child: Image(
            image: NetworkImage(question.coverImageUrl!),
            fit: BoxFit.fill,
          ),
        ),
        SafeArea(
          child: Container(
            margin: EdgeInsets.fromLTRB(20, box?.size.height ?? 0, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${index + 1}/${questions.length}",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  question.content!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: _makeAnswer(),
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  if (_isLast)
                    Button(
                      title: AppLocalizations.of(context)!
                          .surveyQuestionsScreenSubmitButtonTitle,
                    )
                  else
                    PlatformButton(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          color: question.isMandatory ?? false
                              ? Colors.grey
                              : Colors.white,
                        ),
                        width: 56,
                        height: 56,
                        child:
                            Assets.images.arrowRightIcon.svg(fit: BoxFit.none),
                      ),
                    ),
                ]),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _makeAnswer() {
    switch (question.displayType) {
      case SurveyQuestionDisplayType.choice:
        return SelectAnswer(
          options: question.orderedAnswers,
          isMultiSelection: question.pickType == SurveyQuestionPickType.any,
        );
      case SurveyQuestionDisplayType.heart:
        return const RatingAnswer(symbol: "❤️");
      case SurveyQuestionDisplayType.star:
        return const RatingAnswer(symbol: "⭐️");
      case SurveyQuestionDisplayType.smiley:
        return const RatingAnswer(symbol: "😃");
      case SurveyQuestionDisplayType.nps:
        return NPSAnswer(
          items: question.orderedAnswers.sublist(1),
        );
      case SurveyQuestionDisplayType.textarea:
        return const TextFieldAnswer(
          isMultiLines: true,
        );
      case SurveyQuestionDisplayType.textField:
        return const TextFieldAnswer();
      default:
        return const SizedBox.shrink();
    }
  }
}
