// Mocks generated by Mockito 5.0.7 from annotations
// in survey/test/modules/home/home_view_test.dart.
// Do not manually edit this file.

import 'package:mockito/mockito.dart' as _i1;
import 'package:rxdart/src/subjects/behavior_subject.dart' as _i2;
import 'package:survey/models/survey_info.dart' as _i4;
import 'package:survey/modules/home/home_module.dart' as _i3;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

// ignore_for_file: prefer_const_constructors

// ignore_for_file: avoid_redundant_argument_values

class _FakeBehaviorSubject<T> extends _i1.Fake
    implements _i2.BehaviorSubject<T> {}

/// A class which mocks [HomeViewDelegate].
///
/// See the documentation for Mockito's code generation for more information.
class MockHomeViewDelegate extends _i1.Mock implements _i3.HomeViewDelegate {
  MockHomeViewDelegate() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.BehaviorSubject<void> get stateDidInit => (super.noSuchMethod(
      Invocation.getter(#stateDidInit),
      returnValue: _FakeBehaviorSubject<void>()) as _i2.BehaviorSubject<void>);
  @override
  _i2.BehaviorSubject<_i4.SurveyInfo> get showDetailButtonDidTap =>
      (super.noSuchMethod(Invocation.getter(#showDetailButtonDidTap),
              returnValue: _FakeBehaviorSubject<_i4.SurveyInfo>())
          as _i2.BehaviorSubject<_i4.SurveyInfo>);
  @override
  _i2.BehaviorSubject<void> get didSwipeDown => (super.noSuchMethod(
      Invocation.getter(#didSwipeDown),
      returnValue: _FakeBehaviorSubject<void>()) as _i2.BehaviorSubject<void>);
  @override
  _i2.BehaviorSubject<void> get userAvatarDidTap => (super.noSuchMethod(
      Invocation.getter(#userAvatarDidTap),
      returnValue: _FakeBehaviorSubject<void>()) as _i2.BehaviorSubject<void>);
  @override
  _i2.BehaviorSubject<void> get sideMenuDidShow => (super.noSuchMethod(
      Invocation.getter(#sideMenuDidShow),
      returnValue: _FakeBehaviorSubject<void>()) as _i2.BehaviorSubject<void>);
  @override
  _i2.BehaviorSubject<void> get sideMenuDidDismiss => (super.noSuchMethod(
      Invocation.getter(#sideMenuDidDismiss),
      returnValue: _FakeBehaviorSubject<void>()) as _i2.BehaviorSubject<void>);
  @override
  _i2.BehaviorSubject<int> get currentPageDidChange => (super.noSuchMethod(
      Invocation.getter(#currentPageDidChange),
      returnValue: _FakeBehaviorSubject<int>()) as _i2.BehaviorSubject<int>);
  @override
  _i2.BehaviorSubject<void> get alertDialogDidClose => (super.noSuchMethod(
      Invocation.getter(#alertDialogDidClose),
      returnValue: _FakeBehaviorSubject<void>()) as _i2.BehaviorSubject<void>);
}
