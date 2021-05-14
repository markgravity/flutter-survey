import 'package:object_mapper/object_mapper.dart';

class SurveyQuestionInfo with Mappable {
  String? id;
  String? content;
  int? displayOrder;
  SurveyQuestionPickType? pickType;
  SurveyQuestionDisplayType? displayType;
  bool? isMandatory;
  String? coverImageUrl;
  double? coverImageOpacity;

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
      (v) => content = v as String,
    );
    map<int>(
      "attributes.display_order",
      displayOrder,
      (v) => displayOrder = v as int,
    );
    map<SurveyQuestionPickType>(
      "attributes.pick",
      pickType,
      (v) => pickType = v as SurveyQuestionPickType?,
      const EnumTransform<SurveyQuestionPickType, String>(),
    );
    map<SurveyQuestionDisplayType>(
      "attributes.display_type",
      displayType,
      (v) => displayType = v as SurveyQuestionDisplayType?,
      const EnumTransform<SurveyQuestionDisplayType, String>(),
    );
    map<bool>(
      "attributes.is_mandatory",
      isMandatory,
      (v) => isMandatory = v as bool,
    );
    map<String>(
      "attributes.cover_image_url",
      coverImageUrl,
      (v) => coverImageUrl = v as String?,
    );
    map<double>(
      "attributes.cover_image_opacity",
      coverImageOpacity,
      (v) => coverImageOpacity = v as double?,
    );
  }
}

// ignore: avoid_implementing_value_types
class SurveyQuestionDisplayType extends Enumerable<String> {
  const SurveyQuestionDisplayType(this.rawValue);

  @override
  final String rawValue;

  static const intro = SurveyQuestionDisplayType("intro");
  static const star = SurveyQuestionDisplayType("star");
  static const heart = SurveyQuestionDisplayType("heart");
  static const smiley = SurveyQuestionDisplayType("smiley");
  static const choice = SurveyQuestionDisplayType("choice");
  static const nps = SurveyQuestionDisplayType("NPS");
  static const textarea = SurveyQuestionDisplayType("textarea");
  static const textField = SurveyQuestionDisplayType("textfield");
  static const outro = SurveyQuestionDisplayType("outro");
}

class SurveyQuestionPickType extends Enumerable<String> {
  const SurveyQuestionPickType(this.rawValue);

  @override
  final String rawValue;

  static const none = SurveyQuestionDisplayType("none");
  static const one = SurveyQuestionDisplayType("one");
  static const any = SurveyQuestionDisplayType("any");
}
