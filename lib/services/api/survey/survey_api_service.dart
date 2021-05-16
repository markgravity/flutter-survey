import 'package:object_mapper/object_mapper.dart';
import 'package:survey/models/detailed_survey_info.dart';
import 'package:survey/models/survey_question_answer_info.dart';
import 'package:survey/models/survey_info.dart';
import 'package:survey/models/survey_question_info.dart';
import 'package:survey/services/api/api_service.dart';
import 'package:survey/services/api/survey/params/survey_submit_params.dart';
import 'package:survey/services/http/http_service.dart';
import 'package:survey/services/locator/locator_service.dart';

part 'params/survey_list_params.dart';

part 'params/survey_info_params.dart';

abstract class SurveyApiService {
  static const endpoint = "/surveys";

  Future<DetailedSurveyInfo> info({required SurveyInfoParams params});

  Future<ApiListObject<SurveyInfo>> list({required SurveyListParams params});

  Future<void> submit({required SurveySubmitParams params});
}

class SurveyApiServiceImpl implements SurveyApiService {
  final ApiService _apiService = locator.get();

  @override
  Future<DetailedSurveyInfo> info({required SurveyInfoParams params}) async {
    final rawResponse = await _apiService.call<ApiRawResponse>(
      method: HttpMethod.get,
      endpoint: "${SurveyApiService.endpoint}/${params.id}",
    );

    final info = Mapper.fromJson(rawResponse.data!.toJson())
        .toObject<DetailedSurveyInfo>()!;

    final questions = List<SurveyQuestionInfo>.empty(growable: true);

    // Get all answers
    final rawAnswers = (rawResponse.included ?? [])
        .where((element) => element.type == "answer");
    final allAnswers = List<SurveyQuestionAnswerInfo>.empty(growable: true);
    for (final rawObject in rawAnswers) {
      final answer = Mapper.fromJson(rawObject.toJson())
          .toObject<SurveyQuestionAnswerInfo>()!;
      allAnswers.add(answer);
    }

    // Get all questions
    final rawQuestions = (rawResponse.included ?? [])
        .where((element) => element.type == "question");
    for (final ApiRawObject rawObject in rawQuestions) {
      // Find all related answers for this question
      final answers = List<SurveyQuestionAnswerInfo>.empty(growable: true);
      if (rawObject.relationships?["answers"] != null &&
          rawObject.relationships?["answers"]["data"] != null &&
          rawObject.relationships?["answers"]["data"] is List<dynamic>) {
        for (final item in rawObject.relationships?["answers"]["data"]) {
          final answer = allAnswers
              .cast<SurveyQuestionAnswerInfo?>()
              .firstWhere((element) => element!.id == item["id"],
                  orElse: () => null);
          if (answer == null) continue;
          answers.add(answer);
        }
      }

      final question =
          Mapper.fromJson(rawObject.toJson()).toObject<SurveyQuestionInfo>()!;
      question.answers = answers;
      questions.add(question);
    }
    info.questions = questions;

    return info;
  }

  @override
  Future<ApiListObject<SurveyInfo>> list({required SurveyListParams params}) {
    return _apiService.callForList(
      method: HttpMethod.get,
      endpoint: SurveyApiService.endpoint,
      params: params,
    );
  }

  @override
  Future<void> submit({required SurveySubmitParams params}) {
    return _apiService.callForList(
      method: HttpMethod.post,
      endpoint: "/responses",
      params: params,
    );
  }
}
