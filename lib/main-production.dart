import 'package:flutter/material.dart';
import 'app.dart';
import 'const/flavors.dart';

void main() {
  F.appFlavor = Flavor.PRODUCTION;
  runApp(App());
}
