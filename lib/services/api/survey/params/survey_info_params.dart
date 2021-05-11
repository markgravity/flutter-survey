part of '../survey_api_service.dart';

class SurveyInfoParams extends ApiParams {
  final String id;

  SurveyInfoParams({
    required this.id,
  });

  @override
  void mapping(Mapper map) {
    map("id", id, (v) {});
  }
}
