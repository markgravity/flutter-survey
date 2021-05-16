import 'package:object_mapper/object_mapper.dart';
import 'package:survey/models/survey_question_answer_info.dart';

class SurveyQuestionInfo with Mappable {
  String? id;
  String? content;
  int? displayOrder;
  SurveyQuestionPickType? pickType;
  SurveyQuestionDisplayType? displayType;
  bool? isMandatory;
  String? coverImageUrl;
  double? coverImageOpacity;
  List<SurveyQuestionAnswerInfo> answers = [];
  List<SurveyQuestionAnswerInfo> get orderedAnswers => answers.toList()
    ..sort((a, b) => a.displayOrder!.compareTo(b.displayOrder!));

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
  factory SurveyQuestionDisplayType(String rawValue) =>
      Enumerable.factory(values, rawValue);

  const SurveyQuestionDisplayType._(this.rawValue);

  @override
  final String rawValue;

  static const intro = SurveyQuestionDisplayType._("intro");
  static const star = SurveyQuestionDisplayType._("star");
  static const heart = SurveyQuestionDisplayType._("heart");
  static const smiley = SurveyQuestionDisplayType._("smiley");
  static const choice = SurveyQuestionDisplayType._("choice");
  static const nps = SurveyQuestionDisplayType._("nps");
  static const textarea = SurveyQuestionDisplayType._("textarea");
  static const textField = SurveyQuestionDisplayType._("textfield");
  static const outro = SurveyQuestionDisplayType._("outro");

  static List<SurveyQuestionDisplayType> values = [
    intro,
    star,
    heart,
    smiley,
    choice,
    nps,
    textField,
    textarea,
    outro,
  ];
}

class SurveyQuestionPickType extends Enumerable<String> {
  factory SurveyQuestionPickType(String rawValue) =>
      Enumerable.factory(values, rawValue);

  const SurveyQuestionPickType._(this.rawValue);

  @override
  final String rawValue;

  static const none = SurveyQuestionPickType._("none");
  static const one = SurveyQuestionPickType._("one");
  static const any = SurveyQuestionPickType._("any");

  static List<SurveyQuestionPickType> values = [
    none,
    one,
    any,
  ];
}
