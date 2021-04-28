import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:survey/gen/configs.gen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends StatelessWidget {
  final Widget? overrideHome;
  const App({this.overrideHome});

  @override
  Widget build(BuildContext context) {
    final routes = Configs.routes;
    if (overrideHome != null) {
      routes["/"] = (_) => overrideHome!;
    }

    if (defaultTargetPlatform == TargetPlatform.android) {
      return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routes: routes,
      );
    }

    return CupertinoApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routes: routes,
    );
  }
}
