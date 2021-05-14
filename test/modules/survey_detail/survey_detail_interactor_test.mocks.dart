// Mocks generated by Mockito 5.0.7 from annotations
// in survey/test/modules/survey_detail/survey_detail_interactor_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;

import 'package:mockito/mockito.dart' as _i1;
import 'package:rxdart/src/subjects/behavior_subject.dart' as _i2;
import 'package:survey/models/detailed_survey_info.dart' as _i3;
import 'package:survey/models/survey_info.dart' as _i7;
import 'package:survey/modules/survey_detail/survey_detail_module.dart' as _i4;
import 'package:survey/repositories/survey_repository.dart' as _i5;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

// ignore_for_file: prefer_const_constructors

// ignore_for_file: avoid_redundant_argument_values

class _FakeBehaviorSubject<T> extends _i1.Fake
    implements _i2.BehaviorSubject<T> {}

class _FakeDetailedSurveyInfo extends _i1.Fake
    implements _i3.DetailedSurveyInfo {}

/// A class which mocks [SurveyDetailInteractorDelegate].
///
/// See the documentation for Mockito's code generation for more information.
class MockSurveyDetailInteractorDelegate extends _i1.Mock
    implements _i4.SurveyDetailInteractorDelegate {
  MockSurveyDetailInteractorDelegate() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.BehaviorSubject<_i3.DetailedSurveyInfo> get detailedSurveyDidFetch =>
      (super.noSuchMethod(Invocation.getter(#detailedSurveyDidFetch),
              returnValue: _FakeBehaviorSubject<_i3.DetailedSurveyInfo>())
          as _i2.BehaviorSubject<_i3.DetailedSurveyInfo>);
  @override
  _i2.BehaviorSubject<Exception> get detailedSurveyDidFailToFetch =>
      (super.noSuchMethod(Invocation.getter(#detailedSurveyDidFailToFetch),
              returnValue: _FakeBehaviorSubject<Exception>())
          as _i2.BehaviorSubject<Exception>);
}

/// A class which mocks [SurveyRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockSurveyRepository extends _i1.Mock implements _i5.SurveyRepository {
  MockSurveyRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<bool> get isSurveysCached =>
      (super.noSuchMethod(Invocation.getter(#isSurveysCached),
          returnValue: Future<bool>.value(false)) as _i6.Future<bool>);
  @override
  _i6.Future<List<_i7.SurveyInfo>> fetchSurveys({bool? force}) =>
      (super.noSuchMethod(Invocation.method(#fetchSurveys, [], {#force: force}),
              returnValue:
                  Future<List<_i7.SurveyInfo>>.value(<_i7.SurveyInfo>[]))
          as _i6.Future<List<_i7.SurveyInfo>>);
  @override
  _i6.Future<_i3.DetailedSurveyInfo> fetchDetailedSurvey(String? id) =>
      (super.noSuchMethod(Invocation.method(#fetchDetailedSurvey, [id]),
              returnValue: Future<_i3.DetailedSurveyInfo>.value(
                  _FakeDetailedSurveyInfo()))
          as _i6.Future<_i3.DetailedSurveyInfo>);
}
