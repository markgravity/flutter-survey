import 'package:object_mapper/object_mapper.dart';
import 'package:survey/models/detailed_survey_info.dart';
import 'package:survey/models/survey_info.dart';
import 'package:survey/models/survey_question_info.dart';
import 'package:survey/services/api/api_service.dart';
import 'package:survey/services/http/http_service.dart';
import 'package:survey/services/locator/locator_service.dart';

part 'params/survey_list_params.dart';

part 'params/survey_info_params.dart';

abstract class SurveyApiService {
  static const endpoint = "/surveys";

  Future<DetailedSurveyInfo> info({required SurveyInfoParams params});

  Future<ApiListObject<SurveyInfo>> list({required SurveyListParams params});
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
    final included = (rawResponse.included ?? [])
        .where((element) => element.type == "question");

    for (final ApiRawObject rawObject in included) {
      questions.add(
          Mapper.fromJson(rawObject.toJson()).toObject<SurveyQuestionInfo>()!);
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
}
