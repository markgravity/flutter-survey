part of 'survey_completed_module.dart';

abstract class SurveyCompletedViewDelegate {
  BehaviorSubject<void> get stateDidInit;

  BehaviorSubject<void> get animationDidFinish;

  BehaviorSubject<void> get animationDidLoad;
}

abstract class SurveyCompletedView extends View<SurveyCompletedViewDelegate> {
  void setOutro(SurveyQuestionInfo outro);

  void beginAnimation();
}

class SurveyCompletedViewImpl extends StatefulWidget {
  const SurveyCompletedViewImpl({Key? key}) : super(key: key);

  @override
  _SurveyCompletedViewImplState createState() =>
      _SurveyCompletedViewImplState();
}

class _SurveyCompletedViewImplState extends ViewState<SurveyCompletedViewImpl,
        SurveyCompletedModule, SurveyCompletedViewDelegate>
    with SingleTickerProviderStateMixin
    implements SurveyCompletedView {
  late final _animationController = AnimationController(vsync: this);
  final _outro = BehaviorSubject<SurveyQuestionInfo>();

  @override
  void initState() {
    super.initState();
    _animationController.addListener(() {
      if (_animationController.status != AnimationStatus.completed) return;
      delegate?.animationDidFinish.add(null);
    });

    delegate?.stateDidInit.add(null);
  }

  @override
  Widget build(BuildContext context) {
    return const Content();
  }

  @override
  void setOutro(SurveyQuestionInfo outro) {
    _outro.add(outro);
  }

  @override
  void beginAnimation() {
    _animationController.forward(from: 0);
  }
}
