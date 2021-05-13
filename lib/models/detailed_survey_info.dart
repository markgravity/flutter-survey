import 'package:survey/models/survey_info.dart';
import 'package:survey/models/survey_question_info.dart';

class DetailedSurveyInfo extends SurveyInfo {
  List<SurveyQuestionInfo> questions = [];

  List<SurveyQuestionInfo> get orderedQuestions => questions.toList()
    ..sort((a, b) => a.displayOrder!.compareTo(b.displayOrder!));
}
