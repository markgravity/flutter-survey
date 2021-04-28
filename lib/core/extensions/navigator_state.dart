import 'package:flutter/cupertino.dart';
import 'package:survey/gen/configs.gen.dart';

extension NavigatorExtensions on NavigatorState {
  Future<T?> pushReplacementNamedWithoutAnimation<T extends Object?,
      TO extends Object?>(String routeName, {TO? result, Object? arguments}) {
    return pushReplacement(PageRouteBuilder(
      pageBuilder: (context, _, __) => Configs.routes[routeName]!(context),
      transitionDuration: const Duration(),
    ));
  }
}
