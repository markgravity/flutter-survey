// Mocks generated by Mockito 5.0.7 from annotations
// in survey/test/modules/landing/landing_interactor_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:rxdart/src/subjects/behavior_subject.dart' as _i2;
import 'package:survey/modules/landing/landing_module.dart' as _i5;
import 'package:survey/services/auth/auth_service.dart' as _i3;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

// ignore_for_file: prefer_const_constructors

// ignore_for_file: avoid_redundant_argument_values

class _FakeBehaviorSubject<T> extends _i1.Fake
    implements _i2.BehaviorSubject<T> {}

/// A class which mocks [AuthService].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthService extends _i1.Mock implements _i3.AuthService {
  MockAuthService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get isAuthenticated => (super
          .noSuchMethod(Invocation.getter(#isAuthenticated), returnValue: false)
      as bool);
  @override
  _i4.Future<void> login({_i3.AuthLoginParams? params}) =>
      (super.noSuchMethod(Invocation.method(#login, [], {#params: params}),
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
}

/// A class which mocks [LandingInteractorDelegate].
///
/// See the documentation for Mockito's code generation for more information.
class MockLandingInteractorDelegate extends _i1.Mock
    implements _i5.LandingInteractorDelegate {
  MockLandingInteractorDelegate() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.BehaviorSubject<bool> get authenticationDidValidate =>
      (super.noSuchMethod(Invocation.getter(#authenticationDidValidate),
              returnValue: _FakeBehaviorSubject<bool>())
          as _i2.BehaviorSubject<bool>);
  @override
  _i2.BehaviorSubject<Object> get authenticationDidFailToValidate =>
      (super.noSuchMethod(Invocation.getter(#authenticationDidFailToValidate),
              returnValue: _FakeBehaviorSubject<Object>())
          as _i2.BehaviorSubject<Object>);
}
