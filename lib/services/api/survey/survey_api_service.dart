import 'package:object_mapper/object_mapper.dart';
import 'package:survey/models/survey_info.dart';
import 'package:survey/services/api/api_service.dart';
import 'package:survey/services/http/http_service.dart';
import 'package:survey/services/locator/locator_service.dart';

part 'params/survey_list_params.dart';

part 'params/survey_info_params.dart';

abstract class SurveyApiService {
  static const endpoint = "/surveys";

  Future<SurveyInfo> info({required SurveyInfoParams params});
  Future<ApiListObject<SurveyInfo>> list({required SurveyListParams params});
}

class SurveyApiServiceImpl implements SurveyApiService {
  final ApiService _apiService = locator.get();

  @override
  Future<SurveyInfo> info({required SurveyInfoParams params}) {
    return _apiService.call(
      method: HttpMethod.get,
      endpoint: "${SurveyApiService.endpoint}/${params.id}",
    );
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
