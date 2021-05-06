// Mocks generated by Mockito 5.0.5 from annotations
// in survey/test/screens/landing/landing_router_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i9;
import 'dart:ui' as _i11;

import 'package:flutter/foundation.dart';
import 'package:flutter/src/foundation/change_notifier.dart' as _i3;
import 'package:flutter/src/foundation/diagnostics.dart' as _i7;
import 'package:flutter/src/scheduler/ticker.dart' as _i6;
import 'package:flutter/src/services/restoration.dart' as _i8;
import 'package:flutter/src/widgets/focus_manager.dart' as _i2;
import 'package:flutter/src/widgets/framework.dart' as _i5;
import 'package:flutter/src/widgets/navigator.dart' as _i4;
import 'package:flutter/src/widgets/restoration.dart' as _i10;
import 'package:flutter/widgets.dart';
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

class _FakeFocusScopeNode extends _i1.Fake implements _i2.FocusScopeNode {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return super.toString();
  }
}

class _FakeValueNotifier<T> extends _i1.Fake implements _i3.ValueNotifier<T> {}

// ignore: avoid_implementing_value_types
class _FakeNavigator extends _i1.Fake implements _i4.Navigator {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return super.toString();
  }
}

class _FakeBuildContext extends _i1.Fake implements _i5.BuildContext {}

// ignore: avoid_implementing_value_types
class _FakeWidget extends _i1.Fake implements _i5.Widget {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return super.toString();
  }
}

class _FakeTicker extends _i1.Fake implements _i6.Ticker {
  @override
  String toString({bool debugIncludeStack = false}) {
    return super.toString();
  }
}

class _FakeDiagnosticsNode extends _i1.Fake implements _i7.DiagnosticsNode {
  @override
  String toString(
      {DiagnosticLevel minLevel = DiagnosticLevel.debug,
      TextTreeConfiguration? parentConfiguration}) {
    return super.toString();
  }
}

