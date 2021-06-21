import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

class Screen extends StatelessWidget {
  final Widget body;
  final SystemUiOverlayStyle statusBarStyle;

  const Screen({
    required this.body,
    this.statusBarStyle = SystemUiOverlayStyle.light,
  });

  @override
  Widget build(BuildContext context) {
    Widget? child;

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        child = Scaffold(
          resizeToAvoidBottomInset: false,
          body: body,
        );
        break;
      default:
        child = CupertinoPageScaffold(
          resizeToAvoidBottomInset: false,
          child: body,
        );
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: statusBarStyle,
      child: child,
    );
  }
}
