import 'package:object_mapper/object_mapper.dart';
import 'package:survey/models/survey_submit_answer_info.dart';

class SurveyQuestionAnswerInfo with Mappable {
  String? id;
  String? content;
  int? displayOrder;

  @override
  void mapping(Mapper map) {
    map<String>(
      "id",
      id,
      (v) => id = v as String,
    );
    map<String>(
      "attributes.text",
      content,
      (v) => content = v as String?,
    );
    map<int>(
      "attributes.display_order",
      displayOrder,
      (v) => displayOrder = v as int,
    );
  }

  SurveySubmitAnswerInfo toAnswer([String? answer]) {
    return SurveySubmitAnswerInfo(id: id!, answer: answer);
  }
}
