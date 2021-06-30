part of 'survey_detail_module.dart';

abstract class SurveyDetailInteractorDelegate {
  BehaviorSubject<DetailedSurveyInfo> get detailedSurveyDidFetch;

  BehaviorSubject<Exception> get detailedSurveyDidFailToFetch;
}

abstract class SurveyDetailInteractor extends ArgumentsInteractor<
    SurveyDetailInteractorDelegate, SurveyDetailArguments> {
  SurveyInfo get survey;

  void fetchDetailedSurvey();
}

class SurveyDetailInteractorImpl extends SurveyDetailInteractor {
  final SurveyRepository _surveyRepository = locator.get();

  @override
  SurveyInfo get survey => arguments!.survey;

  @override
  void fetchDetailedSurvey() {
    _surveyRepository
        .fetchDetailedSurvey(survey.id!)
        .then((value) => delegate?.detailedSurveyDidFetch.add(value))
        .onError<Exception>((exception, _) =>
            delegate?.detailedSurveyDidFailToFetch.add(exception));
  }
}
