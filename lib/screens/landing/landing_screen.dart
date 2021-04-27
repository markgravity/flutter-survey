import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:survey/screens/screen.dart';

class LandingScreen extends StatelessWidget {
  static const path = "/";

  @override
  Widget build(BuildContext context) {
    return const Screen(
      body: Center(
        child: Text("Landing"),
      ),
    );
  }
}
