import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:survey/core/environment.dart';

class Screen extends StatelessWidget {
  final Widget body;
  Screen({this.body});

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return Scaffold(
        body: body,
      );
    }

    return CupertinoPageScaffold(
      child: body,
    );
  }
}
