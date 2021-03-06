import 'package:survey/models/survey_info.dart';
import 'package:survey/services/api/survey/survey_api_service.dart';
import 'package:survey/services/local_storage/local_storage_service.dart';
import 'package:survey/services/locator/locator_service.dart';

abstract class SurveyRepository {
  static const listLocalStorageKey = "survey_repository_list";

  Future<bool> get isSurveysCached;

  Future<List<SurveyInfo>> fetchSurveysFromCached();

  Future<List<SurveyInfo>> fetchSurveysFromRemote();
}

class SurveyRepositoryImpl implements SurveyRepository {
  final SurveyApiService _surveyApiService = locator.get();
  final LocalStorageService _localStorageService = locator.get();

  @override
  Future<bool> get isSurveysCached async {
    final items = await _localStorageService
        .getListObject<SurveyInfo>(SurveyRepository.listLocalStorageKey);
    return items != null;
  }

  @override
  Future<List<SurveyInfo>> fetchSurveysFromCached() async {
    final items = await _localStorageService
        .getListObject<SurveyInfo>(SurveyRepository.listLocalStorageKey);

    return items ?? [];
  }

  @override
  Future<List<SurveyInfo>> fetchSurveysFromRemote() async {
    // Fetch from server
    final list = await _surveyApiService.list(params: SurveyListParams());

    // Storage it
    _localStorageService.setListObject(
      list.items,
      key: SurveyRepository.listLocalStorageKey,
    );

    return list.items;
  }
}
