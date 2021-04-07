import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

class Screen extends StatelessWidget {
  final Widget body;
  Screen({this.body});

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return Scaffold(
        body: body,
      );
    }

    return CupertinoPageScaffold(
      child: body,
    );
  }
}
