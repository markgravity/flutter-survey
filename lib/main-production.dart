import 'package:flutter/material.dart';
import 'package:survey/gen/flavors.gen.dart';
import 'package:survey/app.dart';

void main() {
  Flavour.current = FlavorValue.production;
  runApp(App());
}
