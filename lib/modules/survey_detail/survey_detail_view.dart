part of 'survey_detail_module.dart';

abstract class SurveyDetailViewDelegate {}

abstract class SurveyDetailView extends View<SurveyDetailViewDelegate> {}

class SurveyDetailViewImpl extends StatefulWidget {
  const SurveyDetailViewImpl({Key? key}) : super(key: key);

  @override
  _SurveyDetailViewImplState createState() => _SurveyDetailViewImplState();
}

class _SurveyDetailViewImplState extends ViewState<SurveyDetailViewImpl,
    SurveyDetailModule, SurveyDetailViewDelegate> implements SurveyDetailView {
  @override
  Widget build(BuildContext context) {
    return const Content();
  }
}
