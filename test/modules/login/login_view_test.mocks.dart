// Mocks generated by Mockito 5.0.7 from annotations
// in survey/test/modules/login/login_view_test.dart.
// Do not manually edit this file.

import 'package:mockito/mockito.dart' as _i1;
import 'package:rxdart/src/subjects/behavior_subject.dart' as _i2;
import 'package:survey/modules/login/login_module.dart' as _i3;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

// ignore_for_file: prefer_const_constructors

// ignore_for_file: avoid_redundant_argument_values

class _FakeBehaviorSubject<T> extends _i1.Fake
    implements _i2.BehaviorSubject<T> {}

/// A class which mocks [LoginViewDelegate].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoginViewDelegate extends _i1.Mock implements _i3.LoginViewDelegate {
  MockLoginViewDelegate() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.BehaviorSubject<void> get forgotButtonDidTap => (super.noSuchMethod(
      Invocation.getter(#forgotButtonDidTap),
      returnValue: _FakeBehaviorSubject<void>()) as _i2.BehaviorSubject<void>);
  @override
  _i2.BehaviorSubject<void> get stateDidInit => (super.noSuchMethod(
      Invocation.getter(#stateDidInit),
      returnValue: _FakeBehaviorSubject<void>()) as _i2.BehaviorSubject<void>);
  @override
  _i2.BehaviorSubject<String> get emailTextFieldDidChange =>
      (super.noSuchMethod(Invocation.getter(#emailTextFieldDidChange),
              returnValue: _FakeBehaviorSubject<String>())
          as _i2.BehaviorSubject<String>);
  @override
  _i2.BehaviorSubject<String> get passwordTextFieldDidChange =>
      (super.noSuchMethod(Invocation.getter(#passwordTextFieldDidChange),
              returnValue: _FakeBehaviorSubject<String>())
          as _i2.BehaviorSubject<String>);
  @override
  _i2.BehaviorSubject<List<String>> get loginButtonDidTap =>
      (super.noSuchMethod(Invocation.getter(#loginButtonDidTap),
              returnValue: _FakeBehaviorSubject<List<String>>())
          as _i2.BehaviorSubject<List<String>>);
  @override
  _i2.BehaviorSubject<void> get alertDialogDidClose => (super.noSuchMethod(
      Invocation.getter(#alertDialogDidClose),
      returnValue: _FakeBehaviorSubject<void>()) as _i2.BehaviorSubject<void>);
}
