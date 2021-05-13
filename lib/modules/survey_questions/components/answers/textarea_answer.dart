part of '../../survey_questions_module.dart';

class TextFieldAnswer extends StatefulWidget {
  const TextFieldAnswer({
    Key? key,
    this.isMultiLines = false,
    this.onTextChange,
  }) : super(key: key);

  final bool isMultiLines;
  final ValueChanged<String>? onTextChange;

  @override
  _TextFieldAnswerState createState() => _TextFieldAnswerState();
}

class _TextFieldAnswerState extends State<TextFieldAnswer> {
  late final TextEditingController textController;
  @override
  void didChangeDependencies() {
    textController = TextEditingController();
    textController.addListener(() {
      if (widget.onTextChange == null) return;
      widget.onTextChange!(textController.text);
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformTextField(
      controller: textController,
      maxLines: widget.isMultiLines ? null : 1,
      minLines: widget.isMultiLines ? 10 : null,
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
