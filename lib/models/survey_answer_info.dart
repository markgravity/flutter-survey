import 'package:object_mapper/object_mapper.dart';

class SurveyAnswerInfo with Mappable {
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
}
