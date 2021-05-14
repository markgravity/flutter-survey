part of 'survey_detail_module.dart';

abstract class SurveyDetailViewDelegate implements AlertViewMixinDelegate {
  BehaviorSubject<void> get stateDidInit;

  BehaviorSubject<void> get startSurveyButtonDidTap;
}

abstract class SurveyDetailView extends View<SurveyDetailViewDelegate>
    with ProgressHUDViewMixin, AlertViewMixin {
  static const backgroundImageKey = Key("background_image_");
  static const startSurveyButtonKey = Key("start_survey_button");

  void setSurvey(SurveyInfo survey);
}

class SurveyDetailViewImpl extends StatefulWidget {
  const SurveyDetailViewImpl({Key? key}) : super(key: key);

  @override
  _SurveyDetailViewImplState createState() => _SurveyDetailViewImplState();
}

class _SurveyDetailViewImplState extends ViewState<SurveyDetailViewImpl,
        SurveyDetailModule, SurveyDetailViewDelegate>
    with ProgressHUDViewMixin, AlertViewMixin
    implements SurveyDetailView {
  late final _survey = BehaviorSubject<SurveyInfo>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    delegate?.stateDidInit.add(null);
  }

  @override
  Widget build(BuildContext context) {
    return const Content();
  }

  @override
  void setSurvey(SurveyInfo survey) {
    _survey.add(survey);
  }
}
