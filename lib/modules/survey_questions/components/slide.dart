part of '../survey_questions_module.dart';

class Slide extends StatelessWidget {
  Slide({
    Key? key,
    required this.questions,
    required this.index,
  }) : super(key: key);

  final List<SurveyQuestionInfo> questions;
  final int index;
  bool get _isLast => index == questions.length - 1;
  SurveyQuestionInfo get question => questions[index];
  final _answers = BehaviorSubject<List<SurveySubmitAnswerInfo>>.seeded([]);

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
                StreamsSelector0<bool>.value(
                  stream: _answers.map((event) =>
                      event.isNotEmpty || !(question.isMandatory ?? true)),
                  builder: (_, isEnabled, __) => Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Button(
                        key: SurveyQuestionsView.submitButtonKey,
                        onPressed: () => state.delegate?.submitButtonDidTap
                            .add(_answers.value),
                        title: _isLast
                            ? AppLocalizations.of(context)!
                                .surveyQuestionsScreenSubmitButtonTitle
                            : null,
                        borderRadius:
                            _isLast ? null : BorderRadius.circular(28),
                        width: _isLast ? null : 56,
                        height: _isLast ? null : 56,
                        isEnabled: isEnabled,
                        child: _isLast
                            ? null
                            : Assets.images.arrowRightIcon
                                .svg(fit: BoxFit.none),
                      ),
                    ],
                  ),
                ),
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
          onSelect: _onSelectSelect,
        );
      case SurveyQuestionDisplayType.heart:
        return RatingAnswer(
          symbol: "❤️",
          onSelect: _onRatingSelect,
        );
      case SurveyQuestionDisplayType.star:
        return RatingAnswer(
          symbol: "⭐️",
          onSelect: _onRatingSelect,
        );
      case SurveyQuestionDisplayType.smiley:
        return RatingAnswer(
          symbol: "😃",
          onSelect: _onRatingSelect,
        );
      case SurveyQuestionDisplayType.nps:
        return NPSAnswer(
          items: question.orderedAnswers.sublist(1),
          onSelect: _onNPSSelect,
        );
      case SurveyQuestionDisplayType.textarea:
        return TextFieldAnswer(
          isMultiLines: true,
          onTextChange: _onTextChange,
        );
      case SurveyQuestionDisplayType.textField:
        return TextFieldAnswer(
          onTextChange: _onTextChange,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  void _onSelectSelect(List<SurveyQuestionAnswerInfo> questionAnswer) {
    _answers.add(questionAnswer.map((e) => e.toAnswer()).toList());
  }

  void _onRatingSelect(int? i) {
    _answers.add([if (i != null) question.orderedAnswers[i - 1].toAnswer()]);
  }

  void _onNPSSelect(SurveyQuestionAnswerInfo? questionAnswer) {
    _answers.add([if (questionAnswer != null) questionAnswer.toAnswer()]);
  }

  void _onTextChange(String text) {
    _answers.add([question.orderedAnswers.first.toAnswer(text)]);
  }
}
