import 'package:object_mapper/object_mapper.dart';

class SurveySubmitAnswerInfo with Mappable {
  SurveySubmitAnswerInfo({required this.id, this.answer});

  String id;
  String? answer;

  @override
  void mapping(Mapper map) {
    map<String>("id", id, (v) => id = v as String);
    map<String>("answer", answer, (v) => answer = v as String?);
  }
}
