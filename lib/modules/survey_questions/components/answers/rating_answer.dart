part of '../../survey_questions_module.dart';

class RatingAnswer extends StatefulWidget {
  static const int numberOfItems = 5;
  static const double normalOpacity = 0.5;
  static const double highlightOpacity = 1;

  const RatingAnswer({
    Key? key,
    required this.symbol,
    this.selected,
    this.onSelect,
  }) : super(key: key);

  final String symbol;
  final int? selected;
  final ValueChanged<int?>? onSelect;

  @override
  _RatingAnswerState createState() => _RatingAnswerState();
}

class _RatingAnswerState extends State<RatingAnswer> {
  late final BehaviorSubject<int?> selected =
      BehaviorSubject.seeded(widget.selected);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: _itemBuilder,
        itemCount: RatingAnswer.numberOfItems,
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int i) =>
      StreamsSelector0<int?>.value(
        stream: selected,
        builder: (_, selected, child) {
          return Opacity(
            opacity: selected != null && i <= selected
                ? RatingAnswer.highlightOpacity
                : RatingAnswer.normalOpacity,
            child: child,
          );
        },
        child: GestureDetector(
          onTap: () {
            selected.add(i);

            if (widget.onSelect != null) {
              widget.onSelect!(i + 1);
            }
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(i == 0 ? 0 : 16, 0, 0, 0),
            child: Text(
              widget.symbol,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      );
}
