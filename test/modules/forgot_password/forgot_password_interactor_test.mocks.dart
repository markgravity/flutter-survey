// Mocks generated by Mockito 5.0.7 from annotations
// in survey/test/modules/forgot_password/forgot_password_interactor_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:rxdart/src/subjects/behavior_subject.dart' as _i2;
import 'package:survey/modules/forgot_password/forgot_password_module.dart'
    as _i5;
import 'package:survey/repositories/auth_repository.dart' as _i3;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

// ignore_for_file: prefer_const_constructors

// ignore_for_file: avoid_redundant_argument_values

class _FakeBehaviorSubject<T> extends _i1.Fake
    implements _i2.BehaviorSubject<T> {}

/// A class which mocks [AuthRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthRepository extends _i1.Mock implements _i3.AuthRepository {
  MockAuthRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get isAuthenticated => (super
          .noSuchMethod(Invocation.getter(#isAuthenticated), returnValue: false)
      as bool);
  @override
  _i4.Future<void> login({String? email, String? password}) =>
      (super.noSuchMethod(
          Invocation.method(#login, [], {#email: email, #password: password}),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> logout() =>
      (super.noSuchMethod(Invocation.method(#logout, []),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> attempt() =>
      (super.noSuchMethod(Invocation.method(#attempt, []),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> fetchUser() =>
      (super.noSuchMethod(Invocation.method(#fetchUser, []),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> attemptAndFetchUser() =>
      (super.noSuchMethod(Invocation.method(#attemptAndFetchUser, []),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> resetPassword({String? email}) => (super.noSuchMethod(
      Invocation.method(#resetPassword, [], {#email: email}),
      returnValue: Future<void>.value(null),
      returnValueForMissingStub: Future.value()) as _i4.Future<void>);
}

/// A class which mocks [ForgotPasswordInteractorDelegate].
///
/// See the documentation for Mockito's code generation for more information.
class MockForgotPasswordInteractorDelegate extends _i1.Mock
    implements _i5.ForgotPasswordInteractorDelegate {
  MockForgotPasswordInteractorDelegate() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.BehaviorSubject<void> get passwordDidReset => (super.noSuchMethod(
      Invocation.getter(#passwordDidReset),
      returnValue: _FakeBehaviorSubject<void>()) as _i2.BehaviorSubject<void>);
  @override
  _i2.BehaviorSubject<Exception> get passwordDidFailToReset =>
      (super.noSuchMethod(Invocation.getter(#passwordDidFailToReset),
              returnValue: _FakeBehaviorSubject<Exception>())
          as _i2.BehaviorSubject<Exception>);
}
