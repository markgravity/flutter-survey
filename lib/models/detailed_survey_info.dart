import 'package:survey/models/survey_info.dart';
import 'package:survey/models/survey_question_info.dart';

// ignore: must_be_immutable
class DetailedSurveyInfo extends SurveyInfo {
  late List<SurveyQuestionInfo> questions;
}
