import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:survey/gen/configs.gen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return MaterialApp(
        routes: Configs.routes,
      );
    }

    return CupertinoApp(
      routes: Configs.routes,
    );
  }
}
