part of 'survey_completed_module.dart';

abstract class SurveyCompletedViewDelegate {}

abstract class SurveyCompletedView extends View<SurveyCompletedViewDelegate> {}

class SurveyCompletedViewImpl extends StatefulWidget {
  const SurveyCompletedViewImpl({Key? key}) : super(key: key);

  @override
  _SurveyCompletedViewImplState createState() => _SurveyCompletedViewImplState();
}

class _SurveyCompletedViewImplState
    extends ViewState<SurveyCompletedViewImpl, SurveyCompletedModule, SurveyCompletedViewDelegate>
    implements SurveyCompletedView {
  @override
  Widget build(BuildContext context) {
    return const Screen(
      body: Center(
        child: Text("Survey Completed"),
      ),
    );
  }
}
