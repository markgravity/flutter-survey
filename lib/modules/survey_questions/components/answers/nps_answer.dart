part of '../../survey_questions_module.dart';

class NPSAnswer extends StatefulWidget {
  const NPSAnswer({
    Key? key,
    required this.items,
    this.score,
    this.onSelect,
  }) : super(key: key);

  final int? score;
  final List<SurveyQuestionAnswerInfo> items;
  final ValueChanged<SurveyQuestionAnswerInfo?>? onSelect;

  @override
  _NPSAnswerState createState() => _NPSAnswerState();
}

class _NPSAnswerState extends State<NPSAnswer> {
  late final selected = BehaviorSubject<int?>.seeded(
      widget.score != null ? widget.score! - 1 : null);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 56,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.items.length,
            itemBuilder: _itemBuilder,
            scrollDirection: Axis.horizontal,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StreamsSelector0<int?>.value(
                stream: selected,
                builder: (_, selected, __) => Text(
                  AppLocalizations.of(context)!
                      .surveyQuestionsScreenLowestScoreNPSText,
                  style: TextStyle(
                    color: selected == 0
                        ? Colors.white
                        : Colors.white.withOpacity(0.5),
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              StreamsSelector0<int?>.value(
                stream: selected,
                builder: (_, selected, __) => Text(
                  AppLocalizations.of(context)!
                      .surveyQuestionsScreenHighestScoreNPSText,
                  style: TextStyle(
                    color: selected == widget.items.length - 1
                        ? Colors.white
                        : Colors.white.withOpacity(0.5),
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _itemBuilder(BuildContext context, int i) {
    return GestureDetector(
      onTap: () {
        selected.add(i);
        if (widget.onSelect != null) widget.onSelect!(widget.items[i]);
      },
      child: SizedBox(
        width: 35,
        child: Row(
          children: [
            if (i != 0)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 1),
                color: Colors.white,
                width: 1,
              ),
            Expanded(
              child: StreamsSelector0<int?>.value(
                stream: selected,
                builder: (_, selected, __) => Text(
                  widget.items[i].content!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: selected != null && i <= selected
                        ? Colors.white
                        : Colors.white.withOpacity(0.5),
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
