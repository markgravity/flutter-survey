part of '../../survey_questions_module.dart';

class SelectAnswer extends StatefulWidget {
  static const itemHeight = 50.0;

  const SelectAnswer({
    Key? key,
    required this.options,
    this.isMultiSelection = false,
    this.selectedIndexes = const [],
    this.onSelect,
  }) : super(key: key);

  final bool isMultiSelection;
  final List<int> selectedIndexes;
  final List<SurveyAnswerInfo> options;
  final ValueChanged<List<SurveyAnswerInfo>>? onSelect;

  @override
  _SelectAnswerState createState() => _SelectAnswerState();
}

class _SelectAnswerState extends State<SelectAnswer> {
  late final BehaviorSubject<List<int>> selectedIndexes;
  final disposeBag = CompositeSubscription();

  @override
  void didChangeDependencies() {
    selectedIndexes = BehaviorSubject<List<int>>.seeded(widget.selectedIndexes);
    selectedIndexes.listen(_onSelectedIndexesUpdate).addTo(disposeBag);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 60),
      height: SelectAnswer.itemHeight * 3,
      child: Stack(
        children: [
          ScrollSnapList(
            scrollDirection: Axis.vertical,
            curve: Curves.decelerate,
            duration: 1,
            itemSize: SelectAnswer.itemHeight,
            itemCount: widget.options.length,
            onItemFocus: _onItemFocus,
            itemBuilder: _itemBuilder,
            dynamicItemOpacity: widget.isMultiSelection ? 1 : 0.5,
          ),
          Align(
            child: SizedBox(
              height: SelectAnswer.itemHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 1,
                    color: Colors.white,
                  ),
                  Container(
                    height: 1,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int i) {
    return SizedBox(
      height: SelectAnswer.itemHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: StreamsSelector0<List<int>>.value(
              stream: selectedIndexes,
              builder: (_, selectedIndexes, __) {
                return Text(
                  widget.options[i].content!,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: selectedIndexes.contains(i)
                        ? FontWeight.w800
                        : FontWeight.normal,
                    fontSize: 20,
                  ),
                );
              },
            ),
          ),
          if (widget.isMultiSelection)
            GestureDetector(
              onTap: () => _onCheckboxTap(i),
              child: StreamsSelector0<List<int>>.value(
                stream: selectedIndexes,
                builder: (_, selectedIndexes, __) => selectedIndexes.contains(i)
                    ? Assets.images.roundedCheckboxSelected.svg()
                    : Assets.images.roundedCheckboxNormal.svg(),
              ),
            ),
        ],
      ),
    );
  }

  void _onCheckboxTap(int i) {
    final indexes = selectedIndexes.value.toList(growable: true);
    indexes.contains(i) ? indexes.remove(i) : indexes.add(i);
    selectedIndexes.add(indexes);
  }

  void _onItemFocus(int i) {
    if (widget.isMultiSelection) return;
    selectedIndexes.add([i]);
  }

  void _onSelectedIndexesUpdate(List<int> indexes) {
    if (widget.onSelect == null) return;
    widget.onSelect!(indexes.map((e) => widget.options[e]).toList());
  }

  @override
  void dispose() {
    disposeBag.dispose();
    super.dispose();
  }
}