/// A class which mocks [NavigatorState].
///
/// See the documentation for Mockito's code generation for more information.
class MockNavigatorState extends _i1.Mock implements _i4.NavigatorState {
  MockNavigatorState() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.FocusScopeNode get focusScopeNode =>
      (super.noSuchMethod(Invocation.getter(#focusScopeNode),
          returnValue: _FakeFocusScopeNode()) as _i2.FocusScopeNode);
  @override
  _i3.ValueNotifier<bool> get userGestureInProgressNotifier =>
      (super.noSuchMethod(Invocation.getter(#userGestureInProgressNotifier),
          returnValue: _FakeValueNotifier<bool>()) as _i3.ValueNotifier<bool>);
  @override
  bool get userGestureInProgress =>
      (super.noSuchMethod(Invocation.getter(#userGestureInProgress),
          returnValue: false) as bool);
  @override
  bool get restorePending => (super
          .noSuchMethod(Invocation.getter(#restorePending), returnValue: false)
      as bool);
  @override
  _i4.Navigator get widget => (super.noSuchMethod(Invocation.getter(#widget),
      returnValue: _FakeNavigator()) as _i4.Navigator);
  @override
  _i5.BuildContext get context =>
      (super.noSuchMethod(Invocation.getter(#context),
          returnValue: _FakeBuildContext()) as _i5.BuildContext);
  @override
  bool get mounted =>
      (super.noSuchMethod(Invocation.getter(#mounted), returnValue: false)
          as bool);
  @override
  void initState() => super.noSuchMethod(Invocation.method(#initState, []),
      returnValueForMissingStub: null);
  @override
  void restoreState(_i8.RestorationBucket? oldBucket, bool? initialRestore) =>
      super.noSuchMethod(
          Invocation.method(#restoreState, [oldBucket, initialRestore]),
          returnValueForMissingStub: null);
  @override
  void didToggleBucket(_i8.RestorationBucket? oldBucket) =>
      super.noSuchMethod(Invocation.method(#didToggleBucket, [oldBucket]),
          returnValueForMissingStub: null);
  @override
  void didChangeDependencies() =>
      super.noSuchMethod(Invocation.method(#didChangeDependencies, []),
          returnValueForMissingStub: null);
  @override
  void didUpdateWidget(_i4.Navigator? oldWidget) =>
      super.noSuchMethod(Invocation.method(#didUpdateWidget, [oldWidget]),
          returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  _i9.Future<T?> pushNamed<T extends Object?>(String? routeName,
          {Object? arguments}) =>
      (super.noSuchMethod(
          Invocation.method(#pushNamed, [routeName], {#arguments: arguments}),
          returnValue: Future<T?>.value()) as _i9.Future<T?>);
  @override
  String restorablePushNamed<T extends Object?>(String? routeName,
          {Object? arguments}) =>
      (super.noSuchMethod(
          Invocation.method(
              #restorablePushNamed, [routeName], {#arguments: arguments}),
          returnValue: '') as String);
  @override
  _i9.Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
          String? routeName,
          {TO? result,
          Object? arguments}) =>
      (super.noSuchMethod(
          Invocation.method(#pushReplacementNamed, [routeName],
              {#result: result, #arguments: arguments}),
          returnValue: Future<T?>.value()) as _i9.Future<T?>);
  @override
  String restorablePushReplacementNamed<T extends Object?, TO extends Object?>(
          String? routeName,
          {TO? result,
          Object? arguments}) =>
      (super.noSuchMethod(
          Invocation.method(#restorablePushReplacementNamed, [routeName],
              {#result: result, #arguments: arguments}),
          returnValue: '') as String);

  // _i9.Future<T?> pushReplacementNamedWithoutAnimation<T extends Object?, TO extends Object?>(String routeName,
  //   {TO? result, Object? arguments}) =>
  //   (super.noSuchMethod(
  //     Invocation.method(
  //       #pushReplacementNamedWithoutAnimation, [routeName], {#result: result, #arguments: arguments}),
  //     returnValue: Future<T?>.value(null)) as _i9.Future<T?>);

  @override
  _i9.Future<T?> popAndPushNamed<T extends Object?, TO extends Object?>(
          String? routeName,
          {TO? result,
          Object? arguments}) =>
      (super.noSuchMethod(
          Invocation.method(#popAndPushNamed, [routeName],
              {#result: result, #arguments: arguments}),
          returnValue: Future<T?>.value()) as _i9.Future<T?>);
  @override
  String restorablePopAndPushNamed<T extends Object?, TO extends Object?>(
          String? routeName,
          {TO? result,
          Object? arguments}) =>
      (super.noSuchMethod(
          Invocation.method(#restorablePopAndPushNamed, [routeName],
              {#result: result, #arguments: arguments}),
          returnValue: '') as String);
  @override
  _i9.Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
          String? newRouteName, _i4.RoutePredicate? predicate,
          {Object? arguments}) =>
      (super.noSuchMethod(
          Invocation.method(#pushNamedAndRemoveUntil, [newRouteName, predicate],
              {#arguments: arguments}),
          returnValue: Future<T?>.value()) as _i9.Future<T?>);
  @override
  String restorablePushNamedAndRemoveUntil<T extends Object?>(
          String? newRouteName, _i4.RoutePredicate? predicate,
          {Object? arguments}) =>
      (super.noSuchMethod(
          Invocation.method(#restorablePushNamedAndRemoveUntil,
              [newRouteName, predicate], {#arguments: arguments}),
          returnValue: '') as String);
  @override
  _i9.Future<T?> push<T extends Object?>(_i4.Route<T>? route) =>
      (super.noSuchMethod(Invocation.method(#push, [route]),
          returnValue: Future<T?>.value()) as _i9.Future<T?>);
  @override
  String restorablePush<T extends Object?>(
          _i4.RestorableRouteBuilder<T>? routeBuilder,
          {Object? arguments}) =>
      (super.noSuchMethod(
          Invocation.method(
              #restorablePush, [routeBuilder], {#arguments: arguments}),
          returnValue: '') as String);
  @override
  _i9.Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
          _i4.Route<T>? newRoute,
          {TO? result}) =>
      (super.noSuchMethod(
          Invocation.method(#pushReplacement, [newRoute], {#result: result}),
          returnValue: Future<T?>.value()) as _i9.Future<T?>);
  @override
  String restorablePushReplacement<T extends Object?, TO extends Object?>(
          _i4.RestorableRouteBuilder<T>? routeBuilder,
          {TO? result,
          Object? arguments}) =>
      (super.noSuchMethod(
          Invocation.method(#restorablePushReplacement, [routeBuilder],
              {#result: result, #arguments: arguments}),
          returnValue: '') as String);
  @override
  _i9.Future<T?> pushAndRemoveUntil<T extends Object?>(
          _i4.Route<T>? newRoute, _i4.RoutePredicate? predicate) =>
      (super.noSuchMethod(
          Invocation.method(#pushAndRemoveUntil, [newRoute, predicate]),
          returnValue: Future<T?>.value()) as _i9.Future<T?>);
  @override
  String restorablePushAndRemoveUntil<T extends Object?>(
          _i4.RestorableRouteBuilder<T>? newRouteBuilder,
          _i4.RoutePredicate? predicate,
          {Object? arguments}) =>
      (super.noSuchMethod(
          Invocation.method(#restorablePushAndRemoveUntil,
              [newRouteBuilder, predicate], {#arguments: arguments}),
          returnValue: '') as String);
  @override
  void replace<T extends Object?>(
          {_i4.Route<dynamic>? oldRoute, _i4.Route<T>? newRoute}) =>
      super.noSuchMethod(
          Invocation.method(
              #replace, [], {#oldRoute: oldRoute, #newRoute: newRoute}),
          returnValueForMissingStub: null);
  @override
  String restorableReplace<T extends Object?>(
          {_i4.Route<dynamic>? oldRoute,
          _i4.RestorableRouteBuilder<T>? newRouteBuilder,
          Object? arguments}) =>
      (super.noSuchMethod(
          Invocation.method(#restorableReplace, [], {
            #oldRoute: oldRoute,
            #newRouteBuilder: newRouteBuilder,
            #arguments: arguments
          }),
          returnValue: '') as String);
  @override
  void replaceRouteBelow<T extends Object?>(
          {_i4.Route<dynamic>? anchorRoute, _i4.Route<T>? newRoute}) =>
      super.noSuchMethod(
          Invocation.method(#replaceRouteBelow, [],
              {#anchorRoute: anchorRoute, #newRoute: newRoute}),
          returnValueForMissingStub: null);
  @override
  String restorableReplaceRouteBelow<T extends Object?>(
          {_i4.Route<dynamic>? anchorRoute,
          _i4.RestorableRouteBuilder<T>? newRouteBuilder,
          Object? arguments}) =>
      (super.noSuchMethod(
          Invocation.method(#restorableReplaceRouteBelow, [], {
            #anchorRoute: anchorRoute,
            #newRouteBuilder: newRouteBuilder,
            #arguments: arguments
          }),
          returnValue: '') as String);
  @override
  bool canPop() =>
      (super.noSuchMethod(Invocation.method(#canPop, []), returnValue: false)
          as bool);
  @override
  _i9.Future<bool> maybePop<T extends Object?>([T? result]) =>
      (super.noSuchMethod(Invocation.method(#maybePop, [result]),
          returnValue: Future<bool>.value(false)) as _i9.Future<bool>);
  @override
  void pop<T extends Object?>([T? result]) =>
      super.noSuchMethod(Invocation.method(#pop, [result]),
          returnValueForMissingStub: null);
  @override
  void popUntil(_i4.RoutePredicate? predicate) =>
      super.noSuchMethod(Invocation.method(#popUntil, [predicate]),
          returnValueForMissingStub: null);
  @override
  void removeRoute(_i4.Route<dynamic>? route) =>
      super.noSuchMethod(Invocation.method(#removeRoute, [route]),
          returnValueForMissingStub: null);
  @override
  void removeRouteBelow(_i4.Route<dynamic>? anchorRoute) =>
      super.noSuchMethod(Invocation.method(#removeRouteBelow, [anchorRoute]),
          returnValueForMissingStub: null);
  @override
  void finalizeRoute(_i4.Route<dynamic>? route) =>
      super.noSuchMethod(Invocation.method(#finalizeRoute, [route]),
          returnValueForMissingStub: null);
  @override
  void didStartUserGesture() =>
      super.noSuchMethod(Invocation.method(#didStartUserGesture, []),
          returnValueForMissingStub: null);
  @override
  void didStopUserGesture() =>
      super.noSuchMethod(Invocation.method(#didStopUserGesture, []),
          returnValueForMissingStub: null);
  @override
  _i5.Widget build(_i5.BuildContext? context) =>
      (super.noSuchMethod(Invocation.method(#build, [context]),
          returnValue: _FakeWidget()) as _i5.Widget);
  @override
  _i6.Ticker createTicker(_i6.TickerCallback? onTick) =>
      (super.noSuchMethod(Invocation.method(#createTicker, [onTick]),
          returnValue: _FakeTicker()) as _i6.Ticker);
  @override
  void debugFillProperties(_i7.DiagnosticPropertiesBuilder? properties) =>
      super.noSuchMethod(Invocation.method(#debugFillProperties, [properties]),
          returnValueForMissingStub: null);
  @override
  void registerForRestoration(
          _i10.RestorableProperty<Object?>? property, String? restorationId) =>
      super.noSuchMethod(
          Invocation.method(#registerForRestoration, [property, restorationId]),
          returnValueForMissingStub: null);
  @override
  void unregisterFromRestoration(_i10.RestorableProperty<Object?>? property) =>
      super.noSuchMethod(
          Invocation.method(#unregisterFromRestoration, [property]),
          returnValueForMissingStub: null);
  @override
  void didUpdateRestorationId() =>
      super.noSuchMethod(Invocation.method(#didUpdateRestorationId, []),
          returnValueForMissingStub: null);
  @override
  void reassemble() => super.noSuchMethod(Invocation.method(#reassemble, []),
      returnValueForMissingStub: null);
  @override
  void setState(_i11.VoidCallback? fn) =>
      super.noSuchMethod(Invocation.method(#setState, [fn]),
          returnValueForMissingStub: null);
  @override
  void deactivate() => super.noSuchMethod(Invocation.method(#deactivate, []),
      returnValueForMissingStub: null);
  @override
  String toStringShort() => (super
          .noSuchMethod(Invocation.method(#toStringShort, []), returnValue: '')
      as String);
  @override
  String toString({_i7.DiagnosticLevel? minLevel = _i7.DiagnosticLevel.info}) =>
      (super.toString());
  @override
  _i7.DiagnosticsNode toDiagnosticsNode(
          {String? name, _i7.DiagnosticsTreeStyle? style}) =>
      (super.noSuchMethod(
          Invocation.method(
              #toDiagnosticsNode, [], {#name: name, #style: style}),
          returnValue: _FakeDiagnosticsNode()) as _i7.DiagnosticsNode);
}
