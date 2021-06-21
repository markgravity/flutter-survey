// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:survey/gen/flavors.gen.dart';
import 'package:survey/app.dart';
import 'package:survey/bootstrap.dart';

void main() {
  Flavour.current = FlavorValue.staging;
  bootstrap();
  runApp(const App());
}
