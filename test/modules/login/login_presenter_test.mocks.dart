// Mocks generated by Mockito 5.0.7 from annotations
// in survey/test/modules/login/login_presenter_test.dart.
// Do not manually edit this file.

import 'package:flutter/src/widgets/framework.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:rxdart/src/subjects/behavior_subject.dart' as _i2;
import 'package:survey/modules/login/login_module.dart' as _i4;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

// ignore_for_file: prefer_const_constructors

// ignore_for_file: avoid_redundant_argument_values

class _FakeBehaviorSubject<T> extends _i1.Fake
    implements _i2.BehaviorSubject<T> {}

class _FakeBuildContext extends _i1.Fake implements _i3.BuildContext {}

/// A class which mocks [LoginView].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoginView extends _i1.Mock implements _i4.LoginView {
  MockLoginView() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.BehaviorSubject<bool> get isProgressHUDShown => (super.noSuchMethod(
      Invocation.getter(#isProgressHUDShown),
      returnValue: _FakeBehaviorSubject<bool>()) as _i2.BehaviorSubject<bool>);
  @override
  set delegate(_i4.LoginViewDelegate? _delegate) =>
      super.noSuchMethod(Invocation.setter(#delegate, _delegate),
          returnValueForMissingStub: null);
  @override
  _i3.BuildContext get context =>
      (super.noSuchMethod(Invocation.getter(#context),
          returnValue: _FakeBuildContext()) as _i3.BuildContext);
  @override
  void beginAnimation() =>
      super.noSuchMethod(Invocation.method(#beginAnimation, []),
          returnValueForMissingStub: null);
  @override
  void setLoginButton({bool? isEnabled}) => super.noSuchMethod(
      Invocation.method(#setLoginButton, [], {#isEnabled: isEnabled}),
      returnValueForMissingStub: null);
  @override
  void alert(Object? error) =>
      super.noSuchMethod(Invocation.method(#alert, [error]),
          returnValueForMissingStub: null);
  @override
  void showProgressHUD() =>
      super.noSuchMethod(Invocation.method(#showProgressHUD, []),
          returnValueForMissingStub: null);
  @override
  void dismissProgressHUD() =>
      super.noSuchMethod(Invocation.method(#dismissProgressHUD, []),
          returnValueForMissingStub: null);
}

/// A class which mocks [LoginInteractor].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoginInteractor extends _i1.Mock implements _i4.LoginInteractor {
  MockLoginInteractor() {
    _i1.throwOnMissingStub(this);
  }

  @override
  set delegate(_i4.LoginInteractorDelegate? _delegate) =>
      super.noSuchMethod(Invocation.setter(#delegate, _delegate),
          returnValueForMissingStub: null);
  @override
  void login(String? email, String? password) =>
      super.noSuchMethod(Invocation.method(#login, [email, password]),
          returnValueForMissingStub: null);
}

/// A class which mocks [LoginRouter].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoginRouter extends _i1.Mock implements _i4.LoginRouter {
  MockLoginRouter() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void replaceToHomeScreen(_i3.BuildContext? context) =>
      super.noSuchMethod(Invocation.method(#replaceToHomeScreen, [context]),
          returnValueForMissingStub: null);
  @override
  void pushToForgotPasswordScreen(_i3.BuildContext? context) => super
      .noSuchMethod(Invocation.method(#pushToForgotPasswordScreen, [context]),
          returnValueForMissingStub: null);
}