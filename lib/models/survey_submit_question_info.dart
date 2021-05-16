import 'package:object_mapper/object_mapper.dart';
import 'package:survey/models/survey_submit_answer_info.dart';

class SurveySubmitQuestionInfo with Mappable {
  const SurveySubmitQuestionInfo({
    required this.questionId,
    required this.answers,
  });

  final String questionId;
  final List<SurveySubmitAnswerInfo> answers;

  @override
  void mapping(Mapper map) {
    map<String>("id", questionId, (v) {});
    map<SurveySubmitAnswerInfo>("answers", answers, (v) {});
  }
}
