import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:survey/configs/routes.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    if(Platform.isAndroid) {
      return MaterialApp(
        routes: routes,
      );
    }

    return CupertinoApp(
      routes: routes,
    );
  }
}
