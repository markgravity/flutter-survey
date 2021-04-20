import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:survey/screens/screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Screen(
      body: Center(
        child: Text(AppLocalizations.of(context)?.helloWorld ?? ""),
      ),
    );
  }
}
