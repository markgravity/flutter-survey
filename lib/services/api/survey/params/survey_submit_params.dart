import 'package:object_mapper/object_mapper.dart';
import 'package:survey/models/survey_submit_question_info.dart';
import 'package:survey/services/api/api_service.dart';

class SurveySubmitParams extends ApiParams {
  SurveySubmitParams({
    required this.surveyId,
    required this.questions,
  });

  final String surveyId;
  final List<SurveySubmitQuestionInfo> questions;

  @override
  void mapping(Mapper map) {
    map<String>("survey_id", surveyId, (v) {});
    map<SurveySubmitQuestionInfo>("questions", questions, (v) {});
  }
}
