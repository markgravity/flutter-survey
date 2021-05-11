part of '../survey_api_service.dart';

class SurveyListParams extends ApiParams {
  final int number;
  final int size;

  SurveyListParams({
    this.number = 1,
    this.size = 5,
  });

  @override
  void mapping(Mapper map) {
    map<int>("number", number, (v) {});
    map<int>("size", size, (v) {});
  }
}
